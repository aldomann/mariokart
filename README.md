
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

## Examples

This is an example which shows how to visually compare statistics from
different Mario Kart 8 characters:

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
  ggrepel::geom_label_repel(seed = 1, show.legend = FALSE) +
  geom_point() +
  scale_x_continuous(breaks = seq(2, 5, 0.5)) +
  labs(
    title = "Character speed vs handling combinations in Mario Kart 8",
    x = "Normal speed",
    y = "Normal handling",
    color = "Weight class"
  ) 
```

<img src="man/figures/README-example-mk8-1.png" style="display: block; margin: auto;" />

This is an example which shows how to visually compare Mario Kart Wii
karts statistics grouped by drifting type:

``` r
data(mkwii_vehicles)

mkwii_vehicles %>% 
  filter(vehicle_type == "bike") %>% 
  mutate(total_stats = rowSums(select_if(., is.numeric))) %>% 
  select(starts_with("vehicle"), drift_type, weight_class, total_stats) %>% 
  arrange(vehicle_class) %>% 
  ggplot() +
  aes(x = reorder(vehicle, total_stats), y = total_stats, fill = vehicle_class) +
  geom_col() +
  labs(
    title = "Bikes in Mario Kart Wii by total statistics",
    x = "Kart name",
    y = "Total statistics",
    fill = "Vehicle class"
  ) +
  facet_grid(drift_type ~ ., scales = "free_y", space = "free_y") +
  coord_flip()
```

<img src="man/figures/README-example-mkwii-1.png" style="display: block; margin: auto;" />
