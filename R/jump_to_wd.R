#' Change to a particular working directory
#' 
#' This function is for those who are too lazy to type out a full path.
#' 
#' @param dir The destination directory
#' @param home The user's home directory; the starting point for the search
#' 
#' @details This function works best for the user who is vaguely familiar
#'     familiar with the directory tree structure of the work station, as
#'     there is a need to supply the exact name of the destination folder.
#' 
#' @export
jump_to_wd <- function(dir, home = NULL) {
  if (length(dir) > 0L || length(home) > 0L) {
    if (!is.character(dir))
      stop("argument supplied not a character vector")
  }
  if (is.null(home))
    home <- "~/"
  message("searching from ", path.expand(home))
  message("Please wait...")
  lst <- list.dirs(path = home, full.names = TRUE, recursive = TRUE)
  dirs <- basename(lst)
  ind <- grep(dir, dirs, ignore.case = FALSE)
  setwd(lst[ind])
  message("You're working directory is ", sQuote(getwd()))
}
