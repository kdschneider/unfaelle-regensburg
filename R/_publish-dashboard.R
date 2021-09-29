# deploy script

library(rsconnect)

rmarkdown::run(
  file = here::here("R/unfaelle-dashboard.Rmd")
)
