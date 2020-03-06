# install-r.R

#' Update R
#'
#' A customised update of an existing R installation, without a fuss. This
#' function is a wrapper for \code{\link[installr]{updateR}}
#' 
#' @importFrom installr check.for.updates.R
#' @importFrom installr updateR
#' 
#' @details The R installation will be carried out with little or no
#' interaction from the user, with the exception of a possible prompt from
#' \emph{Windows Smartscreen}. This functionality is for Windows machines
#' - the function carries out a platform check internally.
#'
#' @export
easy_updateR <- function() {
  if (!identical(.Platform$OS.type, tolower(win32 <- "Windows")))
    stop("Function runs only on ", win32)
  
  dwn <- file.path(path.expand("~"), "Downloads")
  keep_install_file <- TRUE
  if (!dir.exists(dwn)) {
    if (!dir.create(dwn)) {
      dwn <- getwd()
      keep_install_file <- FALSE
    }
  }
  
  updated <- FALSE
  try({
    if (!check.for.updates.R(notify_user = FALSE, GUI = FALSE)) 
      cat("Nothing to do\n")
    else updated <-
        installr::updateR(
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
          keep_install_file = keep_install_file,
          download_dir = dwn,
          silent = TRUE
        )
  })
  if (updated && keep_install_file)
    message("The installer was saved to ", dwn)
  
  invisible(updated)
}