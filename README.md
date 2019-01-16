tidymirt
========

[![Build Status](https://travis-ci.org/datacamp/tidymirt.svg?branch=master)](https://travis-ci.org/datacamp/tidymirt)


This package provides broom methods (currently tidy, and glance) for getting convenient information for mirt models.

Example
-------

Below, we use the first example given in the `mirt` function, to show off the tidymirt's `tidy` and `glance` methods.

```R
library(mirt)
data <- expand.table(LSAT7)

mod1 <- mirt(data, 1, SE = TRUE)
```

### Tidy

```R
library(tidymirt)
tidy(mod1)
```

```
> tidy(mod1)
# A tibble: 22 x 6
   item_number item   term  estimate conf.low conf.high
         <int> <chr>  <chr>    <dbl>    <dbl>     <dbl>
 1           1 Item.1 a1       0.988    0.641     1.34 
 2           1 Item.1 d        1.86     1.60      2.11 
 3           1 Item.1 g        0       NA        NA    
 4           1 Item.1 u        1       NA        NA    
 5           2 Item.2 a1       1.08     0.750     1.41 
 6           2 Item.2 d        0.808    0.629     0.987
 7           2 Item.2 g        0       NA        NA    
 8           2 Item.2 u        1       NA        NA    
 9           3 Item.3 a1       1.71     1.08      2.33 
10           3 Item.3 d        1.80     1.40      2.20 
# … with 12 more rows
```

### Glance

```R
library(tidymirt)
glance(mod1)
```

```
> glance(mod1)
# A tibble: 1 x 12
  nfact nitems ngroups  nest    df converged   AIC  AICc SABIC    HQ   BIC logLik
  <int>  <int>   <int> <int> <dbl> <lgl>     <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl>
1     1      5       1    10    21 TRUE      5338. 5338. 5355. 5356. 5387. -2659.
```
