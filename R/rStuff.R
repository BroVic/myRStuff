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
review.package <- function(package = character())
{
  wd <- paste0("C:/Users/Admn/Documents/5-Personal/Study/R/practice/",
               as.character(package))
  
  help(package = as.character(package))
  message(paste("Documentation for the", sQuote(package),
                "package is now open."))
  
  if (getwd() != wd) {
    setwd(wd)
    message(paste0("Working directory changed to ", sQuote(getwd()), "."))     
  } else message(paste0("Already in ", sQuote(wd), "."))
}