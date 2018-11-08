
<!-- Note: edit the .Rmd file not the .md file -->

## 1.1

## 1.1a

1.  In groups of 2:
2.  Create a new RStudio project
3.  Create an R script
4.  Identify and interact with each of the 4 panels in RStudio
5.  Get help on the plot function with `?plot`
6.  Create a plot using the `plot()` function
7.  Find and install a new package on a topic of your choice with `Tools
    > Install Packages` (requires internet)
8.  Attach the package using `library()`
9.  Find and install a new package with `install.packages()`
10. In your source panel write code that creates vector objects `x` and
    `y` and plots them with `plot(x, y)` to create something that looks
    like this: <!-- (is it reproducible?) -->

<!-- end list -->

``` r
# hint: create an object called x with the following code:
x = c(1, 2, 3, 6)
```

![](exercises_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

  - Bonus: find out exactly what R version you are using (tip: use a
    search engine\!)

  - Bonus: use R to find out how many minutes you’ve been alive for.
    Feel free to use an invented age. Tip: try using both ‘base’
    `as.POSIXct()` and ‘tidyverse’ `ymd_hm()` functions - you may also
    need to search online for this.

## 1.1b

1.  What class is each of these objects:
    
    ``` r
    x = 1:6
    ```

2.  How many are in the `ac_wy` data frame?
