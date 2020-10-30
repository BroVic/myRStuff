file_move <- function(file, dest)
{
  newPath <- file.path(dest, basename(file))
  if (file.copy(file, newPath)) {
    if (!file.remove(file)) {
      file.remove(newPath)
    }
    return(TRUE)
  }
  FALSE
}