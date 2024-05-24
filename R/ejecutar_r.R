#' Ejecutar un archivo de R, comprobando resultado y notificando en Telegram
#'
#' @param plot_ggplot objeto ggplot con el gráfico original
#' @keywords generar grafico plotly
#' @export
#' @examples
#' ejecutar_r()
#'
ejecutar_r <- function(.bot_telegram, .archivo) {

  source_return_value <- F

  source(.archivo, local=TRUE)
  if(source_return_value) {
    tesorotools::mensaje_telegram(.bot_telegram, paste0("\U2705 - ", .archivo))
  } else {
    tesorotools::mensaje_telegram(.bot_telegram, paste0("\U274C - ", .archivo))
  }

}
