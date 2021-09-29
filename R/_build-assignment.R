# OUTPUT ASSIGNMENT ----

library(tidyverse)

if (!dir.exists(here::here("assignment"))) {
  dir.create(here::here("assignment"))
}

unlink(
  x = here::here("assignment/*"),
  recursive = TRUE,
  force = TRUE
)

## A ----

# Nutzen Sie R (oder QGIS) zum Export einer OSM-Karte (leaflet), welche in geclusterter Art Punktwolken entsprechender Daten visualisiert (Eichhörnchen, Meteoriten, UFO-Sichtungen, Atombombentests, ...).
# 
# Ordner: "aufgabe-a"
# 
# Dateien: R-Datei (oder QGis-Projektdateien), CSV-Datei und exportierte HTML-Datei.

dir.create(here::here("assignment/aufgabe-a"))
dir.create(here::here("assignment/aufgabe-a/data"))
dir.create(here::here("assignment/aufgabe-a/output"))

# copy data

# csv
load(
  file = here::here("data/regensburg_data.rda")
)

write_csv2(
  x = data,
  file = here::here("assignment/aufgabe-a/data/regensburg_data.csv")
)

# rda

file.copy(
  from = here::here("data/regensburg_data.rda"),
  to = here::here("assignment/aufgabe-a/data/")
)

file.copy(
  from = here::here("data/shapefiles.rda"),
  to = here::here("assignment/aufgabe-a/data/")
)

# purl
knitr::purl(
  input = here::here("chapters/03-leaflet_map.Rmd"),
  output = here::here("assignment/aufgabe-a/unfaelle-leaflet.R")
)

# source

setwd(here::here("assignment/aufgabe-a"))

source(
  file = "./unfaelle-leaflet.R",
  local = TRUE
)

setwd(here::here())

## B ----

# Ein Datenprojekt Ihrer Wahl. Dies muss nicht in R realisiert sein, kann mit einem Werkzeug Ihrer Wahl entstehen.
# 
# Ordner: "aufgabe-b"
# 
# Ziel: Text und überzeugende Darstellung der Ergebnisse.

dir.create(here::here("assignment/aufgabe-b"))

file.copy(
  from = here::here("docs/unfaelle-regensburg.html"),
  to = here::here("assignment/aufgabe-b/unfaelle-regensburg.html")
)

## C ----

dir.create(here::here("assignment/aufgabe-c"))
dir.create(here::here("assignment/aufgabe-c/data"))

# rda

file.copy(
  from = here::here("data/regensburg_data.rda"),
  to = here::here("assignment/aufgabe-c/data/")
)

file.copy(
  from = here::here("data/shapefiles.rda"),
  to = here::here("assignment/aufgabe-c/data/")
)

# dashboard

file.copy(
  from = here::here("R/unfaelle-dashboard.Rmd"),
  to = here::here("assignment/aufgabe-c/unfaelle-dashboard.Rmd")
)

# zip ----

library(zip)

for (folder in list.dirs(here::here("assignment"), full.names = FALSE, recursive = FALSE)) {
  zip(
    zipfile = here::here("assignment", folder, glue::glue("{folder}.zip")),
    files = here::here("assignment", folder),
    recurse = TRUE,
    include_directories = TRUE,
    mode = "cherry-pick"
  )
}
