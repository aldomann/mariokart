# Libraries ------------------------------------------------
library(dplyr)

# Read raw data --------------------------------------------
smk_characters <- read.csv("data-raw/smk_characters.csv", sep = ",")
smk_speeds <- read.csv("data-raw/smk_speeds.csv", sep = ",")
smk_acceleration <- read.csv("data-raw/smk_acceleration.csv", sep = ",")

# Process data ---------------------------------------------
smk_characters <- smk_characters %>%
  tidyr::separate_rows(character, sep = ";")

smk_speeds <- smk_speeds %>%
  tidyr::separate_rows(character, sep = ";")

smk_acceleration <- smk_acceleration %>%
  tidyr::separate_rows(character, sep = ";")

# Export data ----------------------------------------------
usethis::use_data(smk_characters, overwrite = TRUE)
usethis::use_data(smk_speeds, overwrite = TRUE)
usethis::use_data(smk_acceleration, overwrite = TRUE)
