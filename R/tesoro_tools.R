library(plotly)

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


favorables_desfavorables_colors <- c(10,8)


# tema_gabinete <- ggplot2::theme(
#   panel.background = ggplot2::element_rect(fill='transparent'),
#   plot.background = ggplot2::element_rect(fill='transparent', color=NA),
#   # panel.border = element_rect(colour = "#BFBFBF", fill=NA, size=0.75),
#   panel.border = ggplot2::element_blank(),
#   text=ggplot2::element_text(family="Calibri"),
#   panel.grid.major = ggplot2::element_line(colour = "#D9D9D9", linetype = "dotted", size=0.75),
#   panel.grid.major.x = ggplot2::element_blank(),
#   panel.grid.minor.x = ggplot2::element_blank(),
#   axis.ticks = ggplot2::element_blank(),
#   axis.title.x = ggplot2::element_blank(),
#   axis.title.y = ggplot2::element_blank(),
#   strip.background = ggplot2::element_rect(fill="white")
# ) + ggplot2::theme(legend.title = ggplot2::element_blank(),
#           axis.text.x = ggplot2::element_text(angle=45, hjust=1),
#           legend.key = ggplot2::element_rect(fill = NA, colour = NA),
#           legend.position = c(0.2,0.65)) 


tema_gabinete <- theme(
  panel.background = element_rect(fill='transparent'),
  plot.background = element_rect(fill='transparent', color=NA),
  # panel.border = element_rect(colour = "#BFBFBF", fill=NA, size=0.75),
  text=element_text(family="Arial"),
  panel.grid.major = element_line(colour = "#D9D9D9", linetype = "dotted", size=0.75),
  panel.grid.major.x = element_blank(),
  panel.grid.minor.x = element_blank(),
  axis.ticks = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  strip.background = element_rect(fill="white"),
  legend.title = element_blank(),
  axis.text.x = element_text(angle=45, hjust=1),
  legend.key = element_rect(fill = NA, colour = NA),
  axis.text=) + ggplot2::theme(legend.title = ggplot2::element_blank(),
                               axis.text.x = ggplot2::element_text(angle=45, hjust=1),
                               legend.key = ggplot2::element_rect(fill = NA, colour = NA),
                               legend.position = c(0.2,0.65))




remove_legend <- ggplot2::theme(legend.position="none")
plain_numbers_y_axis <- ggplot2::scale_y_continuous(labels= function(x) format(x, trim = TRUE, big.mark = ".", scientific = FALSE))  

fuente <- ggplot2::labs(caption=stringr::str_wrap("Fuente: Gabinete Técnico y de Análisis Financiero de la Secretaría General del Tesoro y Financiación Internacional a partir de microdatos de la Central de Riesgos del Banco de España."))


leyendaReducir <- function(pointSize = 0.5, textSize = 2, spaceLegend = 0.1) {
  ggplot2::guides(shape = ggplot2::guide_legend(override.aes = list(size = pointSize)),
         color = ggplot2::guide_legend(override.aes = list(size = pointSize))) +
    ggplot2::theme(legend.title = ggplot2::element_text(size = textSize), 
          legend.text  = ggplot2::element_text(size = textSize),
          legend.key.size = ggplot2::unit(spaceLegend, "lines"))
}

# ggplot_join_plots <- function(plot1, plot2, .position="bottom") {
#   
#   plt_output_leyenda_bottom <- plot1 +
#     ggplot2::theme(legend.position=.position) + 
#     leyendaReducir()
#   
#   plt_output <- ggplot2::ggarrange(plot1, 
#                           plot2, 
#                           ncol=2, 
#                           nrow=1, 
#                           common.legend=T, 
#                           legend="bottom", 
#                           legend.grob=get_legend(plt_output_leyenda_bottom)) 
#   
#   plt_output
# }

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


generar_plotly <- function(plot_ggplot, 
                           legendx=0, 
                           legendy=-0.2,
                           hoververtical=TRUE, 
                           label="label", 
                           showlegend=TRUE, 
                           yaxisposition="right", 
                           nombre_plotly_final="",
                           hoverhorizontal = FALSE) {
  nombre_plot <- deparse(substitute(plot_ggplot))
  nombre_plot_split <- stringr::str_split(nombre_plot, "_")[[1]]
  
  nombre_plot_plotly <- paste(c(nombre_plot_split[-length(nombre_plot_split)], "plotly", "plt"), collapse="_")

  if(hoververtical & !hoverhorizontal) {
    new_plotly <- plot_ggplot %>% 
      ggplotly(tooltip = label) %>%   
      layout(hoverlabel=list(bgcolor="white")) %>%
      layout(yaxis = list(side=yaxisposition,
                          hoverformat=".2f"), 
             legend=list(title="none",  
                         x=legendx, y=legendy, 
                         orientation = "h",
                         showlegend = showlegend), 
             hovermode = "x unified")
  } else if(hoverhorizontal) {
    new_plotly <- plot_ggplot %>% 
      ggplotly(tooltip = label) %>%   
      layout(hoverlabel=list(bgcolor="white")) %>%
      layout(yaxis = list(side=yaxisposition,
                          hoverformat=".2f"), 
             legend=list(title="none",  
                         x=legendx, y=legendy, 
                         orientation = "h",
                         showlegend = showlegend), 
             hovermode = "y unified")
  } else {
    new_plotly <- plot_ggplot %>% 
      ggplotly(tooltip = label) %>%   
      layout(hoverlabel=list(bgcolor="white")) %>%
      layout(yaxis = list(side=yaxisposition,
                          hoverformat=".2f"), 
             legend=list(title="none",  
                         x=legendx, y=legendy, 
                         orientation = "h",
                         showlegend = showlegend))
  }
  
  for (i in 1:length(new_plotly$x$data)){
    if (!is.null(new_plotly$x$data[[i]]$name)){
      new_plotly$x$data[[i]]$name =  gsub("\\(","",stringr::str_split(new_plotly$x$data[[i]]$name,",")[[1]][1])
    }
  }
  
  if(!showlegend) {
    new_plotly <- new_plotly %>%
      hide_legend()
  }
  
  print(nombre_plot_plotly)
  
  if (nombre_plotly_final == "") {
    message("nombre del gráfico dinámico: ", nombre_plot_plotly )
    assign(nombre_plot_plotly, new_plotly, envir = .GlobalEnv)
  } else {
    message("nombre del gráfico dinámico definido expresamente: ", nombre_plotly_final )
    assign(nombre_plotly_final, new_plotly, envir=.GlobalEnv)
  }

  #return(get(nombre_plot_plotly))
  
}

generar_graficos <- function(lista_nombres, lista_titulos, lista_unidades, lista_fuentes, lista_notas = NULL) {
  
  # lista_nombres <- c("concursos_de_personas_fisicas_plt", "tipos_referencia_plt")
  # lista_titulos <- c("Título del gráfico" ,"Título de segundo gráfico")
  # lista_fuentes <- c("Unidades", "Millones")
  
  # lista_nombres <- c("concursos_de_personas_fisicas_plt", "tipos_referencia_plt"), 
  # lista_titulos <- c("Título del gráfico","Título de segundo gráfico"), 
  # lista_unidades <- c("Unidades", "Millones"),
  # lista_fuentes <- c("Refinitiv", "ICO")
  
  
  # print(lista_nombres)
  
  # print( !( ( length(lista_nombres) == length(lista_titulos)) & (length(lista_nombres) == length(lista_unidades)) ) )
  
  if ( !( ( length(lista_nombres) == length(lista_titulos)) & 
          (length(lista_nombres) == length(lista_unidades)) & 
          (length(lista_nombres) == length(lista_fuentes)))) {
    stop("generar_graficos: los argumentos no tienen la misma longitud. length(lista_nombres) = ", length(lista_nombres), 
         " length(lista_titulos) = ", length(lista_titulos),
         " length(lista_unidades) = ", length(lista_unidades),
         " length(lista_fuentes) = ", length(lista_fuentes),)
  }
  
  # print((length(lista_nombres) -1  + 2 - length(lista_nombres) -1 %% 2))
  
  for (item in seq(from = 1, to = (length(lista_nombres)), by=2)) {
    message(item)
    
    # abrimos div contenedor
    cat("<div style='display:flex; flex-direction:row; justify-content:space-evenly; align-items:center;'>")
    
    
    if (item == length(lista_nombres)) {
        # estamos en el último elemento de la lista, así que la tabla solo va a tener un elemento.
      
      # primer gráfico
      
      nombre_grafico_1 <- lista_nombres[[item]]
      titulo_grafico_1 <- lista_titulos[[item]]
      unidades_grafico_1 <- lista_unidades[[item]]
      fuente_grafico_1 <- lista_fuentes[[item]]
      notas_grafico_1 <- lista_notas[[item]]
      
      #message("Nombre gráfico: ", nombre_grafico_1)
      grafico_1 <- ifelse(params$static, 
                          get(nombre_grafico_1), 
                          get(paste0(lista_fuentes, "_plotly")))
      
      # abrir contenedor y tabla
      cat("<div>")
      cat('<table style="float:left;">')
      
      # fila 1: titulo del gráfico + unidades
      cat("<tr><td>")
      cat(paste0("<b>", titulo_grafico_1, "</b> <i>", unidades_grafico_1, "</i>" ))
      cat("</td></tr>")
      
      # fila 2: gráfico
      cat("<tr><td>")
      # plot(grafico_1)
      print(grafico_1)
      cat("</td></tr>")
      
      # cerrar contenedor y tabla
      print('</table>')
      
      
    } else {
        # no estamos en el último elemento de la lista, luego vamos a tener dos gráficos
      
      # primer gráfico
      
      nombre_grafico_1 <- lista_nombres[[item]]
      titulo_grafico_1 <- lista_titulos[[item]]
      unidades_grafico_1 <- lista_unidades[[item]]
      fuente_grafico_1 <- lista_fuentes[[item]]
      notas_grafico_1 <- lista_notas[[item]]
      
      #message("Nombre gráfico: ", nombre_grafico_1)
      grafico_1 <- ifelse(params$static, get(nombre_grafico_1), get(paste0(lista_fuentes, "_plotly")))
      
      # abrir contenedor y tabla
      cat("<div>")
      cat('<table style="float:left;">')
      
      # fila 1: titulo del gráfico + unidades
      cat("<tr><td>")
      cat(paste0("<b>", titulo_grafico_1, "</b> <i>", unidades_grafico_1, "</i>" ))
      cat("</td></tr>")
      
      # fila 2: gráfico
      cat("<tr><td>")
      # plot(grafico_1)
      print(grafico_1)
      cat("</td></tr>")
      
      # cerrar contenedor y tabla
      cat('</table>')
      cat("</div>")
      
      # segundo gráfico
      
      nombre_grafico_2 <- lista_nombres[[item+1]]
      titulo_grafico_2 <- lista_titulos[[item+1]]
      unidades_grafico_2 <- lista_unidades[[item+1]]
      fuente_grafico_2 <- lista_fuentes[[item+1]]
      notas_grafico_2 <- lista_notas[[item+1]]
      
      #message("Nombre gráfico: ", nombre_grafico_2)
      grafico_2 <- ifelse(params$static, get(nombre_grafico_2), get(paste0(lista_fuentes, "_plotly")))
      
      # abrir contenedor y tabla
      cat("<div>")
      cat('<table style="float:left;">')
      
      # fila 1: titulo del gráfico + unidades
      cat("<tr><td>")
      cat(paste0("<b>", titulo_grafico_2, "</b> <i>", unidades_grafico_2, "</i>" ))
      cat("</td></tr>")
      
      # fila 2: gráfico
      cat("<tr><td>")
      # plot(grafico_2)
      print(grafico_2)
      cat("</td></tr>")
      
      # fila 3: fuente
      cat("<tr><td>")
      cat(paste0("<u>Fuente:</u> ", fuente_grafico_2))
      cat("</td></tr>")
      
      # cerrar contenedor y tabla
      cat('</table>')
      cat("</div>")
      
      
    }
    
    # cerramos div contenedor
    cat("</div>")
    
  }
}


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
    scale_color_manual(values = colores_new[c(1,2,3,4,5,6,7,8)]) +
    scale_x_date(date_labels = "%Y",
                 date_breaks = "1 year") +
    scale_y_continuous(labels = scales::number_format(accuracy=.accuracy,
                                                      scale=.scale,
                                                      suffix=.suffix,
                                                      big.mark=.big.mark,
                                                      decimal.mark=.decimal.mark),
                       limits=c(min(datos_df$valores) - 0.2, 
                                max(datos_df$valores) + 0.2))
  
  return(grafico)
}
