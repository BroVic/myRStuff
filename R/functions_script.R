#' Reorientate labels on the y-axis and insert gridlines
#'
#' @return Minor customizations to plots. Adds horizontal gridlines and reorients y-axis tick-labels for improved legibility.
#'
#' @examples 
#' ## Do not run
#' plot(rnorm(10, 5, 2), axes = F)
#' custom_plot()
#' 
#' @export
custom_plot <- function()
{
  axis(2, las = 2); axis(1, las = 1)
  grid(NA, ny = NULL, col = "lightgrey", lty = "dashed")
}

