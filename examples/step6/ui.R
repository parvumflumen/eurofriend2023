library(shiny)
library(dygraphs)

shinyUI(fluidPage(
    # Application title
    titlePanel("Dygraph + Shiny example"),

    
     dygraphOutput("myplot")
        
    )
)
