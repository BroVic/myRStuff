#' Access/Open locally stored R cheatsheets
#' 
#' @param doc A character string of the filename, in part or whole. Regular
#' expressions and case insensitivity are supported.
#' 
#' @export
cheatsheet <- function(doc = NA_character_)
{
  stopifnot(is.character(doc))
  doc <- doc[1L]
  path <- "~/Documents/5-Personal/Computing/dev/R/cheatsheets/"
  if (is.na(doc)) {
    shell.exec(normalizePath(path))
    return(NULL)
  }
  ## TODO: Enable display of multiple matched files for user's selection
  all.files <- list.files(path, ignore.case = TRUE)
  cht <- grep(doc, all.files, value = TRUE, ignore.case = TRUE)
  
  if (identical(cht, character(0)))
    message('No file matching ', sQuote(doc), ' was found')
  else
    invisible(
      lapply(cht, function(x) shell.exec(path.expand(file.path(path, x))))
    )
}
