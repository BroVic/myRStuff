#' Check package installation status
#'
#' \code{check_package} checks whether an R package is installed locally.
#'
#' @param pkg package being checked for.
#'
#' @return The function returns \code{TRUE} if the package is installed;
#'     \code{FALSE} if it is not.
#' @examples
#' ## Not run
#' check_package("base")  # TRUE
#' @importFrom utils installed.packages
#' @export
check_package <- function(pkg)
{
  return(pkg %in% rownames(installed.packages()))
}
