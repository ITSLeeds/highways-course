## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # generate/publish online the materials
## piggyback::pb_new_release(tag = "0.1")
## file.rename("README.docx", "highways-course.docx")
## piggyback::pb_upload("highways-course.docx")
## knitr::purl("README.Rmd")

## ---- message=FALSE, warning=FALSE---------------------------------------
pkgs = c(
  "osmdata",   # for working with open street map data
  "sf",        # a package for working with spatial data
  "stplanr",   # a transport data package
  "tidyverse", # metapackage for data science
  "tmap"       # a mapping package
)

pkgs_installed = pkgs %in% installed.packages()
names(pkgs_installed) = pkgs
pkgs_installed
if(!all(pkgs_installed)) {
  install.packages(pkgs[!pkgs_installed])
}

# Make sure your packages are up-to-date with:

update.packages(ask = FALSE)

## ---- message=FALSE------------------------------------------------------
devtools::install_github("RACFoundation/oneminutetrafficdata")

## ---- message=FALSE------------------------------------------------------
library(sf)
library(stplanr)
library(tidyverse)

## ------------------------------------------------------------------------
origin_lnd = geo_code("London Kings Cross")
destination = geo_code("Worsley Building, Leeds")
odmatrix = matrix(c(origin_lnd, destination), ncol = 2, byrow = TRUE)
line_lnd = st_linestring(odmatrix) %>% 
  st_sfc() %>% 
  st_sf(crs = 4326)
m1 = tmap::qtm(line_lnd)
tmap::tmap_leaflet(m1)

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## origin_lds = geo_code("Leeds rail station")
## destination = geo_code("Worsley Building, Leeds")
## bb = matrix(c(-1.56, 53.7, -1.53, 53.9), ncol = 2)
## library(osmdata)
## roads = opq(bbox = bb) %>%
##   add_osm_feature(key = "highway", value = "pri|sec|res", value_exact = FALSE) %>%
##   osmdata_sf()

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## sln = SpatialLinesNetwork(roads$osm_lines)
## 
## from_sln = find_network_nodes(sln, origin_lds[1], origin_lds[2])
## to_sln = find_network_nodes(sln, destination[1], destination[2])
## 
## r_local = sum_network_routes(sln, from_sln, to_sln, "length", combinations = F)
## 
## m2 = tmap::qtm(r_local)
## library(leaflet)
## tmap::tmap_leaflet(m2) %>%
##   addCircleMarkers(lng = origin_lds[1], lat = origin_lds[2]) %>%
##   addCircleMarkers(lng = destination[1], lat = destination[2])

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # bumpf (not used)
## getbb_of_two_points = function(p1, p2) {
##   minx = min(c(p1[1], p2[1]))
##   maxx = max(c(p1[1], p2[1]))
##   miny = min(c(p1[2], p2[2]))
##   maxy = max(c(p1[2], p2[2]))
##   rbind(
##     c(minx, maxx),
##     c(miny, maxy)
##   )
## }
## getbb_of_two_points(origin_lds, destination)
## mat_orig = matrix(origin_lds, ncol = 2)
## origin_sf = st_point(origin_lds) %>%
##   st_sfc() %>%
##   st_sf(crs = 4326)
## destination_sf = st_point(destination) %>%
##   st_sfc() %>%
##   st_sf(crs = 4326)
## mat_dest = sln@sl
## nearest_o = knn_orig <- nabor::knn(mat_via, query = mat_orig, k = 1)$nn.idx
## route_lds = (from = origin_lds, to = destination)

## ---- eval=FALSE---------------------------------------------------------
## source("https://raw.githubusercontent.com/ITSLeeds/highways-course/master/README.R")

