#' Run Package Checks on Win-Builder
#' 
#' Automates the normal checks on the Win-Builder site
#' 
#' @param pkg The path to the package
#' 
#' @importFrom devtools check_win_devel
#' @importFrom devtools check_win_oldrelease
#' @importFrom devtools check_win_release
#' 
#' @export
check_on_winbuilder <- function(pkg = ".") {
  funs <- paste0("check_win_", c("devel", "release", "oldrelease"))
  lapply(funs, function(f) {
    do.call(f, args = list(pkg = pkg, quiet = TRUE)) |>
      invisible()
  })
}

