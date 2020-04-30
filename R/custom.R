#' Quick Customization for RStudio Themes
#' 
#' @importFrom rstudioapi applyTheme
#' @importFrom rstudioapi getThemeInfo
#' @importFrom rstudioapi isAvailable
#' 
#' @export
toggleTheme <- function()
{
  if (!rstudioapi::isAvailable())
    stop("Not an RStudio session")
  themes <- c("Tomorrow Night Bright", "Textmate (default)")
  cur <- rstudioapi::getThemeInfo()$editor
  theme <- if (!identical(cur, themes[2]))
    themes[2]
  else
    themes[1]
  rstudioapi::applyTheme(theme)
}