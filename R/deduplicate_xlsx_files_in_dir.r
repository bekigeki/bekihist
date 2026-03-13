#' Identifies duplicate xlsx files, optionally copies uniques
#'
#' @title Identifies duplicate xlsx files, copies only unique files
#' Version: 03
#' Date: 2025-09-08 UTC
#' @param path_in Path to directory with xlsx files
#' @param path_out Path to directory for copied unique files
#' @param copy Logical; if FALSE, do not copy files, only report duplicates
#' @return Invisibly, a list with elements `duplicates` and `copied`.
#' @examples
#' deduplicate_xlsx_files_in_dir(
#'   path_in  = "~/Downloads/tmp",
#'   path_out = "~/tmp/",
#'   copy     = TRUE
#' )
#' @author Toni Wöhrl
#' @export
deduplicate_xlsx_files_in_dir <- function(path_in, path_out, copy = TRUE) {

  if (copy) {
    # Clear and (re)create output dir only if copying
    unlink(path_out, recursive = TRUE, force = TRUE)
    if (!dir.exists(path_out)) {
      dir.create(path_out, recursive = TRUE, showWarnings = FALSE)
    }
  }

  # Recursively list all .xlsx files (ignore lock files)
  files <- list.files(
    path_in,
    pattern = "^[^~].+\\.xlsx$",
    full.names = TRUE,
    recursive = TRUE
  )

  # Compute MD5 hashes using entire file
  md5s <- vapply(
    files,
    digest::digest,
    file = TRUE,
    algo = "md5",
    FUN.VALUE = character(1)
  )
  file_groups <- split(files, md5s)
  duplicates   <- file_groups[vapply(file_groups, length, integer(1)) > 1]
  unique_files <- vapply(file_groups, function(x) x[1], character(1))

  copied <- character(0)

  if (copy) {
    # Copy unique files
    copy_ok <- file.copy(
      from = unique_files,
      to   = file.path(path_out, basename(unique_files)),
      copy.mode = TRUE
    )
    copied <- unique_files[copy_ok]
    message(sprintf("%d unique files copied to %s", sum(copy_ok), path_out))
  } 

  if (length(duplicates) > 0) {
    message("Duplicates detected (only one representative per hash):")
    print(duplicates)
  }

  invisible(list(duplicates = duplicates, copied = copied))
}
