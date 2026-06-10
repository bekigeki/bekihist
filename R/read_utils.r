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
      XLSX_date_origin_import  = date_origin_raw,
      XLSX_date_origin_fixed = date_origin
    )
}


#' Read school-level info from an Excel mask
#'
#' Reads header / metadata cells (school, class, date, etc.) defined
#' by a school_year-specific layout specification.
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

  vals$XLSX_Dateiname <- basename(file)
 # vals$Dir_name  <- dirname(file)

  tibble::as_tibble(vals) |>
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character))
}


#' Read and join all sheets from a single Excel mask
#'
#' Reads profile data, test data, and school metadata from one Excel file,
#' using a school_year-specific layout, and returns a joined child-level table.
#'
#' @param file Character. Path to a single .xlsx file.
#' @param layout List. Layout specification for this school_year, containing
#'   sublists \code{profile}, \code{tests}, \code{school}, and scalar
#'   entries such as \code{join_col} and \code{School_year}.
#'
#' @return A tibble with one row per child, test results, and attached
#'   school-level metadata (all columns as character, plus \code{School_year}).
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

  tests_reduced <- tests |>
    dplyr::select(-XLSX_date_origin_import, -XLSX_date_origin_fixed)

  # build static columns from layout
  static_cols <- list(
    School_year = as.character(layout$School_year)
  )
  if (!is.null(layout$extra_cols)) {
    # coerce to named list so we can splice with !!!
    extra <- as.list(layout$extra_cols)
    static_cols <- c(static_cols, extra)
  }

  out <- dplyr::left_join(profile, tests_reduced, by = layout$join_col) |>
    dplyr::mutate(
      dplyr::across(dplyr::everything(), as.character),
      # splice school info (first row) as columns
      !!!as.list(school[1, , drop = FALSE]),
      # splice static metadata columns from layout
      !!!static_cols,
      XLSX_date_origin_import = dplyr::first(profile$XLSX_date_origin_import),
      XLSX_date_origin_fixed  = dplyr::first(profile$XLSX_date_origin_fixed)
    )

  out
}


#' Read and bind all Excel masks for one school_year
#'
#' For a given school_year, this function deduplicates all \code{.xlsx}
#' BeKiGeKi Excel masks in the school_year directory, writes the deduplicated
#' files to a temporary subdirectory, and then binds them into a single
#' school_year-level table using \code{bind_xlsx_files_in_dir()}. school_year-level CSV
#' and RDS snapshot files are written to \code{base_path}.
#'
#' @param base_path Character scalar. Root directory containing the per-school_year
#'   subdirectories with raw Excel masks (e.g. \code{"~/beki/data-raw/"}).
#' @param school_year Character scalar. School_year identifier (typically a school-year such as
#'   \code{"2017_18"}) that names both the input subdirectory and the output files.
#'
#' @return A tibble with all deduplicated records for the given school_year, as
#'   returned by \code{bind_xlsx_files_in_dir()}.
#'
#' @details
#' This function is a high-level wrapper around
#' \code{deduplicate_xlsx_files_in_dir()} and \code{bind_xlsx_files_in_dir()}.
#' It assumes that \code{get_layout(school_year)} returns the appropriate layout
#' specification for the requested school_year.
#'
#' The function has side effects: it writes a school_year-level CSV file
#' (\code{<school_year>.csv}) and RDS file (\code{<school_year>.rds}) into
#' \code{base_path}, and creates or updates a temporary subdirectory
#' \code{file.path(base_path, "tmp", school_year)} containing deduplicated
#' Excel masks.
#'
#' @examples
#' \dontrun{
#' # Process school_year 2017_18 in the default BeKiGeKi data-raw tree
#' d2017 <- read_school_year_xlsx(base_path = "~/beki/data-raw/", school_year = "2017_18")
#' }
#'
#' @export
read_school_year_xlsx <- function(base_path, school_year) {
  # Input and deduplicated directories for this school_year
  path_school_year <- file.path(base_path, school_year)        # raw Excel masks
  path_dedup  <- file.path(base_path, "tmp", school_year) # deduplicated Excel masks
  
  # 1) Deduplicate all xlsx files for this school_year into tmp/
  deduplicate_xlsx_files_in_dir(
    path_in  = path_school_year,
    path_out = path_dedup,
    copy     = TRUE
  )
  
  # 2) Bind all deduplicated files of this school_year into single school_year-level CSV/RDS
  bind_xlsx_files_in_dir(
    path_in   = path_dedup,
    layout    = get_layout(school_year),
    path_csv  = file.path(base_path, paste0(school_year, ".csv")),
    path_rds  = file.path(base_path, paste0(school_year, ".rds")),
    recursive = FALSE
  )
}

