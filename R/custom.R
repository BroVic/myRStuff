globalVariables(".")
#' Quick Customization for RStudio Themes
#' 
#' @importFrom magrittr %<>%
#' @importFrom rstudioapi applyTheme
#' @importFrom rstudioapi getThemeInfo
#' @importFrom rstudioapi isAvailable
#' @importFrom yaml read_yaml
#' 
#' @export
toggleTheme <- function()
{
  if (!isAvailable())
    stop("Not an RStudio session")
  themefile <- system.file('yaml', 'themes.yml', package = 'myRstuff')
  themes <- unlist(read_yaml(themefile))
  names(themes) %<>% 
    sub("themes\\.", "", .)
  cur <- getThemeInfo()$editor
  choice <- ifelse(cur == themes["light"], "dark", "light")
  applyTheme(themes[choice])
}