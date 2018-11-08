
MIDAS data was downloaded with the [oneminutetrafficdata](https://github.com/RACFoundation/oneminutetrafficdata) package. Code to access the data can be found at [github.com/jmanning1/Traffic\_Code](https://github.com/jmanning1/Traffic_Code) (script file [004](https://github.com/jmanning1/Traffic_Code/blob/master/Code/004_Download_MIDAS_Gold_Traffic_Data_2016.R) downloads the data, `R.utils::bunzip2()` can unzip them). A sample of open MIDAS data (and many other datasets can be found [here](https://odileeds.org/blog/2016-10-07-highwayshack-datasets).

We will use the **tidyverse** package to analyse the data:

``` r
library(tidyverse)
```

Some cleaning was done (clean names were created with the **snakecase** package) but the fundamentals of the following code should work with many MIDAS-derived datasets:

``` r
library(tidyverse)
midas_all = read_csv("2017-12-01--2017-12-07.csv")
```

This is not a particularly large dataset by today's dataset. Even so, it makes sense to take a small sample of it for testing purposes. We can do this, and save the result, as follows:

``` r
set.seed(1000)
midas_sample = midas_all %>% 
  sample_n(1000)
write_csv(midas_sample, "midas_sample.csv")
```

We will work with this smaller dataset before moving on to analyse patterns in the larger dataset. All of the commands executed here on `midas_sample` will work equally well on `midas_all`, just lots faster:

``` r
midas_sample = read_csv("midas_sample.csv")
names(midas_sample)
```

    ##  [1] "control_office"                  "geographic_address"             
    ##  [3] "year"                            "month"                          
    ##  [5] "day"                             "day_of_week"                    
    ##  [7] "type_of_day"                     "days_after_nearest_bank_holiday"
    ##  [9] "time_gmt"                        "number_of_lanes"                
    ## [11] "flow_category_1"                 "flow_category_2"                
    ## [13] "flow_category_3"                 "flow_category_4"                
    ## [15] "average_speed_lane_1"            "total_flow_lane_1"              
    ## [17] "occupancy_lane_1"                "average_headway_lane_1"         
    ## [19] "average_speed_lane_2"            "total_flow_lane_2"              
    ## [21] "occupancy_lane_2"                "average_headway_lane_2"         
    ## [23] "average_speed_lane_3"            "total_flow_lane_3"              
    ## [25] "occupancy_lane_3"                "average_headway_lane_3"

This shows we have 26 variables, all of which have relatively clear names. We can do summary statistics on these. What's the average speed in each lane of traffic, for example?:

``` r
mean(midas_sample$average_speed_lane_1)
```

    ## [1] 90

We can investigate the distribution of speeds visually by plotting the data:

``` r
ggplot(midas_sample) +
  geom_violin(aes(x = geographic_address, y = average_speed_lane_1))
```

![](midas-data_files/figure-markdown_github/unnamed-chunk-6-1.png)
