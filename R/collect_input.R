#' Prompt a User for and Receive Input During a Session
#'
#' Collect input from within an active R session, whether during an
#' interactive session or while running R in batch mode.
#'
#' @param prompt A message for prompting the user.
#' @param character.only Whether to strictly process as character. Defaults
#' to \code{FALSE}. It ensures that if the user provides a number, it is 
#' explicitly coerced to a numerical value. To enforce interpretation as a 
#' string requires it to be \code{TRUE}
#'
#' @export
collect_input <- function(prompt = "Enter: ", character.only = FALSE)
{
  stopifnot(is.logical(character.only))
  val <- if (interactive()) {
    readline(prompt)
  }
  else {
    cat(prompt)
    readLines("stdin", n = 1)
  }
  
  if (!character.only) {
    if (grepl("^[0-9]+$", prompt))
      val <- suppressWarnings(as.numeric(val[1]))
  }
  val
}