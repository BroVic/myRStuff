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
#'
#' @export
review.package <- function(pkg = character())
{
  msg <- "Argument 'pkg' is not "
  if (!is.atomic(pkg))
    stop(paste0(msg, " atomic"))
  if (!is.character(pkg))
    stop(paste0(msg, " a character vector"))
  packdir <-
    "~/Documents/5-Personal/Study/datascience/R/r-sandbox/pkgs/"
  if (!dir.exists(packdir))
    stop(sQuote(packdir),
         " is not the right directory with studied packages")
  pkgPath <- file.path(packdir, pkg)
  wd <- path.expand(pkgPath)
  pkgExists <- pkg %in% .packages(all.available = TRUE)
  if (!pkgExists)
    stop(sprintf("Package '%s' does not exist. Please install it.", pkg))
  if (pkgExists && dir.create(pkgPath, showWarnings = FALSE))
    message("New directory created for package ", sQuote(pkg))
  if (!identical(getwd(), wd)) {
    if (!is.null(wd)) {
      setwd(wd)
      message("Working directory changed to ", sQuote(getwd()))
    } 
    else
      stop("Directory not found")
  } 
  else
    message("Already in ", sQuote(wd))
  help(package = as.character(pkg))
  message("Documentation for ", sQuote(pkg), " is now open.")
}
