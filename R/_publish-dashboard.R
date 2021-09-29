# deploy script
# does not work...

rsconnect::deployDoc(
  doc = here::here("R/unfaelle-dashboard.Rmd"),
  appName = "unfaelle-regensburg",
  appTitle = "Unfälle Regensburg",
  forceUpdate = TRUE
)