#' old-pkg.R
#' 
#' Save old R packages upon a new R installation.
#' 
#' @references https://www.datascienceriot.com/how-to-upgrade-r-without-losing-your-packages/kris/
#' @export
old_pkg <- function()
{
  tmp <- installed.packages()
  installedPkgs <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
  
  save(installedPkgs, file = "../data/old-packages.rda")
  
  load("../data/old-packages.rda")
  tmp <- installed.packages()
  newly_installed <- as.vector(tmp[is.na(tmp[ , "Priority"]), 1])
  missing <- setdiff(installedPkgs, newly_installed)
  install.packages(missing)
  
  switch(menu(c("Yes", "No"), title = "Do you want to update your packages?"),
  	 update.packages(),
         cat("Packages not updated\n"))
}


# Source: 