#' Devolver un objeto ggplot con los parámetros del tema de gabinete para gráficos
#'
#' @param .grafico_a_png objeto ggplot con el gráfico original
#' @param width_png anchura del png
#' @param height_png altura del png
#' @param res_png resolución del png
#' @keywords generar grafico png ggplot archivo temporal
#' @export
#' @examples
#' generar_png()

tema_gabinete_load <- function(.angulo_x = 45, .legend_position="bottom") {
  return(
    tema_gabinete <- ggplot2::theme(
      plot.background = ggplot2::element_rect(fill='transparent', color=NA),
      strip.background = ggplot2::element_rect(fill="white"),
      panel.background = ggplot2::element_rect(fill='transparent'),
      panel.grid.major = ggplot2::element_line(colour = "#D9D9D9", linetype = "dotted", size=0.75),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      axis.title.x = ggplot2::element_blank(),
      axis.title.y = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(angle=.angulo_x, hjust=1),
      legend.title = ggplot2::element_blank(),
      legend.key = ggplot2::element_rect(fill = NA, colour = NA),
      legend.position=.legend_position
    )
  )

}
