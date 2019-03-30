globalVariables("help")

#' Prepare a practice environment
#' 
#' Reviews a package by opening its documentation, navigating to the relevant
#' working directory (if necessary).
#' 
#' @param pkg character: name of the package
#' 
#' @return There is no return value. The side effects of the function call
#' a change of the working directory (where applicable) and the opening of
#' the documentation for that package.
#' 
#' @importFrom utils help
#' @export
review.package <- function(pkg = character())
{
  msg <- "Argument 'pkg' is not "
  if (!is.atomic(pkg))
    stop(paste0(msg, " atomic.\n"))
  if (!is.character(pkg))
    stop(paste0(msg, " a character vector.\n"))
  wd <- path.expand(file.path(
      "~", "Documents/5-Personal/Study/R/r-sandbox/pkgs", pkg))
  if (!pkg %in% utils::installed.packages()[, 1])
    stop(paste0("Package ", sQuote(pkg),
                " does not exist. Run 'install.packages(", dQuote(pkg),
                ")' to try and get it.\n"))
  if (!identical(getwd(), wd)) {
    if (!is.null(wd)) {
      setwd(wd)
      message(paste0("Working directory changed to ",
                     sQuote(getwd()), ".\n"))
    } else stop("Directory not found.\n")
  } else message(paste0("Already in ", sQuote(wd), ".\n"))
  help(package = as.character(pkg))
  message(paste("Documentation for the", sQuote(pkg),
                "package is now open.\n")) 
}

#' create_and_edit
#' 
#' Create a brand-new file and immediately open it for editing.
#' 
#' @param x a character vector of the filename(s)
#' 
#' @importFrom utils file.edit
#' 
#' @export
create_and_edit <- function(x = character())
{
    if (file.create(x)) {
        file.edit(x)
    } else {
        stop("Failed to create the file")
    }
}





#' Access/Open locally stored R cheatsheets
#' 
#' @param doc A character string of the filename, in part or whole. Regular
#' expressions and case insensitivity are supported.
#' 
#' @export
cheatsheet <- function(doc = NA_character_)
{
  stopifnot(is.character(doc))
  path <- "~/Documents/5-Personal/Computing/R/cheatsheets/"
  if (is.na(doc)) {
    shell.exec(normalizePath(path))
    return(NULL)
  }
  
  all.files <- list.files(path, ignore.case = TRUE)
  doc <- doc[1L]
  cht <- grep(doc, all.files, value = TRUE, ignore.case = TRUE)
  
  if (identical(cht, character(0))) {
    warning('No file matching ', sQuote(doc), ' was found')
  } else {
    invisible(
      lapply(cht, function(x) {
        shell.exec(path.expand(file.path(path, x)))
      })
    )
  }
}
