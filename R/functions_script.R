#' Reorientate labels on the y-axis and insert gridlines
#' 
#' @importFrom graphics axis grid
#' @export
custom_plot <- function()
{
  axis(2, las = 2); axis(1, las = 1)
  grid(NA, ny = NULL, col = "lightgrey", lty = "dashed")
}

