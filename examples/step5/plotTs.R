library(RNetCDF)
library(dygraphs)

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

dygraphs::dygraph(ts, 
                  xlab = "time",
                  ylab = "runoff [m³/s]")
