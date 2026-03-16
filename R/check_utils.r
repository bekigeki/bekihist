#' Check that all files are represented in the bound data
#'
#' Compares the set of input file names to the values in a file-name
#' column of the bound data and warns or errors on mismatches.
#'
#' @param file_names Character vector of full file paths that were read.
#' @param d Data frame returned by \code{bind_xlsx_files_in_dir()}.
#' @param file_col Character. Name of the column in \code{d} that contains
#'   the (base) file names.
#' @param mode One of "warn", "error", "none".
#'
#' @return Invisibly, \code{NULL}.
#' @keywords internal
#' @export
check_files_covered <- function(file_names, d, file_col = "File_name",
                                mode = c("warn", "error", "none")) {
  mode <- match.arg(mode)

  if (mode == "none") return(invisible(NULL))

  files_in      <- basename(file_names)
  files_in_data <- unique(d[[file_col]])

  missing <- setdiff(files_in, files_in_data)
  extra   <- setdiff(files_in_data, files_in)

  msg_missing <- NULL
  msg_extra   <- NULL

  if (length(missing) > 0L) {
    msg_missing <- paste0(
      "Files not represented in data: ",
      paste(missing, collapse = ", ")
    )
  }
  if (length(extra) > 0L) {
    msg_extra <- paste0(
      "Unexpected file names in data: ",
      paste(extra, collapse = ", ")
    )
  }

  msg <- paste(na.omit(c(msg_missing, msg_extra)), collapse = " | ")
  if (msg == "") return(invisible(NULL))

  if (mode == "warn") {
    warning(msg, call. = FALSE)
  } else if (mode == "error") {
    stop(msg, call. = FALSE)
  }

  invisible(NULL)
}


#' Assert uniqueness of a key column
#'
#' Helper that checks that a key column (e.g. \code{Nr}) has no duplicate,
#' non-NA values and errors otherwise.
#'
#' @param x A data frame.
#' @param key Character. Name of the key column to check.
#' @param file,sheet Optional context used only for error messages.
#'
#' @return \code{x}, invisibly, if no duplicates are found.
#' @keywords internal
#' @export
assert_unique_key <- function(x, key = ".row", file = NULL, sheet = NULL) {
  
  dup <- x |>
    dplyr::filter(!is.na(.data[[key]])) |>
    dplyr::count(.data[[key]]) |>
    dplyr::filter(n > 1)
  if (nrow(dup) > 0) {
    stop("Duplicate non-NA keys in ", key, " before join.")
  }
  x
}


' Identifies duplicate xlsx files, optionally copies uniques
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
