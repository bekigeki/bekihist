#' BEKI Scientific-Use-File: derzeit nur auf Anfrage
#'
#' Zusammengeführter BEKI-Kohortendatensatz, gefiltert auf Zeilen mit
#' mindestens einem nicht-fehlenden Messwert oder zentralen Fragebogenmerkmal. 
#'
#' @format Ein Tibble mit 85.388 Zeilen und 50 Variablen:
#' \describe{
#'   \item{.row}{Zeilenindex aus dem ursprünglichen Import innerhalb jeder Excel-Datei.}
#'   \item{Anmerkungen}{Freitext-Kommentare der Testleiter:innen.}
#'   \item{BPT_m}{Weite des Medizinballstoßes in Metern (als Zeichenkette, numerischer Wert).}
#'   \item{Cohort}{Kohortenkennung (z.B. \code{"2017"}, \code{"2018"}).}
#'   \item{Datensatz_erstellt_am}{Datum, an dem dieser kombinierte Datensatz erzeugt wurde (\code{Date}).}
#'   \item{Einverstaendnis_fehlend}{Marker, dass eine schriftliche Einwilligung fehlt.}
#'   \item{Geburtsdatum_Jahr}{Geburtsjahr (Zeichenkette, vierstellige Jahreszahl).}
#'   \item{Geburtsdatum_Monat}{Geburtsmonat (Zeichenkette, \code{"1"}–\code{"12"}).}
#'   \item{Geburtsdatum_Tag}{Geburtstag (Tag im Monat, Zeichenkette, \code{"1"}–\code{"31"}).}
#'   \item{Geburtsdatum_XLSX}{Rohwert des Geburtsdatums aus Excel (Tage seit Excel-Datumursprung).}
#'   \item{Geschlecht}{Geschlecht des Kindes (\code{"m"} = männlich, \code{"w"} = weiblich).}
#'   \item{Groesse_cm}{Körpergröße in Zentimetern (als Zeichenkette, numerischer Wert).}
#'   \item{Inklusion}{Inklusionskennzeichnung (\code{"nein"} oder \code{"ja"}).}
#'   \item{Klassenname}{Bezeichnung des Klassenames innerhalb der Schule (z.B. \code{"3a"} für erste 3. Klasse).}
#'   \item{Klassenstaerke}{Anzahl der Schüler:innen in der Klasse.}
#'   \item{Klassenstufenstaerke}{Anzahl der Schüler:innen in der Klassenstufe an der Schule.}
#'   \item{KME_GE}{Neue Kennung für Inklusion ab Cohort == 2024 (Förderschwerpunkt körperliche und motorische Entwicklung und geistige Entwicklung).}
#'   \item{Masse_kg}{Körpermasse in Kilogramm (als Zeichenkette, numerischer Wert).}
#'   \item{Nr.x}{Pseudonymisierte Teilnehmerkennung (aus den Roh-Excel-Dateiblatt "Schülerprofil" übernommen).}
#'   \item{Nr.y}{Pseudonymisierte Teilnehmerkennung (aus den Roh-Excel-Dateiblatt "Testdaten" übernommen)).}
#'   \item{OLB_s}{Einbeinstand-Dauer in Sekunden (als Zeichenkette, numerischer Wert).}
#'   \item{Postleitzahl}{Postleitzahl des Schulstandorts.}
#'   \item{Run_54_m_Runden}{Anzahl absolvierte Runden im 9-Minuten-Lauf (54-m-Runden, bis Cohort == 2022).}
#'   \item{Run_Abbruch}{Kennzeichnung, dass der 9-Minuten-Lauf abgebrochen wurde.}
#'   \item{Run_m_1}{zurückgelegte Strecke in Metern im 9-Minuten-Lauf (Selbsteingabe).}
#'   \item{Run_m_2}{zurückgelegte Strecke in Metern im 9-Minuten-Lauf (in Excel aus Run_54_m_Runden und Run_Pylonen berechnet, bis Cohort==2022).}
#'   \item{Run_Pylonen}{Anzahl passierter Pylonen im Ausdauertest (bis Cohort == 2022).}
#'   \item{S20_s}{20-m-Sprintzeit in Sekunden (als Zeichenkette, numerischer Wert).}
#'   \item{Schulname}{Offizieller Name der Schule.}
#'   \item{Schulnummer}{Institutionskennziffer der Schule.}
#'   \item{Schulort}{Ort der Schule.}
#'   \item{Schulsport_1}{Erste angegebene Schulsport-AG (z.B. \code{"Tanzen/Aerobic"}, \code{"Skisport"}, \code{"Große Sportspiele*"}, bis Cohort == 2022).}
#'   \item{Schulsport_2}{Zweite Schulsport-AG (bis Cohort == 2022).}
#'   \item{Schulsport_3}{Dritte Schulsport-AG (bis Cohort == 2022).}
#'   \item{Schulsport_AG}{Merkmal für die Teilnahme an einer Schulsport-AG (\code{"ja"} / \code{"nein"}).}
#'   \item{SLJ_cm}{Weite des Standweitsprungs in Zentimetern (als Zeichenkette, numerischer Wert).}
#'   \item{Star_s}{Zeit im Sternlauf in Sekunden (als Zeichenkette, numerischer Wert).}
#'   \item{Testdatum_Jahr}{Testjahr (Zeichenkette, vierstellige Jahreszahl).}
#'   \item{Testdatum_Monat}{Testmonat (Zeichenkette, \code{"1"}–\code{"12"}).}
#'   \item{Testdatum_Tag}{Testtag (Tag im Monat, Zeichenkette, \code{"1"}–\code{"31"}).}
#'   \item{Verein_1}{Erste angegebene Vereinssportart (z.B. Spiele, Turnen/Gymnastik).}
#'   \item{Verein_2}{Zweite Vereinssportart, falls angegeben.}
#'   \item{Verein_3}{Dritte Vereinssportart, falls angegeben.}
#'   \item{Verein_Jahr}{Jahr erstmaliger Mitgliedschaft in einem Sportverein.}
#'   \item{Verein_Woche}{Anzahl der Trainingseinheiten pro Woche im Verein (Zeichenkette, numerischer Wert).}
#'   \item{Vereinsmitglied}{Merkmal für Mitgliedschaft in einem Sportverein (\code{"ja"} / \code{"nein"}).}
#'   \item{Version_Eingabemaske}{Version der verwendeten Excel-Eingabemaske.}
#'   \item{XLSX_date_origin_fixed}{Korrigierter Excel-Datumursprung zur Umrechnung der Datumsserien (z.B. \code{"1899-12-30"}).}
#'   \item{XLSX_date_origin_import}{Beim Import angenommener Excel-Datumursprung (typischerweise \code{"1900-01-01"}).}
#'   \item{XLSX_Dateiname}{Name der ursprünglichen Excel-Datei, aus der die Daten importiert wurden.}
#' }
#'
#' @details
#' Alle Variablen außer \code{Datensatz_erstellt_am} liegen als Zeichenketten vor,
#' um die ursprüngliche Excel-Eingabe inklusive spezieller Codes und Formatierungen
#' unverändert zu erhalten; Messvariablen können bei Bedarf von Nutzer:innen in
#' numerische Typen umgewandelt werden. 
#'
#' Der Datensatz enthält nur diejenigen Zeilen, in denen mindestens eine
#' zentrale Mess- oder Fragebogensvariable nicht fehlend ist, entsprechend der
#' Filterlogik in \code{\link{bind_cohorts}}. 
#'
#' @source Aggregierte und harmonisierte BEKI-Kohortendaten aus Thüringer Schulen.
#' @keywords datasets
#' @docType data
#' @name beki_scientific_use_file
#' @usage data(beki_scientific_use_file)
"beki_scientific_use_file"

