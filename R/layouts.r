.bekihist_layouts <- list(
  
  `2017_18` = list(
    School_year = "2017_18",
    extra_cols    = c(Erhebungswelle = "1"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer         = c(row = 3, col = 1),
        Klassenname         = c(row = 4, col = 1),
        Testdatum_Jahr      = c(row = 5, col = 3),
        Testdatum_Monat     = c(row = 5, col = 2),
        Testdatum_Tag       = c(row = 5, col = 1),
        Schulname           = c(row = 1, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range   = "C17:R167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_XLSX", "Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG","Schulsport_1", "Schulsport_2", "Schulsport_3",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "C17:N167",
      colnames = c("Nr","Inklusion","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_54_m_Runden", "Run_Pylonen","Run_m_2" ,"Anmerkungen")
    )
  ),
  
  `2018_19` = list(
    School_year = "2018_19",
    extra_cols    = c(Erhebungswelle = "2"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer     = c(row = 3, col = 1),
        Klassenname     = c(row = 4, col = 1),
        Testdatum_Jahr  = c(row = 5, col = 3),
        Testdatum_Monat = c(row = 5, col = 2),
        Testdatum_Tag   = c(row = 5, col = 1),
        Schulname       = c(row = 1, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range   = "C17:R167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG","Schulsport_1", "Schulsport_2", "Schulsport_3",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "C17:N167",
      colnames = c("Nr","Inklusion","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_54_m_Runden", "Run_Pylonen","Run_m_2" ,"Anmerkungen")
    )
  ),
  
  `2019_20` = list(
    School_year = "2019_20",
    extra_cols    = c(Erhebungswelle = "3"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E10",
      cells = list(
        Schulnummer             = c(row = 3, col = 1),
        Klassenname             = c(row = 4, col = 1),
        Testdatum_Jahr          = c(row = 5, col = 3),
        Testdatum_Monat         = c(row = 5, col = 2),
        Testdatum_Tag           = c(row = 5, col = 1),
        Schulname               = c(row = 1, col = 1),
        Einverstaendnis_fehlend = c(row = 6, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range   = "C17:R167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG","Schulsport_1", "Schulsport_2", "Schulsport_3",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "C17:N167",
      colnames = c("Nr","Inklusion","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_54_m_Runden", "Run_Pylonen","Run_m_2" ,"Anmerkungen")
    )
  ),
  
  `2020_21` = list(
    School_year = "2020_21",
    extra_cols    = c(Erhebungswelle = "4"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E10",
      cells = list(
        Schulnummer             = c(row = 3, col = 1),
        Klassenname             = c(row = 4, col = 1),
        Testdatum_Jahr          = c(row = 5, col = 3),
        Testdatum_Monat         = c(row = 5, col = 2),
        Testdatum_Tag           = c(row = 5, col = 1),
        Schulname               = c(row = 1, col = 1),
        Einverstaendnis_fehlend = c(row = 6, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range   = "C17:R167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG","Schulsport_1", "Schulsport_2", "Schulsport_3",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "C17:N167",
      colnames = c("Nr","Inklusion","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_54_m_Runden", "Run_Pylonen","Run_m_2" ,"Anmerkungen")
    )
  ),
  
  `2021_22` = list(
    School_year = "2021_22",
    extra_cols    = c(Erhebungswelle = "5"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer     = c(row = 3, col = 1),
        Klassenname     = c(row = 1, col = 1),
        Testdatum_Jahr  = c(row = 2, col = 3),
        Testdatum_Monat = c(row = 2, col = 2),
        Testdatum_Tag   = c(row = 2, col = 1),
        Schulname       = c(row = 4, col = 1),
        Schulort        = c(row = 5, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range   = "C17:R167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG","Schulsport_1", "Schulsport_2", "Schulsport_3",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "C17:N167",
      colnames = c("Nr","Inklusion","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_54_m_Runden", "Run_Pylonen","Run_m_2" ,"Anmerkungen")
    )
  ),
  
  `2022_23` = list(
    School_year = "2022_23",
    extra_cols    = c(Erhebungswelle = "6"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer     = c(row = 3, col = 1),
        Klassenname     = c(row = 1, col = 1),
        Testdatum_Jahr  = c(row = 2, col = 3),
        Testdatum_Monat = c(row = 2, col = 2),
        Testdatum_Tag   = c(row = 2, col = 1),
        Schulname       = c(row = 4, col = 1),
        Schulort        = c(row = 5, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range   = "C17:R167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG","Schulsport_1", "Schulsport_2", "Schulsport_3",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "C17:N167",
      colnames = c("Nr","Inklusion","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_54_m_Runden", "Run_Pylonen","Run_m_2" ,"Anmerkungen")
    )
  ),
  
  `2023_24` = list(
    School_year = "2023_24",
    extra_cols    = c(Erhebungswelle = "7"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C3:F11",
      cells = list(
        Schulnummer          = c(row = 2, col = 1),
        Version_Eingabemaske = c(row = 1, col = 4),
        Klassenname          = c(row = 3, col = 1),
        Klassenstaerke       = c(row = 4, col = 1), 
        Testdatum_Jahr       = c(row = 5, col = 3),
        Testdatum_Monat      = c(row = 5, col = 2),
        Testdatum_Tag        = c(row = 5, col = 1),
        Schulname            = c(row = 6, col = 1),
        Postleitzahl         = c(row = 8, col = 1), 
        Schulort             = c(row = 9, col = 1)
      )   
    ), 
    profile = list(
      sheet   = 2,
      range = "A11:N167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche", "Verein_Jahr"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   # Seit wann ist das Kin in einem Sportverein?
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "A11:J167",
      colnames = c("Nr","Inklusion","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_Abbruch", "Anmerkungen")
    )
  ),
  
  `2024_25` = list(
    School_year = "2024_25",
    extra_cols    = c(Erhebungswelle = "8"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C3:F12",
      cells = list(
        Schulnummer          = c(row = 2, col = 1),
        Version_Eingabemaske = c(row = 1, col = 4),
        Klassenname          = c(row = 3, col = 1),
        Klassenstaerke       = c(row = 4, col = 1),
        Klassenstufenstaerke = c(row = 5, col = 1), 
        Testdatum_Jahr       = c(row = 6, col = 3),
        Testdatum_Monat      = c(row = 6, col = 2),
        Testdatum_Tag        = c(row = 6, col = 1),
        Schulname            = c(row = 7, col = 1),
        Postleitzahl         = c(row = 9, col = 1), 
        Schulort             = c(row = 10, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range = "A11:N167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche", "Verein_Jahr"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   # Seit wann ist das Kin in einem Sportverein?
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "A11:J167",
      colnames = c("Nr","KME_GE","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_Abbruch", "Anmerkungen")
    )
  ),
  
  `2025_26` = list(
    School_year = "2025_26",
    extra_cols    = c(Erhebungswelle = "9"),
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C3:F12",
      cells = list(
        Schulnummer          = c(row = 2, col = 1),
        Version_Eingabemaske = c(row = 1, col = 4),
        Klassenname          = c(row = 3, col = 1),
        Klassenstaerke       = c(row = 4, col = 1),
        Klassenstufenstaerke = c(row = 5, col = 1), 
        Testdatum_Jahr       = c(row = 6, col = 3),
        Testdatum_Monat      = c(row = 6, col = 2),
        Testdatum_Tag        = c(row = 6, col = 1),
        Schulname            = c(row = 7, col = 1),
        Postleitzahl         = c(row = 9, col = 1), 
        Schulort             = c(row = 10, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range = "A11:N167",
      colnames = c("Nr","Geschlecht",
                   "Geburtsdatum_Tag","Geburtsdatum_Monat","Geburtsdatum_Jahr",
                   "Groesse_cm", "Masse_kg",
                   "Schulsport_AG",
                   "Vereinsmitglied", "Verein_1","Verein_2","Verein_3",
                   "Verein_Woche", "Verein_Jahr"
                   # "Wie oft in der Woche wird die Sportart durchschnittlich betrieben (inkl. Wettkämpfe/Ligaspiele)?"
                   # Seit wann ist das Kin in einem Sportverein?
                   )
    ),
    tests = list(
      sheet   = 3,
      range   = "A11:J167",
      colnames = c("Nr","KME_GE","S20_s","BPT_m","SLJ_cm","OLB_s",
                   "Star_s","Run_m_1", "Run_Abbruch", "Anmerkungen")
    )
  )
)



#' Get a school_year layout
#'
#' Returns the layout specification for a given school_year.
#'
#' @param school_year Character or numeric, e.g. "2025_26".
#'
#' @return A layout list suitable for \code{read_sheets_in_file()} or
#'   \code{bind_xlsx_files_in_dir()}.
#' @export
get_layout <- function(school_year) {
  key <- as.character(school_year)
  lay <- .bekihist_layouts[[key]]
  if (is.null(lay)) {
    stop("No layout defined for school_year ", key, call. = FALSE)
  }
  lay
}

