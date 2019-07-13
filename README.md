
# mariokart <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

<!-- badges: end -->

## Overview

Mario Kart character and vehicle statistics datasets from different
games of the series.

Currently these entries have been implemented:

  - Mario Kart 8 (`mk8_characters`, `mk8_vehicles`, `mk8_wheels`,
    `mk8_gliders`)

## Installation

<!-- You can install the released version of mariokart from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("mariokart") -->

<!-- ``` -->

<!-- And  -->

The development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aldomann/mariokart")
```

## Example

This is a basic example which shows you how to visually compare
statistics from different characters:

``` r
library(mariokart)
library(ggplot2)
library(dplyr)
```

``` r
data(mk8_characters)

mk8_characters %>% 
  group_by(speed_normal, handling_normal, weight_class) %>% 
  slice(1) %>% 
  ggplot() +
  aes(x = speed_normal, y = handling_normal, color = weight_class, label = character) +
  ggrepel::geom_label_repel(seed = 1, show_guide = FALSE) +
  geom_point() +
  scale_x_continuous(breaks = seq(2, 5, 0.5)) +
  labs(
    title = "Character speed vs handling combinations on Mario Kart 8",
    x = "Normal speed",
    y = "Normal handling",
    color = "Weight class"
  ) 
#> Warning: `show_guide` has been deprecated. Please use `show.legend`
#> instead.
```

<img src="man/figures/README-example-1.png" style="display: block; margin: auto;" />
