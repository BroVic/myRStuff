#' Quick Customization for RStudio Themes
#' 
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
  cur <- getThemeInfo()$editor
  themes <- unlist(read_yaml(themefile))
  ind <- ifelse(cur == themes[1], 2L, 1L)
  applyTheme(themes[ind])
}