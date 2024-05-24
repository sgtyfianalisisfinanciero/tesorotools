#' Inicia el bot de telegram
#'
#' @param plot_ggplot objeto ggplot con el gráfico original
#' @keywords generar grafico plotly
#' @export
#' @examples
#' mensaje_telegram()
#'
iniciar_telegram <- function() {

  telegram_bot_token <- Sys.getenv("R_TELEGRAM_BOT_Sganalisisfinanciero_bot")
  if(is.null(telegram_bot_token) | telegram_bot_token == "") {
    message("No se ha especificado token para bot de telegram")
    return()
  }

  bot <- telegram.bot::Bot(token = telegram_bot_token)

  return(bot)

}
