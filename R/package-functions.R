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





#' Customised Upgrading of R Installation
#' 
#' Installing R using customised settings of
#' \code{\link[installr]{updateR}}
#' 
#' @details The R installation will be carried out without a recourse to 
#' any kind of interaction, with the exception of a possible prompt from
#' \emph{Windows Smartscreen}.
#' 
#' @importFrom installr updateR
#' @importFrom installr check.for.updates.R
#' 
#' @export
install_R_my_way <- function() {
  
  ## Determine download location
  if (identical(.Platform$OS.type, 'windows')) {
    dwn <- file.path(path.expand("~"), "Downloads")
    if (!dir.exists(dwn)) {
      cat("Creating the new directory", dwn, "... ")
      if (dir.create(dwn)) {
        cat("Successful\n")
      }
      else {
        cat("Failed\n")
        stop("You may need to check your permissions.")
      }
    }
    message("The installer was downloaded to ", dwn)
    stop("Attempted to run on an unsupported platform")
  }
  
  if (check.for.updates.R(notify_user = F)) {
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
      download_dir = dwn,
      silent = TRUE
    )
  }
  else {
    cat("Nothing to be done.")
  }
}