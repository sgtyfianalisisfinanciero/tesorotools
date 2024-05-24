.onLoad <- function(...) {
  packageStartupMessage("tesorotools 0.25 20240523 - miguel@fabiansalazar.es")

  # grDevices::windowsFonts(Calibri = windowsFont("Calibri"))

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

  colores_bancos <- c(
    "Santander"="#FF0000",
    "BBVA"="#072044",
    "Unicaja"="#6adf65",
    "Bankinter"="#ff821c",
    "Sabadell"="#4c99ff",
    "Abanca"="#5b87da",
    "Caixabank"="#009ee0",
    "Kutxabank"="#000000",
    "Cajamar"="#008190",
    "Ibercaja"="#ee3032"
  )

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
    axis.text.x = ggplot2::element_text(angle=45, hjust=1),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_rect(fill = NA, colour = NA),
    legend.position="bottom"
    )

  fechas_cierre_bolsa_2024 <- as.Date(
    c(
    "2024-01-01",
    "2024-03-29",
    "2024-04-01",
    "2024-05-01",
    "2024-12-25",
    "2024-12-26")
    )

}
