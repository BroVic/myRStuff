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
  desc <- "DESCRIPTION"
  hasDESC <- sapply(pkgs, function(P) {
    file.exists(file.path(lib, P, desc))
  })
  pkgs[!which(hasDESC)]
}





#' Customised Upgrading of R Installation
#' 
#' Installing R using customised settings of
#' \code{\link[installr]{updateR}}
#' 
#' @importFrom installr updateR
#' 
#' @export
install_R_my_way <- function() {
  if (identical(.Platform$OS.type, 'windows')) {
    downs <- file.path(path.expand("~"), "Downloads")
    if (!dir.exists(downs))
      downs <- "C:/"
    message("Download directory for the installer was set to", downs)
  }

  updateR(
    browse_news = FALSE,
    install_R = TRUE,
    copy_packages = TRUE,
    copy_Rprofile.site = TRUE,
    keep_old_packages = TRUE,
    GUI = TRUE,
    to_checkMD5sums = TRUE,
    update_packages = FALSE,
    start_new_R = FALSE,
    quit_R = FALSE,
    print_R_versions = FALSE,
    keep_install_file = TRUE,
    download_dir = downs,
    silent = TRUE
  )
}