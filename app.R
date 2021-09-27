# app.R ----
library(shiny)
library(shinydashboard)
library(dashboardthemes)

library(tidyverse)

load(here::here("data/regensburg_data.rda"))


## ui ----
my_header <- dashboardHeader(
  title = "Unfälle in Regensburg"
)

my_sidebar <- dashboardSidebar(
  collapsed = FALSE,
  
  sliderInput(
    inputId = "v_year",
    label = "Jahre",
    min = min(data$year),
    max = max(data$year),
    value = c(min(data$year), max(data$year)),
    sep = "",
    dragRange = FALSE
  )
  
)

my_body <- dashboardBody(
  
  # shinyDashboardTheme
  shinyDashboardThemes(
    theme = "poor_mans_flatly"
  ),
  
  # Boxes need to be put in a row (or column)
  fluidRow(
    box(plotOutput("plot1", height = 250))
  )
)

ui <- dashboardPage(
  title = "Unfälle Regensburg",
  
  header = my_header,
  sidebar = my_sidebar,
  body = my_body
  
)

## server ----
server <- function(input, output) {

  data.filtered <- reactive({
    
  })
  
  # output$plot1 <- renderPlot({
  #   data <- histdata[seq_len(input$slider)]
  #   hist(data)
  # })
}

shinyApp(ui, server)