#' package-functions.R
#' 
#' Save old R packages upon a new R installation.
#' 
#' @references https://www.datascienceriot.com/how-to-upgrade-r-without-losing-your-packages/kris/
#' 
#' @importFrom utils installed.packages install.packages menu update.packages
#' @export
old_pkg <- function()
{
  tmp <- installed.packages()
  installedPkgs <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
  
  save(installedPkgs, file = "../data/old-packages.rda")

  tmp <- installed.packages()
  newly_installed <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
  missing <- setdiff(installedPkgs, newly_installed)
  install.packages(missing)
  
  switch(menu(c("Yes", "No"), title = "Do you want to update your packages?"),
  	 update.packages(),
         cat("Packages not updated\n"))
}








#' Find a corrupted package
#' 
#' Checks whether a (malformed) package is missing the 'DESCRIPTION' file
#' @param lib An R library directory
#'
#' @export
which_pkg_missing_description <- function(lib)
{
  if (!lib %in% .libPaths())
    warning(sQuote(lib), " is not a recognised library directory.")
  pkgs <- list.dirs(lib, recursive = FALSE)
  if (!length(pkgs))
    stop(sprintf("There are no packages in '%s'.", lib))
  hasDESC <- sapply(pkgs, function(P) {
    file.exists(file.path(lib, P, "DESCRIPTION"))
  })
  pkgs[!which(hasDESC)]
}
