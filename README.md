
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Aim

The aim of highways-course is to provide content for a 2 day course on R
and transport data with R.

Course contents can be found online at:
<https://github.com/ITSLeeds/highways-course>

## Course contents (times TBC)

  - Introduction to R
  - How to use RStudio
  - Temporal data
  - Stats refresher
  - Using packages: example with ggplot2

**Lunch**

  - Spatial data in R
  - R’s spatial ecosystem: -See section [1.4 of Geocomputation with R -
    Working with attribute
    data](https://geocompr.robinlovelace.net/intro.html#rs-spatial-ecosystem)
      - [Section 3.2](https://geocompr.robinlovelace.net/attr.html#vector-attribute-manipulation)
        of handouts
  - Demo of roadworks data with R
      - Online tutorial: 2.1 of Geocomputation with R

**Day 2 transport data**

  - Point data: Stats19
  - Data frames and desire lines: using origin-destination data
  - Practical: finding crash hotspots

**Lunch**

  - Traffic data
  - Working on real datasets such as flooding or traffic data, or
    improving specific skills such as visualisation
    <!-- (MIDAS Gold) -->

<!-- ## Optional extras (to discuss) -->

<!-- - Roadworks data (HTDD/Scottish/Leeds data - HE have data?) -->

<!-- - Stats19 -->

<!-- - Routing engines -->

<!-- - Air pollution -->

<!-- - Traffic data (other) -->

<!-- ## To discuss/confirm -->

<!-- - 10 ppl HE + 8 RAC  -->

<!-- - Managed work laptops - install pre-requisites - pre-reqs document. -->

<!-- - Demonstrators (ask Josh - possible fee, ask Maxine should be fine) -->

<!-- - Ivo Helper -->

<!-- - Location: look into it - plus refreshments -->

<!--   - None HE Leeds -->

<!--   - Maybe HE Birmingham -->

<!--   - Maybe RAC -->

<!-- - Timing: mid November or w/c 10th Dec -->

## Prerequisites

Attendees are expected to bring their own laptop with the following
packages installed and working. You can check these are all installed,
and install those that are not installed, as follows (you can also just
type `install.packages("sf")` etc):

``` r
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
#>   osmdata        sf   stplanr tidyverse      tmap 
#>      TRUE      TRUE      TRUE      TRUE      TRUE
if(!all(pkgs_installed)) {
  install.packages(pkgs[!pkgs_installed])
}

# Make sure your packages are up-to-date with:

update.packages(ask = FALSE)
```

In addition, it would be useful to have oneminutetraffic, which can be
installed with:

``` r
devtools::install_github("RACFoundation/oneminutetrafficdata")
```

## Reproducible example

The code in the following example checks you have the necessary packages
installed. It results in a map that will guide you to the location of
the course.

Attach the packages:

``` r
library(sf)
library(stplanr)
library(tidyverse)
```

The overall route assuming you’re travelling from London:

``` r
origin_lnd = geo_code("London Kings Cross")
destination = geo_code("Worsley Building, Leeds")
odmatrix = matrix(c(origin_lnd, destination), ncol = 2, byrow = TRUE)
line_lnd = st_linestring(odmatrix) %>% 
  st_sfc() %>% 
  st_sf(crs = 4326)
m1 = tmap::qtm(line_lnd)
tmap::tmap_leaflet(m1)
```

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Note: you can test all of these things work by running the following
command:

``` r
source("https://raw.githubusercontent.com/ITSLeeds/highways-course/master/README.R")
```

Bonus: find the route from Leeds rail station (see the code in
`README.R` on the course website at
<https://github.com/ITSLeeds/highways-course> )

## References
