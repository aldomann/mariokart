# Libraries ------------------------------------------------
library(dplyr)

# Read raw data --------------------------------------------
mk8_characters <- read.csv("data-raw/mk8_characters.csv", sep = ",")
mk8_karts <- read.csv("data-raw/mk8_karts.csv", sep = ",")
mk8_bikes <- read.csv("data-raw/mk8_bikes.csv", sep = ",")
mk8_atvs <- read.csv("data-raw/mk8_atvs.csv", sep = ",")
mk8_wheels <- read.csv("data-raw/mk8_wheels.csv", sep = ",")
mk8_gliders <- read.csv("data-raw/mk8_gliders.csv", sep = ",")

# Process data ---------------------------------------------
mk8_characters <- mk8_characters %>%
  tidyr::separate_rows(character, sep = ";") %>%
  select(character, everything())

mk8_wheels <- mk8_wheels %>%
  tidyr::separate_rows(wheels, sep = ";")

mk8_gliders <- mk8_gliders %>%
  tidyr::separate_rows(glider, sep = ";")

# Process vehicles
mk8_karts <- mk8_karts %>%
  tidyr::separate_rows(vehicle, sep = ";") %>%
  dplyr::mutate(vehicle_type = "kart")

mk8_bikes <- mk8_bikes %>%
  tidyr::separate_rows(vehicle, sep = ";") %>%
  dplyr::mutate(
    drift_type = stringr::str_detect(vehicle, "★"),
    vehicle = stringr::str_replace_all(vehicle, "★", ""),
    vehicle_type = "bike"
  )

mk8_atvs <- mk8_atvs %>%
  tidyr::separate_rows(vehicle, sep = ";") %>%
  dplyr::mutate(vehicle_type = "atv")

mk8_vehicles <- plyr::rbind.fill(mk8_karts, mk8_bikes, mk8_atvs) %>%
  dplyr::mutate(
    drift_type = ifelse(drift_type == TRUE, "inside", "outside"),
    drift_type = ifelse(is.na(drift_type), "none", drift_type)
  ) %>%
  select(vehicle, vehicle_type, drift_type, dplyr::everything())

# Export data ----------------------------------------------
usethis::use_data(mk8_characters, overwrite = TRUE)
usethis::use_data(mk8_vehicles, overwrite = TRUE)
usethis::use_data(mk8_wheels, overwrite = TRUE)
usethis::use_data(mk8_gliders, overwrite = TRUE)
