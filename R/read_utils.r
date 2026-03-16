#' Read a rectangular table from an Excel sheet
#'
#' Generic reader used for both profile and test data.
#' https://support.microsoft.com/en-us/office/date-systems-in-excel-e7fe7167-48a9-4b96-bb53-5612a800b487
#' https://stackoverflow.com/a/3963650
#'
#' @param file Character. Path to a single .xlsx file.
#' @param spec List. Layout specification for this table, containing
#'   \code{sheet}, \code{range}, and \code{colnames}.
#'
#' @return A tibble with all columns as character.
#' @keywords internal
#' @export
read_table_generic <- function(file, spec) {
  # Excel 1900 or 1904 system (as reported by openxlsx)
  date_origin_raw <- openxlsx::getDateOrigin(file)  # "1900-01-01" or "1904-01-01"

  # Adjust for Excel's fictitious 1900-02-29 leap day:
  # if 1900 system, use 1899-12-30 as true origin so serials map correctly in R
  date_origin <- if (date_origin_raw == "1900-01-01") {
    as.character(as.Date("1899-12-30"))
  } else {
    as.character(as.Date("1904-01-01"))
  }

  readxl::read_xlsx(
    file,
    sheet     = spec$sheet,
    range     = spec$range,
    col_names = spec$colnames,
    col_types = "text"
  ) |>
    dplyr::mutate(
      dplyr::across(dplyr::everything(), as.character),
      .row              = dplyr::row_number(),
      date_origin_xlsx  = date_origin_raw,
      date_origin_fixed = date_origin
    )
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

  #browser()
  profile <- read_table_generic(file, layout$profile) |>
    dplyr::filter(!is.na(Nr)) |>
    assert_unique_key(layout$join_col)
  
  tests <- read_table_generic(file, layout$tests) |>
    dplyr::filter(!is.na(Nr)) |>
    assert_unique_key(layout$join_col)

  school <- read_school_info_generic(file, layout$school)

  tests_reduced <- tests |>
    dplyr::select(-date_origin_xlsx, -date_origin_fixed)


  out <- dplyr::left_join(profile, tests_reduced, by = layout$join_col) |>
    dplyr::mutate(
      dplyr::across(dplyr::everything(), as.character),
      !!!as.list(school[1, , drop = FALSE]),
      Cohort = as.character(layout$Cohort),
      date_origin_xlsx = dplyr::first(profile$date_origin_xlsx),
      date_origin_fixed = dplyr::first(profile$date_origin_fixed)
    )
  out
}


#' Read and aggregate all Excel masks for one cohort
#'
#' For a given cohort, this function deduplicates all \code{.xlsx}
#' BeKiGeKi Excel masks in the cohort directory, writes the deduplicated
#' files to a temporary subdirectory, and then binds them into a single
#' cohort-level table using \code{bind_xlsx_files_in_dir()}. Cohort-level CSV
#' and RDS snapshot files are written to \code{base_path}.
#'
#' @param base_path Character scalar. Root directory containing the per-cohort
#'   subdirectories with raw Excel masks (e.g. \code{"~/beki/data-raw/"}).
#' @param cohort Character scalar. Cohort identifier (typically a year such as
#'   \code{"2017"}) that names both the input subdirectory and the output files.
#'
#' @return A tibble with all deduplicated records for the given cohort, as
#'   returned by \code{bind_xlsx_files_in_dir()}.
#'
#' @details
#' This function is a high-level wrapper around
#' \code{deduplicate_xlsx_files_in_dir()} and \code{bind_xlsx_files_in_dir()}.
#' It assumes that \code{get_layout(cohort)} returns the appropriate layout
#' specification for the requested cohort.
#'
#' The function has side effects: it writes a cohort-level CSV file
#' (\code{<cohort>.csv}) and RDS file (\code{<cohort>.rds}) into
#' \code{base_path}, and creates or updates a temporary subdirectory
#' \code{file.path(base_path, "tmp", cohort)} containing deduplicated
#' Excel masks.
#'
#' @examples
#' \dontrun{
#' # Process cohort 2017 in the default BeKi data-raw tree
#' d2017 <- read_cohort_xlsx(base_path = "~/beki/data-raw/", cohort = "2017")
#' }
#'
#' @export
read_cohort_xlsx <- function(base_path, cohort) {
  # Input and deduplicated directories for this cohort
  path_cohort <- file.path(base_path, cohort)        # raw Excel masks
  path_dedup  <- file.path(base_path, "tmp", cohort) # deduplicated Excel masks
  
  # 1) Deduplicate all xlsx files for this cohort into tmp/
  deduplicate_xlsx_files_in_dir(
    path_in  = path_cohort,
    path_out = path_dedup,
    copy     = TRUE
  )
  
  # 2) Bind all deduplicated files of this cohort into single cohort-level CSV/RDS
  bind_xlsx_files_in_dir(
    path_in   = path_dedup,
    layout    = get_layout(cohort),
    path_csv  = file.path(base_path, paste0(cohort, ".csv")),
    path_rds  = file.path(base_path, paste0(cohort, ".rds")),
    recursive = FALSE
  )
}

