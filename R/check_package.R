#' Check package installation status
#'
#' \code{check_package} checks whether an R package is installed locally.
#'
#' @param pkg package being checked for.
#'
#' @return The function returns \code{TRUE} if the package is installed;
#'     \code{FALSE} if it is not.
#' @export
check_package <- function(pkg = character())
{
  return(pkg %in% (.packages(all.available = TRUE)))
}
