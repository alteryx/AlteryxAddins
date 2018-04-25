
orderLibPaths <- function(x = .libPaths()){
  mro = grep("Microsoft", x)
  alteryx = grep("Alteryx", x)
  if ((length(mro) > 0) || (length(alteryx) > 0)){
    lp <- c(x[mro], x[alteryx], x[-c(mro, alteryx)])
  } else {
    lp <- x
  }
  createLibDir <- function(envVar){
    fpath <- file.path(Sys.getenv(envVar), 'Alteryx', 'R-library')
    if (!dir.exists(fpath)) dir.create(fpath, showWarnings = FALSE)
    if (dir.exists(fpath)) fpath else NULL
  }
  ayxPDPath <- createLibDir('ALLUSERSPROFILE')
  ayxAppDirPath <- createLibDir('APPDATA')

  c(ayxAppDirPath, ayxPDPath, lp)
}

#' Make Alteryx libPath first
#'
#' @export
useAlteryxLibPath <- function() {
  .libPaths(orderLibPaths())
}