library(shiny)
library(leaflet)

shinyUI(fluidPage(
    # Application title
    titlePanel("GTN-R data"),

    
    leafletOutput("mymap")
    
))
