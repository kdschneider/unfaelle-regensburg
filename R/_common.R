# R options set globally
options(width = 60)

# chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  message = FALSE,
  warning = FALSE,
  echo = TRUE,
  cache = FALSE,
  # figure options
  fig.width = 6,
  fig.height = 4,
  fig.align = "center",
  fig.retina = 3,
  out.width = "95%"
)

# ggplot2

ggplot2::theme_set(
  ggthemes::theme_clean()
)

# colour theme 

## fill colour scale
scale_fill_custom <- 
  viridis::scale_fill_viridis(
    discrete = TRUE,
    option = "D",
    direction = -1
  )