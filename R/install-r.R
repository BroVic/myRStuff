# install-r.R

#' Update R
#'
#' A customised update of an existing R installation, without a fuss. This
#' function is a wrapper for \code{\link[installr]{updateR}}
#' 
#' @param timeout integer; timeout for the download.
#' 
#' @importFrom installr check.for.updates.R
#' @importFrom installr updateR
#' @importFrom stringi stri_extract
#' 
#' @details The R installation will be carried out with little or no
#' interaction from the user, with the exception of a possible prompt from
#' \emph{Windows Smartscreen}. This functionality is for Windows machines
#' - the function carries out a platform check internally.
#'
#' @export
easy_updateR <- function(timeout = getOption("timeout")) {
  # TODO: CRAN reviewers usually frown upon modifying options
  # within a function's implementation, so I will likely 
  # revisit this a little later.
  if (!is.numeric(timeout))
    stop("'timeout' must be numeric")
  
  op <- options(timeout = as.integer(timeout))
  on.exit(options(op))
  
  if (!identical(.Platform$OS.type, tolower(win32 <- "Windows")))
    stop("Function runs only on ", win32)
  
  dwn <- path.expand("~/Downloads")
  keep_install_file <- TRUE
  
  if (!dir.exists(dwn)) {
    if (!dir.create(dwn)) {
      dwn <- getwd()
      keep_install_file <- FALSE
    }
  }
  
  r.ver.pattern <- "R-[d](\\.[d]){2}"
  r.installers <- 
    list.files(dwn, pattern = paste0(r.ver.pattern, "-win\\.exe$"))
  
  if (length(r.installers) != 0L) {
    r.versions <- stringi::stri_extract(r.installers, regex = r.ver.pattern)
    mostRecent <- sort(as.numeric_version(r.versions), decreasing = TRUE)[1]
    myVer <-
      as.numeric_version(paste0(R.version$major, ".", R.version$minor))
    
    if (myVer < mostRecent) {
      shell.exec(file.path(dwn,
                           list.files(dwn, pattern = paste0(
                             mostRecent, "-win\\.exe$"
                           ))))
      return(TRUE)
    }
  }
  
  if (!check.for.updates.R(notify_user = FALSE, GUI = FALSE)) {
    cat("Nothing to do\n")
    return(FALSE)
  }
  
  tryCatch({
    updated <-
      installr::updateR(
        browse_news = FALSE,
        install_R = TRUE,
        copy_packages = FALSE,
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
    
    if (!updated)
      stop("R could not be updated")
    
  }, error = function(e) {
    stop(e)
  })
  
  if (updated && keep_install_file)
    message("The installer was saved to ", sQuote(dwn))
  
  updated
}
