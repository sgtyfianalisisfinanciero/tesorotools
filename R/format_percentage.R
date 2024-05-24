#' Formatear números entre 0 y 1 como cadenas de texto que representan porcentajes.
#'
#' @param x número a formatear
#' @keywords formatear porcentaje
#' @export
#' format_percentage()

format_percentage <- scales::number_format(
  scale=1e2,
  accuracy=0.1,
  decimal.mark=",",
  big.mark=".",
  suffix="%"
)
