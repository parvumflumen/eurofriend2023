library(shiny)

shinyServer(function(input, output, session) {
  
  basins <- sf::st_read(dsn = "../../stationbasins.geojson")
  
  output$mymap <- renderLeaflet({
    leaflet(basins) %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>% leaflet::addPolygons(stroke = TRUE,
                                 color="white",
                                 smoothFactor = 0.3, 
                                 fillOpacity = 1,
                                 fillColor = "blue")
  })    
  
})