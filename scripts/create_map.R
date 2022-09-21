create_map <- function(lat, long){
    library(leaflet)
  library(leaflet.opacity)
  
  epsg4258 <- leafletCRS(crsClass="L.Proj.CRS", code="EPSG:4258", proj4def="+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs", resolutions=1.5^(25:15))	
  
  driver = "ESRI Shapefile"
  df <- data.frame(lat=lat, long=long)
  m <- leaflet(
    options=list(center = c(lat, long), zoom = 16, maxBounds = list(list(1, -180), list(78, 180)))
    )
  m <- addTiles(m, layerId="base", group="base")
  m <- addWMSTiles(m, 
                   "https://geoserveis.icgc.cat/icc_mapesbase/wms/service",
                   layers="mtc5m",
                   options = WMSTileOptions(format = "image/png", transparent = TRUE),
                   attribution = "ICGC",
                   layerId = "mtc5m",
                   group="mtc", 
  )
  m <- addWMSTiles(m, 
                   "https://www.ign.es/wms-inspire/pnoa-ma",
                   layers = "OI.OrthoimageCoverage",
                   options = WMSTileOptions(format = "image/png", transparent = TRUE),
                   attribution = "Instituto Geogr?fico Nacional",
                   layerId = "ortofoto", 
                   group = "ortofoto",
  )
  m <- addWMSTiles(m, 
                   "https://www.ign.es/wms/pnoa-historico",
                   layers = "AMS_1956-1957",
                   options = WMSTileOptions(crs=epsg4258, format="jpeg", transparent=TRUE),
                   attribution = "Instituto Geogr?fico Nacional",
                   layerId = "1956", 
                   group = "1956",
  )
  
  m <- addLayersControl(m, 
                        baseGroups = c("base", "topo", "1956", "ortofoto"),
                        options = layersControlOptions(collapsed = FALSE)
  )
  
  m <- 	addMarkers(m, long, lat)
  
  return(m)
}