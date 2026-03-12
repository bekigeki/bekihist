#' Read a rectangular table from an Excel sheet
#'
#' Generic reader used for both profile and test data.
#'
#' @param file Character. Path to a single .xlsx file.
#' @param spec List. Layout specification for this table, containing
#'   \code{sheet}, \code{range}, and \code{colnames}.
#'
#' @return A tibble with all columns as character.
#' @keywords internal
#' @export
read_table_generic <- function(file, spec) {
  readxl::read_xlsx(
    file,
    sheet     = spec$sheet,
    range     = spec$range,
    col_names = spec$colnames,
    col_types = "text"
  ) |>
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character),
                 ,.row = dplyr::row_number())
}



#' Read school-level info from an Excel mask
#'
#' Reads header / metadata cells (school, class, date, etc.) defined
#' by a cohort-specific layout specification.
#'
#' @param file Character. Path to a single .xlsx file.
#' @param spec List. Layout specification for the school sheet, with
#'   entries \code{sheet}, \code{range}, and \code{cells} (a named list
#'   of \code{c(row = , col = )} pairs).
#'
#' @return A 1-row tibble with school-level metadata (all character).
#' @keywords internal
#' @export
read_school_info_generic <- function(file, spec) {
  raw <- suppressMessages(readxl::read_xlsx(
    file,
    sheet     = spec$sheet,
    range     = spec$range,
    col_names = FALSE,
    col_types = "text"
  ))


  get_cell <- function(rc) raw[[rc[["col"]]]][rc[["row"]]]

  vals <- lapply(spec$cells, get_cell)
  names(vals) <- names(spec$cells)

  vals$File_name <- basename(file)
  vals$Dir_name  <- dirname(file)

  tibble::as_tibble(vals) |>
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character))
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

#' Read and join all sheets from a single Excel mask
#'
#' Reads profile data, test data, and school metadata from one Excel file,
#' using a cohort-specific layout, and returns a joined child-level table.
#'
#' @param file Character. Path to a single .xlsx file.
#' @param layout List. Layout specification for this cohort, containing
#'   sublists \code{profile}, \code{tests}, \code{school}, and scalar
#'   entries such as \code{join_col} and \code{Cohort}.
#'
#' @return A tibble with one row per child, test results, and attached
#'   school-level metadata (all columns as character, plus \code{Cohort}).
#' @export
read_sheets_in_file <- function(file, layout) {
  stopifnot(!is.null(layout))

  
  profile <- read_table_generic(file, layout$profile) |>
    dplyr::filter(!is.na(Nr)) |>
    assert_unique_key(layout$join_col)
  
  tests <- read_table_generic(file, layout$tests) |>
    dplyr::filter(!is.na(Nr)) |>
    assert_unique_key(layout$join_col)

  school <- read_school_info_generic(file, layout$school)

  out <- dplyr::left_join(profile, tests, by = layout$join_col) |>
    dplyr::mutate(
      dplyr::across(dplyr::everything(), as.character),
      !!!as.list(school[1, , drop = FALSE]),
      Cohort = as.character(layout$Cohort)
    )

  out
}

#' Bind multiple Excel masks into one table
#'
#' Reads all .xlsx BeKiGeKi Excel masks in a directory (optionally
#' recursively), processes each file with \code{read_sheets_in_file()},
#' performs optional file-coverage checks, and writes CSV/RDS snapshots.
#'
#' @param path_in Character. Directory containing *.xlsx Excel masks.
#' @param layout List. Layout specification for this cohort (as used
#'   by \code{read_sheets_in_file()}).
#' @param path_csv Character. Path to CSV snapshot file.
#' @param path_rds Character. Path to RDS snapshot file.
#' @param save_csv Logical. If TRUE, write a CSV snapshot to \code{path_csv}.
#' @param save_rds Logical. If TRUE, write an RDS snapshot to \code{path_rds}.
#' @param recursive Logical. If TRUE, search \code{path_in} recursively.
#' @param check_files Character. One of "none", "warn", "error" to control
#'   the post-hoc check that all input files are represented in the data.
#'
#' @return A tibble with aggregated data from all files.
#' @export
#' @examples
#' \dontrun{
#' d <- bind_files_in_dir(
#'   path_in  = "./in/",
#'   layout   = layout_2025,
#'   save_csv = FALSE,
#'   save_rds = FALSE
#' )
#' }
bind_files_in_dir <- function(path_in  = "./tidy/",
                              layout,
                              path_csv = "./tmp/bind_files_in_dir.csv",
                              path_rds = "./tmp/bind_files_in_dir.rds",
                              save_csv = TRUE,
                              save_rds = TRUE,
                              recursive   = TRUE,
                              check_files = c("none", "warn", "error")) {
  check_files <- match.arg(check_files)

  file_names <- list.files(
    path       = path_in,
    pattern    = "^[^~].+\\.xlsx$",
    full.names = TRUE,
    recursive  = recursive
  )

  N <- length(file_names)
  if (N == 0L) {
    stop("No .xlsx files found in ", path_in)
  }

  dfs <- vector("list", N)

  for (n in seq_along(file_names)) {
    cat(sprintf("%d/%d files processed\n", n, N))
    dfs[[n]] <- read_sheets_in_file(
      file   = file_names[n],
      layout = layout
    )
  }
  
  d <- dplyr::bind_rows(dfs)

  check_files_covered(file_names, d, file_col = "File_name",
                      mode = check_files)

  if (isTRUE(save_csv)) {
    dir.create(dirname(path_csv), showWarnings = FALSE, recursive = TRUE)
    utils::write.csv(d, file = path_csv, row.names = FALSE)
  }
  if (isTRUE(save_rds)) {
    dir.create(dirname(path_rds), showWarnings = FALSE, recursive = TRUE)
    saveRDS(d, file = path_rds)
  }


  d
}

#' Check that all files are represented in the bound data
#'
#' Compares the set of input file names to the values in a file-name
#' column of the bound data and warns or errors on mismatches.
#'
#' @param file_names Character vector of full file paths that were read.
#' @param d Data frame returned by \code{bind_files_in_dir()}.
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

as_excel_date <- function(x) {
  as.Date(as.numeric(x), origin = "1899-12-30")
}
