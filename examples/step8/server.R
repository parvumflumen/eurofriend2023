library(shiny)
library(RNetCDF)


getTs <- function(grdc_num, nc) {
  stations_ts <- RNetCDF::var.get.nc(nc, "id")
  index <- match(grdc_num,stations_ts)
  if (!is.na(index)) {
    x <- var.get.nc(nc, 
                    "runoff_mean",
                    start=c(index,1),
                    count=c(1,NA))
    timestamps <- var.get.nc(runoff, 
                             "time",
                             start=1,
                             count=NA)
    timestamps <- as.Date("1700-01-01") + timestamps
    ts <- zoo::as.zooreg(zoo::zoo(x,timestamps))
    
  } else {
    ts <- NA
  }
  return(ts)
}

shinyServer(function(input, output, session) {
  
  basins <- sf::st_read(dsn = "../../data/stationbasins.geojson")
  
  output$mymap <- renderLeaflet({
    leaflet(basins) %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>% leaflet::addPolygons(stroke = TRUE,
                                 color="white",
                                 weight=2,
                                 smoothFactor = 0.3, 
                                 fillOpacity = 0.5,
                                 fillColor = "green",
                                 layerId = ~GRDC_NO) %>%
      leaflet::addPolylines(data = rivers,
                            color="blue",
                            weight = 1) 
      
  })
  
  runoff <- RNetCDF::open.nc(con = "../../data/GRDC-Daily.nc")
  
  observeEvent(input$mymap_shape_click, { 
    p <- input$mymap_shape_click
    print(p$id)
    ts <- getTs(grdc_num = p$id,
                nc = runoff)
    
    output$myplot <- renderDygraph(
      dygraph(ts, xlab="time",
              ylab = "runoff [m³/s]",
              main = paste0(basins[basins$GRDC_NO == p$id,]$RIVER,
                            ": gauge ",
                            basins[basins$GRDC_NO == p$id,]$STATION)
    )
  })
  
  
  
  
  
  
  
  
  
})