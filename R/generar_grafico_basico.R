#' Generar un gráfico básico de líneas a partir de un tibble en formato long.
#'
#' @param datos tibble con los datos
#' @param .accuracy decimales, por defecto 0.1
#' @param .scale escala, por defecto 1
#' @param .suffix sufijo a añadir a los ejes y etiquetas
#' @param .big.mark marcador de miles, por defecto "."
#' @param .decimal.mark marcador de decimales, por defecto ","
#' @keywords generar grafico simple
#' @export
#' @examples
#' generar_grafico_basico()

generar_grafico_basico <- function(datos,
                                   .accuracy=0.1,
                                   .scale=1,
                                   .suffix="",
                                   .big.mark=".",
                                   .decimal.mark=",") {

  datos_df <- datos %>%
    mutate(Fecha = paste0(fecha, "\n",
                          nombres, ": ", scales::number_format(accuracy=.accuracy,
                                                               scale=.scale,
                                                               suffix=.suffix,
                                                               big.mark=.big.mark,
                                                               decimal.mark=.decimal.mark)(valores)))

  grafico <- ggplot(data=datos_df,
                    mapping=aes(x=fecha,
                                y=valores,
                                color=nombres,
                                label=Fecha)) +
    geom_line(linewidth=1)+
    tema_gabinete +
    scale_color_manual(values = colores_new[1:nrow(datos %>% distinct(nombres))]) +
    scale_x_date(date_labels = "%Y",
                 date_breaks = "1 year") +
    scale_y_continuous(labels = scales::number_format(accuracy=.accuracy,
                                                      scale=.scale,
                                                      suffix=.suffix,
                                                      big.mark=.big.mark,
                                                      decimal.mark=.decimal.mark),
                       limits=c(min(datos_df$valores) - 0.2,
                                max(datos_df$valores) + 0.2),
                       position="right")

  return(grafico)
}
