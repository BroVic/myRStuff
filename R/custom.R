#' Quick Customization for RStudio Themes
#' 
#' @importFrom rstudioapi applyTheme
#' @importFrom rstudioapi getThemeInfo
#' @importFrom rstudioapi isAvailable
#' 
#' @export
toggleTheme <- function()
{
  if (!isAvailable())
    stop("Not an RStudio session")
  themes <- c("Tomorrow Night Bright", "Textmate (default)")
  cur <- getThemeInfo()$editor
  theme <- if (!identical(cur, themes[2]))
    themes[2]
  else
    themes[1]
  applyTheme(theme)
}