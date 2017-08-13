#' Navigate to personal R sandbox
#' 
#' @param dir A directory within the sandbox
#' @export
goto_sandbox <- function(dir = NULL)
{
    sbx <- "~/5-Personal/Study/R/r-sandbox/"
    if (!is.null(dir)) {
        if (!is.character(dir))
            stop("arg 'dir' must be a character vector.")
        ls <- basename(list.dirs(sbx, recursive = FALSE))
        if (dir %in% ls)
            setwd(paste0(sbx, dir))
        else message("There is no directory called ", sQuote(dir), " in ", sbx)
    } else setwd(sbx)
}
