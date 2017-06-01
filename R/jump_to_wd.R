#' Change to a particular working directory
#' 
#' This function is for those who are too lazy to type out a full path.
#' 
#' @param x The destination directory
#' @param home The user's home directory; the starting point for the search
#' 
#' @details This function works best for the user who is vaguely familiar
#'     familiar with the directory tree structure of the work station, as
#'     there is a need to supply the exact name of the destination folder.
#' 
#' @export
jump_to_wd <- function(x, home = NULL) {
  if (length(x) > 0L || length(home) > 0L) {
    if (!is.character(x))
      stop("argument supplied not a character vector")
  }
  if (is.null(home))
    home <- "~/"
  message("searching from ", path.expand(home))
  message("Please wait...")
  lst <- list.dirs(path = home, full.names = TRUE, recursive = TRUE)
  dirs <- basename(lst)
  ind <- grep(x, dirs, ignore.case = FALSE)
  setwd(lst[ind])
  message("You're working directory is ", getwd())
}
