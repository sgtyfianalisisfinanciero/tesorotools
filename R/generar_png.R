#' A partir de un gráfico ggplot, generar un archivo temporal con formato png.
#'
#' @param .grafico_a_png objeto ggplot con el gráfico original
#' @param width_png anchura del png
#' @param height_png altura del png
#' @param res_png resolución del png
#' @keywords generar grafico png ggplot archivo temporal
#' @export
#' @examples
#' generar_png()

generar_png <- function(.grafico_a_png, width_png=500, height_png = 500, res_png=100) {

  .pngfile <- tempfile(fileext = ".png")

  grDevices::png(filename = .pngfile,
                 width = width_png,
                 height = height_png,
                 # units = "in",
                 res = res_png
  )

  print(.grafico_a_png)
  grDevices::dev.off()

  return(.pngfile)
}




