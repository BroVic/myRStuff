#' Change to a particular working directory
#' 
#' Move quickly to specified working directories on my system. These are named
#' the same way they are used via other programs on my computer  e.g. 
#' PowerShell.
#' 
#' @details
#' \code{book} will go to the directory that has my personal study material.
#' 
#' Other functions will be added as necessary.
#' 
#' @return The last working directory, invisibly.
#' 
#' @export
book <- function() {
  olddir <- getwd()
  newdir <- Sys.getenv("PERSONAL_BOOK_DIR")
  
  if (!dir.exists(newdir))
    stop(sQuote(newdir), "does not exist. Please review environment variables")
  
  setwd(newdir)
  message("Working directory has been set to ", sQuote(newdir))
  invisible(olddir)
}