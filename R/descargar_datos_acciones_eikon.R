#' Descargar datos de acciones vía Refinitiv Eikon, desde fecha especificada hasta hoy.
#'
#' @param rics lista de rics a descargar
#' @param start_date_eikon_df fecha inicial de los datos a descargar
#' @param verbose argumento "verbose" pasado a Refinitiv::EikonGetData
#' @param raw_output argumento "raw_output" pasado a Refinitiv::EikonGetData
#' @keywords descargar datos eikon acciones
#' @export
#' @examples descargar_datos_acciones_eikon(rics = c("SABE.MC", "BBVA.MC"), start_date_eikon_df=as.Date("2024-04-29"))
#' descargar_datos_acciones_eikon()

descargar_datos_acciones_eikon <- function(rics, start_date_eikon_df, verbose=FALSE, raw_output=FALSE) {

  tryCatch({

    eikon_compraventavalores_api_key <- Sys.getenv("EIKON_API_KEY")
    if(length(eikon_compraventavalores_api_key) == 0) {
      stop("Variable de entorno EIKON_API_KEY está vacía. Necesario crear API key con APPKEY en Refinitiv.")
    }

    Eikon_handler <- Refinitiv::EikonConnect(
      Eikonapplication_id = eikon_compraventavalores_api_key,
      Eikonapplication_port = 9000L,
      PythonModule = "JSON"
    )

    datos_df <- Refinitiv::EikonGetData(
      EikonObject = Eikon_handler,
      # rics = c(
      #   "BBVA.MC",
      #   "SABE.MC"
      # ),
      rics=rics,
      Eikonformulas=c(
        paste0('TR.CLOSEPRICE(SDate=', '"', start_date_eikon_df |> format("%Y-%m-%d"), '", EDate=1D)'),
        paste0('TR.SharesOutstanding(SDate=', '"', start_date_eikon_df |> format("%Y-%m-%d"), '", EDate=1D)'),
        paste0('TR.VOLUME(SDate=', '"', start_date_eikon_df |> format("%Y-%m-%d"), '", EDate=1D)'),
        paste0('TR.TURNOVER(SDate=', '"', start_date_eikon_df |> format("%Y-%m-%d"), '", EDate=1D)')
      ),
      Parameters = list(
      ),
      verbose=verbose,
      raw_output=raw_output
    ) |> _$PostProcessedEikonGetData

    fechas_añadir <- seq(from=start_date_eikon_df,
                         to=lubridate::today() |> as.Date(),
                         by="1 day")

    # eliminando fechas con la bolsa cerrada y fines de semana
    fechas_añadir <- fechas_añadir[!fechas_añadir %in% fechas_cierre_bolsa_2024 & !weekdays(fechas_añadir) %in% c("sábado", "domingo")]

    datos_df$fecha <- rep(fechas_añadir,length(rics))

    datos_df <- datos_df |>
      dplyr::filter(fecha != lubridate::today()) |>
      dplyr::rename(
        nombres = Instrument,
        precio = Close.Price,
        outstanding = Outstanding.Shares,
        volumen = Volume,
        rotacion = Turnover
      ) |>
      dplyr::relocate(fecha)

    datos_hoy_df <- Refinitiv::EikonGetData(
      EikonObject = Eikon_handler,
      rics = c(
        "BBVA.MC",
        "SABE.MC"
      ),
      # Eikonformulas='=TR("TR.CLOSEPRICE; TR.TURNOVER; TR.MARKETCAPITALISATION; TR.Volume; LOT_SIZE","Frq=D SDate=2024-04-29 EDate=2024-05-21 CH=Fd RH=IN")'
      # Eikonformulas='TR.CLOSEPRICE(SDate=2024-04-29, EDate=2024-05-21, CH=Fd, RH=IN)'
      Eikonformulas=c(
        "CF_DATE",
        "CF_LAST",
        # "CF_CLOSE", # coge el de cierre del día anterior
        "CF_VOLUME",
        "TR.TURNOVER",
        "TR.SharesOutstanding"
      ),
      Parameters = c(
        # "SDate"="2024-04-29",
        # "SDate"="-5D",
        # "EDate"="1D"
      ),
      verbose=verbose,
      raw_output=raw_output
    ) |>
      _$PostProcessedEikonGetData |>
      dplyr::rename(precio = CF_LAST,
             volumen = CF_VOLUME,
             nombres = Instrument,
             rotacion = Turnover,
             outstanding = Outstanding.Shares
      )  |>
      dplyr::mutate(fecha = as.Date(CF_DATE)) |>
      dplyr::select(-CF_DATE)
  },
  error = function(e) {message("Error descargando de refinitiv: ", e)})

  datos_df <- dplyr::as_tibble(datos_df)

  datos_df <- datos_df |>
    dplyr::bind_rows(datos_hoy_df)

  return(datos_df)

}
