# test rmd to md

``` r
x <- 5
print(x)
```

    ## [1] 5

``` r
library(data.table)
library(ggplot2)
x <- data.table(a = c(1,2,3))
ggplot(x, 
       aes(x = a)) + geom_density()
```

![](test_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
