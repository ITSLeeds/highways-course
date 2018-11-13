
<!-- Note: edit the .Rmd file not the .md file -->

## 1.1

### 1.1a

1.  Get into groups of 2 and, in those groups:
2.  Create a new RStudio project
3.  Create a new blank R script
4.  Identify and interact with each of the 4 panels in RStudio
5.  Get help on the plot function with `?plot`
6.  Create a plot using the `plot()` function
7.  Find and install a new package on a topic of your choice with `Tools
    > Install Packages` (requires internet)
8.  Attach the package using `library()`
9.  Find and install a new package with `install.packages()`
10. In your source panel write code that creates vector objects `x` and
    `y` and plots them with `plot(x, y)` to create something that looks
    like this:
<!-- (is it reproducible?) -->

<!-- end list -->

``` r
# hint: create a vector object of the numbers 1, 2, 3 and 6 and call it x:
x = c(1, 2, 3, 6)
```

![](exercises_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

  - Bonus: find out exactly what R version you are using (tip: use a
    search engine\!)

  - Bonus: use R to find out how many minutes you’ve been alive for.
    Feel free to use an invented age. Tip: try using both ‘base’
    `as.POSIXct()` and ‘tidyverse’ `ymd_hm()` functions - you may also
    need to search online for this.

### 1.1b

1.  What class is each of these objects:
    
    ``` r
    x = 1:6
    y = sqrt(x)
    z = y + 0.1
    z[3] = "hello"
    ```

2.  Create a data frame that contains variables `x`, `y` and `z` and
    write it out as a `.csv` file.
    
      - Bonus create a matrix composed of `x`, `y` and `z` variables.
        What type does it have?

3.  Download and read-in the `ac_wy.csv` dataset using `read_csv()`.
    Hint, the following command may help get
    it:
    
    ``` r
    f = "https://github.com/ITSLeeds/highways-course/releases/download/0.2/ac_wy.csv"
    download.file(url = f, destfile = "ac_wy.csv")
    ```

4.  How many rows are in the `ac_wy` data frame?

5.  How many lists are in the `ac_wy` data frame?

## 2

1.  Use `sessionInfo()` to find out what which packages are currently
    attached in your R session.

<!-- end list -->

  - How many are there?
  - Run the command `devtools::session_info()`. What’s different about
    the result?

<!-- end list -->

1.  Attach the tidyverse package. What does each of the messages
        mean?:
    
        ## ── Attaching packages ──────────────────────────────────── tidyverse 1.2.1 ──
    
        ## ✔ ggplot2 3.1.0     ✔ purrr   0.2.5
        ## ✔ tibble  1.4.2     ✔ dplyr   0.7.8
        ## ✔ tidyr   0.8.2     ✔ stringr 1.3.1
        ## ✔ readr   1.1.1     ✔ forcats 0.3.0
    
        ## ── Conflicts ─────────────────────────────────────── tidyverse_conflicts() ──
        ## ✖ dplyr::filter() masks stats::filter()
        ## ✖ dplyr::lag()    masks stats::lag()

2.  How many packages are now attached?

3.  Restart your R session and load some **tidyverse** packages
    individually. Start with **readr**, **dplyr** and **ggplot2** and
    add more if you need them.

4.  Create a barplot showing the number and proportion of crashes in the
    `ac_wy` dataset on different types of roads using **ggplot2**:

<!-- end list -->

  - Roads with different speed limits (absolute counts and proportions)
  - Different road types (A roads, B roads etc)
    ![](exercises_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->
