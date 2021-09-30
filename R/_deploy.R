# build all
source(
  here::here("R/_build-book.R")
)

source(
  here::here("R/_build-assignment.R")
)

cleanEnv <- new.env()
source(
  file = here::here("R/_publish-dashboard.R"),
  local = cleanEnv
)
