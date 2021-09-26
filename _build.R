# build book

# check if ./docs/ exists and create
if (!dir.exists(here::here("docs"))) {
  dir.create(
    here::here("docs")
  )
}

# delete all caches for clean build
if (dir.exists(here::here("_bookdown_files"))) {
  unlink(
    x = here::here("_bookdown_files"),
    recursive = TRUE,
    force = TRUE
  )
}

# empty output folder
unlink(
  x = here::here("docs/*"),
  recursive = TRUE,
  force = TRUE
)

if (file.exists(here::here("unfaelle-regensburg.html"))) {
  file.remove(
    here::here("unfaelle-regensburg.html")
  )
}


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
