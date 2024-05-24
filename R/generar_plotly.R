#' Generar un gráfico plotly a partir de un objeto ggplot, y asignarle un nombre en el espacio de nombres tal que: NOMBRE_GRAFICO_plotly_plt
#'
#' @param plot_ggplot objeto ggplot con el gráfico original
#' @param legendx posición de la leyenda en el eje de abscisas
#' @param legendy posición de la leyenda en el eje de ordenadas
#' @param hoververtical hover sobre el gráfico en formato de línea vertical
#' @param label variable que contiene el label
#' @param showlegend mostrar o no la leyenda. Por defecto es TRUE
#' @param yaxisposition posición del eje de ordenadas. Por defecto es "right"
#' @param nombre_plotly_final nombre de la variable que contendrá el objeto plotly. Por defecto tiene formato NOMBRE_GRAFICO_plotly_plt
#' @param hoverhorizontal hover sobre el gráfico en formato de línea horizontal
#' @keywords generar grafico plotly
#' @export
#' @examples
#' generar_plotly()

generar_plotly <- function(plot_ggplot,
                           legendx=0,
                           legendy=-0.2,
                           hoververtical=TRUE,
                           label="label",
                           showlegend=TRUE,
                           yaxisposition="right",
                           nombre_plotly_final="",
                           hoverhorizontal = FALSE,
                           returnplot=FALSE) {
  nombre_plot <- deparse(substitute(plot_ggplot))
  nombre_plot_split <- stringr::str_split(nombre_plot, "_")[[1]]

  nombre_plot_plotly <- paste(c(nombre_plot_split[-length(nombre_plot_split)], "plotly", "plt"), collapse="_")

  if(hoververtical & !hoverhorizontal) {
    new_plotly <- plot_ggplot |>
      plotly::ggplotly(tooltip = label) |>
      plotly::layout(hoverlabel=list(bgcolor="white")) |>
      plotly::layout(yaxis = list(side=yaxisposition,
                          hoverformat=".2f"),
             legend=list(title="none",
                         x=legendx, y=legendy,
                         orientation = "h",
                         showlegend = showlegend),
             hovermode = "x unified")
  } else if(hoverhorizontal) {
    new_plotly <- plot_ggplot |>
      plotly::ggplotly(tooltip = label) |>
      plotly::layout(hoverlabel=list(bgcolor="white")) |>
      plotly::layout(yaxis = list(side=yaxisposition,
                                  hoverformat=".2f"),
                     legend=list(title="none",
                                 x=legendx, y=legendy,
                                 orientation = "h",
                                 showlegend = showlegend),
                     hovermode = "y unified")
  } else {
    new_plotly <- plot_ggplot |>
      plotly::ggplotly(tooltip = label) |>
      plotly::layout(hoverlabel=list(bgcolor="white")) |>
      plotly::layout(yaxis = list(side=yaxisposition,
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
    new_plotly <- new_plotly |>
      plotly::hide_legend()
  }

  print(nombre_plot_plotly)
  new_plotly <- plotly::config(new_plotly, locale='es')

  if (nombre_plotly_final == "") { # si no se ha asignado un nombre específico al plotly a generar
    message("nombre del gráfico dinámico: ", nombre_plot_plotly )
    assign(nombre_plot_plotly, new_plotly, envir = .GlobalEnv)
  } else { # si se ha asignado un nombre específico al plotly a generar vía argumento de la función, lo asignamos a este nombre
    message("nombre del gráfico dinámico definido expresamente: ", nombre_plotly_final )
    assign(nombre_plotly_final, new_plotly, envir=.GlobalEnv)
  }

  if (returnplot) {
    return(get(nombre_plot_plotly))
  }

}


