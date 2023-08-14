.onLoad <- function(...) {
  packageStartupMessage("bdeseries v0.1 - miguel@fabiansalazar.es")

  grDevices::windowsFonts(Calibri = windowsFont("Calibri"))

  colores = c("#FFC000", # amarillos
              "#FFE699", # amarillos
              "#BF9000", # amarillos
              "#7F7F7F", # grises
              "#A6A6A6", # grises
              "#D9D9D9", # grises
              "#A4AFDA", # azules
              "#4951A8", # azules
              "#081482", # azules
              "#800000", # granate oscuro
              "#D00000") # granate

  colores_new <- c("#FFC000", # oro 1
                   "#843C0C", # marrón rojizo 2
                   "#A5A5A5", # gris 3
                   "#F8CBAD", # salmón claro 4
                   "#ED7D31", # salmón 5
                   "#421E06", # marrón casi negro 6
                   "#800000", # granate oscuro 7
                   "#d00000", # granate 8
                   "#cfd4fc", # azul claro 9
                   "#576af4", # azul medio 10
                   "#081482", # azul oscuro 11
                   "#777777") # Gris 12

  tema_gabinete <- ggplot2::theme(
    panel.background = ggplot2::element_rect(fill='transparent'),
    plot.background = ggplot2::element_rect(fill='transparent', color=NA),
    # panel.border = element_rect(colour = "#BFBFBF", fill=NA, size=0.75),
    text=ggplot2::element_text(family="Arial"),
    panel.grid.major = ggplot2::element_line(colour = "#D9D9D9", linetype = "dotted", size=0.75),
    panel.grid.major.x = ggplot2::element_blank(),
    panel.grid.minor.x = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_blank(),
    axis.title.y = ggplot2::element_blank(),
    strip.background = ggplot2::element_rect(fill="white"),
    legend.title = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_text(angle=45, hjust=1),
    legend.key = ggplot2::element_rect(fill = NA, colour = NA),
    axis.text=) + ggplot2::theme(legend.title = ggplot2::element_blank(),
                                 axis.text.x = ggplot2::element_text(angle=45, hjust=1),
                                 legend.key = ggplot2::element_rect(fill = NA, colour = NA),
                                 legend.position = c(0.2,0.65))

  favorables_desfavorables_colors <- c(10,8)

  remove_legend <- ggplot2::theme(legend.position="none")
  plain_numbers_y_axis <- ggplot2::scale_y_continuous(labels= function(x) format(x, trim = TRUE, big.mark = ".", scientific = FALSE))

  fuente <- ggplot2::labs(caption=stringr::str_wrap("Fuente: Gabinete Técnico y de Análisis Financiero de la Secretaría General del Tesoro y Financiación Internacional a partir de microdatos de la Central de Riesgos del Banco de España."))

  x_millones <- ggplot2::scale_x_continuous(labels = scales::label_number(suffix = " M", scale = 1e-6)) # millions
  y_millones <- ggplot2::scale_y_continuous(labels = scales::label_number(suffix = " M", scale = 1e-6)) # millions
  y_numero <- ggplot2::scale_y_continuous(labels = scales::label_number(suffix = "", scale = 1)) # millions
  y_miles_millones <- ggplot2::scale_y_continuous(labels = scales::label_number(suffix = " MM", scale = 1e-9)) # billions

  x_date_hook <- ggplot2::scale_x_date(date_breaks = "months" , date_labels = "%b-%y")
  x_diagonal <- ggplot2::theme(legend.title = ggplot2::element_blank(),
                               axis.text.x = ggplot2::element_text(angle=45, hjust=1))

  color_hook <- ggplot2::scale_color_manual(values=colores[c(1)])

  x_percentage <- ggplot2::scale_x_continuous(labels = scales::percent)
  y_percentage <- ggplot2::scale_y_continuous(labels = scales::percent)

  usethis::use_data(colores,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(colores_new,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(tema_gabinete,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(favorables_desfavorables_colors,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(remove_legend,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(plain_numbers_y_axis,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(fuente,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(x_millones,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(y_millones,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(y_miles_millones,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(x_date_hook,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(x_diagonal,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(color_hook,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(x_percentage,
                    internal = FALSE,
                    overwrite = TRUE)
  usethis::use_data(y_percentage,
                    internal = FALSE,
                    overwrite = TRUE)


}
