# OUTPUT ASSIGNMENT ----

if (!dir.exists(here::here("output"))) {
  dir.create(here::here("output"))
  dir.create(here::here("output/assignment"))
}

if (dir.exists(here::here("output/assignment"))) {
  unlink(
    x = here::here("output/assignment"),
    recursive = TRUE
  )
  dir.create(here::here("output/assignment"))  
} else {
  dir.create(here::here("output/assignment"))
}

## A ----

# Nutzen Sie R (oder QGIS) zum Export einer OSM-Karte (leaflet), welche in geclusterter Art Punktwolken entsprechender Daten visualisiert (Eichhörnchen, Meteoriten, UFO-Sichtungen, Atombombentests, ...).
# 
# Ordner: "aufgabe-a"
# 
# Dateien: R-Datei (oder QGis-Projektdateien), CSV-Datei und exportierte HTML-Datei.

if (!dir.exists(here::here("output/assignment/aufgabe-a"))) {
  dir.create(here::here("output/assignment/aufgabe-a"))
}

# csv
load(
  file = here::here("data/regensburg_data.rda")
)

write_csv2(
  x = data,
  file = here::here("output/assignment/aufgabe-a/regensburg_data.csv")
)

# data.rda
load(
  file = here::here("data/shapefiles.rda")
)

save(
  list = c("data", "sf.districts", "sf.highways", "sf.regensburg", "sf.rivers"),
  file = here::here("output/assignment/aufgabe-a/data.rda")
)

# purl
knitr::purl(
  input = here::here("chapters/03-leaflet_map.Rmd"),
  output = here::here("output/assignment/aufgabe-a/leaflet.R")
)

# source
setwd(here::here("output/assignment/aufgabe-a"))

source(
  here::here("output/assignment/aufgabe-a/leaflet.R"),
  local = TRUE
)

setwd(here::here)

## B ----

# Ein Datenprojekt Ihrer Wahl. Dies muss nicht in R realisiert sein, kann mit einem Werkzeug Ihrer Wahl entstehen.
# 
# Ordner: "aufgabe-b"
# 
# Ziel: Text und überzeugende Darstellung der Ergebnisse.

if (!dir.exists(here::here("output/assignment/aufgabe-b"))) {
  dir.create(here::here("output/assignment/aufgabe-b"))
}

file.copy(
  from = here::here("docs/unfaelle-regensburg.html"),
  to = here::here("docs/unfaelle-regensburg.html")
)

## C ----