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
review.package <- function(pkg)
{
  stopifnot(is.vector(pkg))
  stopifnot(is.character(pkg))
  mycomp <- Sys.info()
  mycomp <- mycomp["nodename"]
  root <- "~/Documents/5-Personal/Study/R/r-sandbox/"
  if (!identical(mycomp, "SA-DG")) {
    stop("The function is customised for exclusively for", sQuote(mycomp))
  } else {
    dirs <- list.dirs(root,
                      recursive = TRUE,
                      full.names = FALSE)
    if (!any(endsWith(dirs, pkg))) {
      stop("There is no material on the package", sQuote(pkg))
    } else {
      p <- grep(pattern = pkg, x = dirs, value = TRUE)
      wd <- file.path(root, p)
    }
    if (!pkg %in% .packages(all.available = TRUE))
      stop(
        paste0(
          "Package ",
          sQuote(pkg),
          " does not exist in ",
          .libPaths()[1])
      )
    if (!identical(getwd(), wd)) {
      if (dir.exists(wd)) {
        setwd(wd)
        message(paste0("Working directory changed to ",
                       sQuote(getwd()), ".\n"))
      } else
        stop("Directory not found.\n")
    } else
      message(paste0("Already in ", sQuote(wd), ".\n"))
    help(package = as.character(pkg))
    message(paste("Documentation for the", sQuote(pkg),
                  "package is now open.\n"))
  }
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

#' cheatsheet
#' 
#' Access locally stored cheatsheets
#' 
#' @param doc name of cheatsheet to view (or a match)
#' 
#' @export
cheatsheet <- function(doc = NULL)
{
  if (is.null(doc))
    shell.exec(normalizePath("~/Documents/5-Personal/R/cheatsheets"))
}

