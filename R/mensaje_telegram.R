#' Enviar un mensaje de Telegram vía bot de sganalisisfinanciero
#'
#' @param plot_ggplot objeto ggplot con el gráfico original
#' @keywords generar grafico plotly
#' @export
#' @examples
#' mensaje_telegram()
#'
mensaje_telegram <- function(bot,
                             mensaje) {

  # extraemos lista de ids
  chat_id_list <- as.double(stringr::str_split(Sys.getenv("R_TELEGRAM_BOT_CHAT_IDS")[[1]], ";")[[1]])

  if(is.null(bot)) {
    message("No se ha inicializado el bot.")
    message("Ejecutar:\bot_instance <- tesorotools::iniciar_telegram()\ntesorotools::mensaje_telegram(bot, MENSAJE")
    return()
  }

  message(mensaje)

  for(chat_id in chat_id_list) {
    bot$send_message(chat_id=chat_id,
                     text=mensaje)
  }

}
