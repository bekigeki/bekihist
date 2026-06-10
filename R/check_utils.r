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
check_files_covered <- function(file_names, d, file_col = "XLSX_Dateiname",
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

#' Compare filenames in raw and tidy directories
#'
#' Compares (recursively) all files in a *raw* and a *tidy* directory by
#' basename without extension and reports files that exist only in one of
#' the two trees.
#'
#' The returned list contains tibbles with missing files, per-school
#' summaries, and school-level presence information.
#'
#' @return
#' A list with components:
#' \describe{
#'   \item{files_missing}{Tibble as before, one row per missing file.}
#'   \item{missing_summary}{Tibble with counts per School, Version, and
#'         missing_in.}
#'   \item{school_presence}{Tibble indicating for each School whether it
#'         has any files in raw or tidy.}
#' }
#'
#' @export
compare_raw_and_tidy_data_filenames <- function(path_in_raw, path_in_tidy) {
  stopifnot(
    length(path_in_raw)  == 1L,
    length(path_in_tidy) == 1L,
    is.character(path_in_raw),
    is.character(path_in_tidy)
  )

  parse_files <- function(path, origin) {
    files <- list.files(path, recursive = TRUE, full.names = FALSE)
    tibble::tibble(
      origin    = origin,
      full      = files,
      base      = basename(files),
      ext       = sub("^.*\\.(.+)$", "\\1", base),
      file_name = sub("\\..+$", "", base),
      School    = sub("^([0-9]+).*", "\\1", file_name),
      Version   = sub(".*_([0-9]+_[0-9]+_[0-9]+)$", "\\1", file_name)
    ) |>
      dplyr::distinct(file_name, origin, .keep_all = TRUE)
  }

  df_raw  <- parse_files(path_in_raw,  "raw_dir")
  df_tidy <- parse_files(path_in_tidy, "tidy_dir")

  all_files <- dplyr::bind_rows(df_raw, df_tidy) |>
    dplyr::group_by(file_name) |>
    dplyr::slice(1L) |>
    dplyr::ungroup()

  presence <- all_files |>
    dplyr::select(file_name, ext, School, Version) |>
    dplyr::distinct() |>
    dplyr::left_join(
      df_raw  |> dplyr::transmute(file_name, in_raw  = TRUE),
      by = "file_name"
    ) |>
    dplyr::left_join(
      df_tidy |> dplyr::transmute(file_name, in_tidy = TRUE),
      by = "file_name"
    ) |>
    dplyr::mutate(
      in_raw  = dplyr::coalesce(in_raw,  FALSE),
      in_tidy = dplyr::coalesce(in_tidy, FALSE)
    )

  files_missing <- presence |>
    dplyr::filter(xor(in_raw, in_tidy)) |>
    dplyr::mutate(
      missing_in = dplyr::case_when(
        in_raw  & !in_tidy ~ "tidy_dir",
        !in_raw & in_tidy  ~ "raw_dir",
        TRUE               ~ NA_character_
      )
    ) |>
    dplyr::select(file_name, ext, missing_in, School, Version) |>
    dplyr::arrange(School, Version, file_name)

  if (nrow(files_missing) == 0L) {
    message("No mismatching filenames between raw and tidy directories.")
    empty <- tibble::tibble(
      file_name  = character(0),
      ext        = character(0),
      missing_in = character(0),
      School     = character(0),
      Version    = character(0)
    )
    return(
      list(
        files_missing   = empty,
        missing_summary = empty,
        school_presence = tibble::tibble(
          School  = character(0),
          any_raw = logical(0),
          any_tidy = logical(0)
        )
      )
    )
  }

  missing_summary <- files_missing |>
    dplyr::group_by(School, missing_in, Version) |>
    dplyr::count(name = "n") |>
    tidyr::pivot_wider(
      names_from  = "missing_in",
      values_from = "n",
      names_prefix = "missing_in_"
    )

  school_presence <- presence |>
    dplyr::group_by(School) |>
    dplyr::summarise(
      any_raw  = any(in_raw),
      any_tidy = any(in_tidy),
      .groups = "drop"
    )

  schools_only_raw <- school_presence |>
    dplyr::filter(any_raw & !any_tidy) |>
    dplyr::pull(School)

  schools_only_tidy <- school_presence |>
    dplyr::filter(!any_raw & any_tidy) |>
    dplyr::pull(School)

  if (length(schools_only_raw) > 0L) {
    warning(
      "The following School ids are present only in raw_dir: ",
      paste(sort(unique(schools_only_raw)), collapse = ", ")
    )
  }
  if (length(schools_only_tidy) > 0L) {
    warning(
      "The following School ids are present only in tidy_dir: ",
      paste(sort(unique(schools_only_tidy)), collapse = ", ")
    )
  }

  # still print for interactive use, but return all data frames
  print(files_missing, n = Inf)
  print(missing_summary, n = Inf)

  invisible(
    list(
      files_missing   = files_missing,
      missing_summary = missing_summary,
      school_presence = school_presence
    )
  )
}
