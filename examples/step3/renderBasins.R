library(leaflet)

basins <- sf::st_read(dsn = "../../data/stationbasins.geojson")
rivers <- sf::st_read(dsn = "../../data/mrb_rivnets_Q09_10.json")

map <- leaflet(basins) %>%
  addProviderTiles(providers$Stamen.TonerLite,
                   options = providerTileOptions(noWrap = TRUE)
  ) %>% leaflet::addPolygons(stroke = TRUE,
                             color="white",
                             weight=2,
                             smoothFactor = 0.3, 
                             fillOpacity = 0.5,
                             fillColor = "green") %>%
  leaflet::addPolylines(data = rivers,
                        color="blue",
                        weight = 1)  

map
