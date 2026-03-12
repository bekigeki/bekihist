.bekihist_layouts <- list(
  
  `2017` = list(
    Cohort = "2017", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer           = c(row = 3, col = 1),
        Klassenname           = c(row = 4, col = 1),
        Testzeitpunkt_Jahr     = c(row = 5, col = 3),
        Testzeitpunkt_Monat    = c(row = 5, col = 2),
        Testzeitpunkt_Tag      = c(row = 5, col = 1),
        Schulname              = c(row = 1, col = 1)
      )   
    ),
    profile = list(
      sheet   = 2,
      range   = "C17:R167",
      colnames = c("Nr","Geschlecht","Geburtsdatum_TTMMJJ",
                   "Geburtsdatum_Monat","Geburtsdatum_Jahr",
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
                   "Star_s","Run_m1", "Run_54_m_Runden", "Run_Pylonen","Run_m2" ,"Anmerkungen")
    )
  ),
  
  `2018` = list(
    Cohort = "2018", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer           = c(row = 3, col = 1),
        Klassenname           = c(row = 4, col = 1),
        Testzeitpunkt_Jahr     = c(row = 5, col = 3),
        Testzeitpunkt_Monat    = c(row = 5, col = 2),
        Testzeitpunkt_Tag      = c(row = 5, col = 1),
        Schulname              = c(row = 1, col = 1)
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
                   "Star_s","Run_m1", "Run_54_m_Runden", "Run_Pylonen","Run_m2" ,"Anmerkungen")
    )
  ),
  
  `2019` = list(
    Cohort = "2019", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E10",
      cells = list(
        Schulnummer            = c(row = 3, col = 1),
        Klassenname            = c(row = 4, col = 1),
        Testzeitpunkt_Jahr     = c(row = 5, col = 3),
        Testzeitpunkt_Monat    = c(row = 5, col = 2),
        Testzeitpunkt_Tag      = c(row = 5, col = 1),
        Schulname              = c(row = 1, col = 1),
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
                   "Star_s","Run_m1", "Run_54_m_Runden", "Run_Pylonen","Run_m2" ,"Anmerkungen")
    )
  ),
  
  `2020` = list(
    Cohort = "2020", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E10",
      cells = list(
        Schulnummer           = c(row = 3, col = 1),
        Klassenname           = c(row = 4, col = 1),
        Testzeitpunkt_Jahr     = c(row = 5, col = 3),
        Testzeitpunkt_Monat    = c(row = 5, col = 2),
        Testzeitpunkt_Tag      = c(row = 5, col = 1),
        Schulname              = c(row = 1, col = 1),
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
                   "Star_s","Run_m1", "Run_54_m_Runden", "Run_Pylonen","Run_m2" ,"Anmerkungen")
    )
  ),
  
  `2021` = list(
    Cohort = "2021", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer           = c(row = 3, col = 1),
        Klassenname           = c(row = 1, col = 1),
        Testzeitpunkt_Jahr     = c(row = 2, col = 3),
        Testzeitpunkt_Monat    = c(row = 2, col = 2),
        Testzeitpunkt_Tag      = c(row = 2, col = 1),
        Schulname              = c(row = 4, col = 1),
        Schulort               = c(row = 5, col = 1)
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
                   "Star_s","Run_m1", "Run_54_m_Runden", "Run_Pylonen","Run_m2" ,"Anmerkungen")
    )
  ),
  
  `2022` = list(
    Cohort = "2022", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C5:E9",
      cells = list(
        Schulnummer           = c(row = 3, col = 1),
        Klassenname           = c(row = 1, col = 1),
        Testzeitpunkt_Jahr     = c(row = 2, col = 3),
        Testzeitpunkt_Monat    = c(row = 2, col = 2),
        Testzeitpunkt_Tag      = c(row = 2, col = 1),
        Schulname              = c(row = 4, col = 1),
        Schulort               = c(row = 5, col = 1)
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
                   "Star_s","Run_m1", "Run_54_m_Runden", "Run_Pylonen","Run_m2" ,"Anmerkungen")
    )
  ),
  
  `2023` = list(
    Cohort = "2023", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C3:F11",
      cells = list(
        Schulnummer            = c(row = 2, col = 1),
        Version_Eingabemaske   = c(row = 1, col = 4),
        Klassenname            = c(row = 3, col = 1),
        Klassenstaerke         = c(row = 4, col = 1), 
        Testzeitpunkt_Jahr     = c(row = 5, col = 3),
        Testzeitpunkt_Monat    = c(row = 5, col = 2),
        Testzeitpunkt_Tag      = c(row = 5, col = 1),
        Schulname              = c(row = 6, col = 1),
        Postleitzahl           = c(row = 8, col = 1), 
        Schulort               = c(row = 9, col = 1)
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
                   "Star_s","Run_m1", "Run_Abbruch", "Anmerkungen")
    )
  ),
  
  `2024` = list(
    Cohort = "2024", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C3:F12",
      cells = list(
        Schulnummer            = c(row = 2, col = 1),
        Version_Eingabemaske   = c(row = 1, col = 4),
        Klassenname            = c(row = 3, col = 1),
        Klassenstaerke         = c(row = 4, col = 1),
        Klassenstufenstaerke   = c(row = 5, col = 1), 
        Testzeitpunkt_Jahr     = c(row = 6, col = 3),
        Testzeitpunkt_Monat    = c(row = 6, col = 2),
        Testzeitpunkt_Tag      = c(row = 6, col = 1),
        Schulname              = c(row = 7, col = 1),
        Postleitzahl           = c(row = 9, col = 1), 
        Schulort               = c(row = 10, col = 1)
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
                   "Star_s","Run_m1", "Run_Abbruch", "Anmerkungen")
    )
  ),
  
  `2025` = list(
    Cohort = "2025", 
    join_col = ".row",
    school = list(
      sheet = 1,
      range = "C3:F12",
      cells = list(
        Schulnummer            = c(row = 2, col = 1),
        Version_Eingabemaske   = c(row = 1, col = 4),
        Klassenname            = c(row = 3, col = 1),
        Klassenstaerke         = c(row = 4, col = 1),
        Klassenstufenstaerke   = c(row = 5, col = 1), 
        Testzeitpunkt_Jahr     = c(row = 6, col = 3),
        Testzeitpunkt_Monat    = c(row = 6, col = 2),
        Testzeitpunkt_Tag      = c(row = 6, col = 1),
        Schulname              = c(row = 7, col = 1),
        Postleitzahl           = c(row = 9, col = 1), 
        Schulort               = c(row = 10, col = 1)
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
                   "Star_s","Run_m1", "Run_Abbruch", "Anmerkungen")
    )
  )
)



#' Get a cohort layout
#'
#' Returns the layout specification for a given cohort.
#'
#' @param cohort Character or numeric, e.g. "2025".
#'
#' @return A layout list suitable for \code{read_sheets_in_file()} or
#'   \code{bind_files_in_dir()}.
#' @export
get_layout <- function(cohort) {
  key <- as.character(cohort)
  lay <- .bekihist_layouts[[key]]
  if (is.null(lay)) {
    stop("No layout defined for cohort ", key, call. = FALSE)
  }
  lay
}

