library(shiny)
library(RNetCDF)

shinyServer(function(input, output, session) {
  
  basins <- sf::st_read(dsn = "../../data/stationbasins.geojson")
  
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
  
  runoff <- RNetCDF::open.nc(con = "../../data/GRDC-Daily.nc")
  
  values <- var.get.nc(runoff, 
                       "runoff_mean",
                       start=c(4,1),
                       count=c(1,NA))  
  
  timestamps <- var.get.nc(runoff, 
                           "time",
                           start=1,
                           count=NA)  
  
  timestamps <- as.Date("1700-01-01") + timestamps
  
  ts <- zoo::as.zooreg(zoo::zoo(values,timestamps))
  
  output$myplot <- renderDygraph(
    dygraph(ts, xlab="time",
            ylab = "runoff [m³/s]")
  )
  
})