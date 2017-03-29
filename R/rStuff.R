# Practice on the base package
checkBasePkg <- function() { # TODO: Upgrade to a generic version
  wd <- "C:/Users/Admn/Documents/5-Personal/Study/R/practice/base"
  help(package = "base")
  message("Documentation for package 'base' is now open")
  if (getwd() != wd) {
    message(paste("Working directory changed to", getwd()))
  } else message(paste("Already in", wd))
}
