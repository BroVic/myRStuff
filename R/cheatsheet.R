#' Access/Open locally stored R cheatsheets
#' 
#' @details Extraneous whitespace is trimmed from both ends of the argument.
#' 
#' @importFrom stringi stri_trim_both
#' 
#' @param doc A character vector of filenames, in part or whole. Regular
#' expressions and case insensitivity are supported.
#' 
#' @export
cheatsheet <- function(doc = NA_character_)
{
  if (!is.character(doc))
    stop("'doc' is not a character vector")
  
  doc <- stri_trim_both(doc[1L])
  maindir <- 
    normalizePath("~/Documents/5-Personal/Computing/dev/R/cheatsheets")
  
  if (!dir.exists(maindir))
    stop(sprintf("'%s' does not exist", maindir))
  
  if (!is.na(doc)) {
    all.files <- list.files(maindir, ignore.case = TRUE)
    sheets <- grep(doc, all.files, value = TRUE, ignore.case = TRUE)
    
    if (identical(sheets, character(0))) {
      message('The file ', sQuote(doc), ' was not found')
      return()
    }
    
    lapply(sheets, function(isheet)
      shell.exec(path.expand(file.path(maindir, isheet))))
    return()
  }
  shell.exec(maindir)
}
