library(tidyverse)
library(leaflet)
library(sf)

load(
  here::here("data/regensburg_data.rda")
)

load(
  here::here("data/shapefiles.rda")
)

sf.data <-
  data |> 
  st_as_sf(coords = c("lng", "lat"), crs = "WGS84")

bounds <- sf.regensburg |> st_bbox()

map <- 
  leaflet(
    options = leafletOptions(
      crs = leafletCRS(code = "WGS84"),
      preferCanvas = NULL
    )
  ) |> 
  addProviderTiles(
    provider = providers$OpenStreetMap.DE,
    group = "OSM",
    options = providerTileOptions(minZoom = 11)
  ) |> 
  setView(
    lng = (as.numeric(bounds[1]) + as.numeric(bounds[3]))/2,
    lat = (as.numeric(bounds[2]) + as.numeric(bounds[4]))/2,
    zoom = 12
  ) |> 
  setMaxBounds(
    lng1 = as.numeric(bounds[1] - 0.015), 
    lat1 = as.numeric(bounds[2] - 0.015), 
    lng2 = as.numeric(bounds[3] + 0.015), 
    lat2 = as.numeric(bounds[4] + 0.015)
  )



custom_popup <- function(data, header) {
  text <- 
    glue::glue(
      "<b>{header}</b> ",
      "<br>",
      "{data$month}/{data$year} ({data$hour} Uhr)"
    )
  return(text)
}

map <- 
  map |> 
  addAwesomeMarkers(
    data = data |> filter(severity == "Toedlich"),
    group = "Tödliche Unfälle",
    lng = ~lng,
    lat = ~lat,
    icon = awesomeIcons(
      icon = 'ios-close',
      iconColor = 'black',
      library = 'ion',
      markerColor = "red"
    ),
    clusterOptions = markerClusterOptions(),
    popup = custom_popup(
      data = data |> filter(severity == "Toedlich"), 
      header = "Tödlicher Unfall"
    )
  ) |> 
  addAwesomeMarkers(
    data = data |> filter(severity == "Schwer"),
    group = "Schwere Unfälle",
    lng = ~lng,
    lat = ~lat,
    icon = awesomeIcons(
      icon = 'ios-close',
      iconColor = 'black',
      library = 'ion',
      markerColor = "orange"
    ),
    clusterOptions = markerClusterOptions(),
    popup = custom_popup(
      data = data |> filter(severity == "Schwer"), 
      header = "Schwerer Unfall"
    )
  ) |> 
  addAwesomeMarkers(
    data = data |> filter(severity == "Leicht"),
    group = "Leichte Unfälle",
    lng = ~lng,
    lat = ~lat,
    icon = awesomeIcons(
      icon = 'ios-close',
      iconColor = 'black',
      library = 'ion',
      markerColor = "beige"
    ),
    clusterOptions = markerClusterOptions(),
    popup = custom_popup(
      data = data |> filter(severity == "Leicht"), 
      header = "Leichter Unfall"
    )
  )



custom_label <- function(data) {
  text <- glue::glue(
    "{data$district}: {data$n} Unfälle"
  )
  return(text)
}

districts <-
  data |> 
  st_as_sf(coords = c("lng", "lat"), crs = "WGS84") |> 
  rename(
    points = geometry
  ) |> 
  st_join(
    y = sf.districts |> rename("district_shape" = geometry),
    join = st_within,
    left = TRUE
  ) |> 
  select(-m2) |> 
  as_tibble() |> 
  left_join(
    y = sf.districts |> rename("district_polygon" = geometry) ,
    by = "district"
  ) |>
  drop_na(district) |>
  mutate(
    district = as_factor(district) |>
      fct_infreq() |>
      fct_rev()
  ) |> 
  add_count(district) |> 
  select(district, district_polygon, n) |> 
  unique() |> 
  st_as_sf()

map <-
  map |> 
  addPolygons(
    data = districts,
    group = "Stadtteile",
    opacity = 1,
    weight = 0.5, 
    fillOpacity = 0.5,
    color = "black",
    fillColor = ~colorNumeric("viridis", n)(n),
    highlightOptions = highlightOptions(
      color = "white", 
      weight = 2,
      bringToFront = TRUE
    ),
    label = ~custom_label(data = districts)
  )



map <- 
  map |> 
    addProviderTiles(
      provider = providers$Stamen.TonerBackground,
      group = "Stadtteile",
      options = providerTileOptions(minZoom = 11)
    ) |> 
    addLayersControl(
      baseGroups = c("OSM", "Stadtteile"),
      overlayGroups = c("Tödliche Unfälle", "Schwere Unfälle", "Leichte Unfälle"),
      options = layersControlOptions(collapsed = FALSE)
    )



## append this
mapview::mapshot(
  x = map,
  url = "./output/unfaelle-leaflet.html",
  selfcontained = TRUE
)
