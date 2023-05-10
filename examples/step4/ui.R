library(shiny)
library(leaflet)

shinyUI(fluidPage(
    # Application title
    titlePanel("GTN-R data"),

    sidebarLayout(
        sidebarPanel(
            
        ),
        mainPanel(
            leafletOutput("mymap")
        )
    )
))
