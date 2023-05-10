library(RNetCDF)
library(sf)

basins <- sf::st_read(dsn = "../../stationbasins.geojson")
runoff <- RNetCDF::open.nc(con = "../../data/GRDC-Daily.nc")


plot(basins)
print.nc(runoff)

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

plot(ts)

