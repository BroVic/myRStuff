globalVariables("help")

#' Prepare a practice environment
#' 
#' Reviews a package by opening its documentation, navigating to the relevant
#' working directory (if necessary)
#' 
#' @param package name of the package
#' 
#' @return There is no return value. The side effects of the function call
#' a change of the working directory (where applicable) and the opening of
#' the documentation for that package.
#' @export
review.package <- function(pkg = character())
{
  msg <- "Argument 'pkg' is not "
  if (!is.atomic(pkg))
    stop(paste0(msg, " atomic.\n"))
  if (!is.character(pkg))
    stop(paste0(msg, " a character vector.\n"))
  wd <- paste0("C:/Users/Admn/Documents/5-Personal/Study/R/r-sandbox/",
               pkg)
  if (!pkg %in% installed.packages()[, 1])
    stop(paste0("Package ", sQuote(pkg),
                " does not exist. Run 'install.packages(", dQuote(pkg),
                ")' to try and get it.\n"))
  if (!identical(getwd(), wd)) {
    if (!is.null(wd)) {
      setwd(wd)
      message(paste0("\nWorking directory changed to ",
                     sQuote(getwd()), ".\n"))
    } else stop("\nDirectory not found.")
  } else message(paste0("\nAlready in ", sQuote(wd), ".\n"))
  help(package = pkg)
  message(paste("Documentation for the", sQuote(pkg),
                "package is now open.")) 
}