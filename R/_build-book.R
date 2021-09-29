# BUILD SCRIPT ----

## build book ----
# folder: docs
if (!dir.exists(here::here("docs"))) {
  dir.create(
    here::here("docs")
  )
}

unlink(
  x = here::here("docs/*"),
  recursive = TRUE,
  force = TRUE
)

# folder: output
if (!dir.exists(here::here("output"))) {
  dir.create(
    here::here("output")
  )
}

unlink(
  x = here::here("output/*"),
  recursive = TRUE,
  force = TRUE
)


# render book
bookdown::render_book(
  input = here::here(),
  output_format = "all",
  clean = TRUE
)

# move single-file html to ./docs/
file.rename(
  from = here::here("unfaelle-regensburg.html"),
  to = here::here("docs/unfaelle-regensburg.html")
)

# create .nojekyll for github pages
if (!file.exists(here::here("docs/.nojekyll"))) {
  file.create(
    here::here("docs/.nojekyll")
  )
}

# tidy up caches
if (dir.exists(here::here("_bookdown_files"))) {
  unlink(
    x = here::here("_bookdown_files"),
    recursive = TRUE,
    force = TRUE
  )
}
