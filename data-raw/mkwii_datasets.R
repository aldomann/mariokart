# Libraries ------------------------------------------------
library(dplyr)

# Read raw data --------------------------------------------
mkwii_characters <- read.csv("data-raw/mkwii_characters.csv", sep = ",")
mkwii_karts <- read.csv("data-raw/mkwii_karts.csv", sep = ",")
mkwii_bikes <- read.csv("data-raw/mkwii_bikes.csv", sep = ",")

# Process data ---------------------------------------------
mkwii_characters <- mkwii_characters %>%
  tidyr::separate_rows(character, sep = ";")

# Process vehicles
mkwii_karts <- mkwii_karts %>%
  dplyr::mutate(vehicle_type = "kart")

mkwii_bikes <- mkwii_bikes %>%
  dplyr::mutate(
    drift_type = stringr::str_detect(vehicle, "★"),
    vehicle = stringr::str_replace_all(vehicle, "★", ""),
    vehicle_type = "bike"
  )

mkwii_vehicles <- plyr::rbind.fill(mkwii_karts, mkwii_bikes) %>%
  dplyr::mutate(
    drift_type = ifelse(drift_type == TRUE, "inside", "outside"),
    drift_type = ifelse(is.na(drift_type), "none", drift_type)
  ) %>%
  select(vehicle, vehicle_type, vehicle_class, drift_type, dplyr::everything())

# Export data ----------------------------------------------
usethis::use_data(mkwii_characters, overwrite = TRUE)
usethis::use_data(mkwii_vehicles, overwrite = TRUE)
