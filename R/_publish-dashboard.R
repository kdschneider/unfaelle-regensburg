# deploy script
# does not work...

dir.create(here::here("temp"))
dir.create(here::here("temp/data"))

file.copy(
  from = here::here("R/dashboard.Rmd"),
  to = here::here("temp/"),
  overwrite = TRUE
)

file.copy(
  from = here::here("data/regensburg_data.rda"),
  to = here::here("temp/data/"),
  overwrite = TRUE
)

file.copy(
  from = here::here("data/shapefiles.rda"),
  to = here::here("temp/data/"),
  overwrite = TRUE
)

rsconnect::deployApp(
  appDir = here::here("temp"),
  appName = "unfaelle-regensburg",
  forceUpdate = TRUE
)

Sys.sleep(5)

unlink(
  x = here::here("temp"),
  recursive = TRUE
)
