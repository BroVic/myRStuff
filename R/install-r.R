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
#' \emph{Windows Smartscreen}. This functionality is for Windows machines only
#' - the function carries out a platform check internally.
#' 
#' @note
#' In instances where only part of the installer is downloaded due to a timeout,
#' one should consider resetting the default timeout (see example)
#' 
#' @examples
#' \dontrun{
#' # To extend the timeout period
#' op <- options(timeout = 1200)  # timeout is reset to 20 mins
#' easy_updateR()
#' options(op)  # reset to original value
#' }
#' 
#'
#' @export
easy_updateR <- function() {
  if (!identical(.Platform$OS.type, "windows"))
    stop("This function runs only on Windows OS")
  
  # It's possible that the installer already exists on the
  # system - this makes repeated downloads unnecessary. We
  # would want to ascertain this. We are going to assume that
  # the user has the default `Downloads` folder on their system.
  dwndir <- file.path(Sys.getenv("HOME"), "Downloads")
  
  if (dir.exists(dwndir)) {
    rver.pat <- "R-[0-9](\\.[0-9]){2}-win\\.exe$"
    r.installers <- list.files(dwndir, rver.pat)
    
    if (length(r.installers) > 0L) {
      r.versions <- stringr::str_extract(r.installers, pattern = rver.pat)
      mostRecent <- sort(as.numeric_version(r.versions), decreasing = TRUE)[1]
      myVer <- as.numeric_version(paste0(R.version$major, ".", R.version$minor))
      
      if (myVer < mostRecent) {
        shell.exec(file.path(dwndir, list.files(
          dwndir, pattern = paste0(mostRecent, "-win\\.exe$")
        )))
        
        return(TRUE)
      }
    }
  }
  else
    dwndir <- tempdir()

  if (!check.for.updates.R(GUI = FALSE))
    return(FALSE)
  
  updateR(
    browse_news = FALSE,
    install_R = TRUE,
    copy_packages = FALSE,
    copy_site_files = TRUE,
    keep_old_packages = TRUE,
    update_packages = FALSE,
    start_new_R = FALSE,
    quit_R = FALSE,
    print_R_versions = FALSE,
    to_checkMD5sums = TRUE,
    keep_install_file = TRUE,
    download_dir = dwndir,
    silent = TRUE
  )
}
