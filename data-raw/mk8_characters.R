## code to prepare `mk8_characters` dataset goes here
library(dplyr)

mk8_characters <- read.csv("data-raw/mk8_characters.csv", sep = ",")

mk8_characters <- mk8_characters %>%
  dplyr::mutate(Character = stringr::str_trim(Character)) %>%
  tidyr::separate_rows(Character, sep = ";")

usethis::use_data(mk8_characters, overwrite = TRUE)
