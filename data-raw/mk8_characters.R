## code to prepare `mk8_characters` dataset goes here

mk8_characters <- read.csv("data-raw/mk8_characters.csv")

usethis::use_data(mk8_characters, overwrite = TRUE)

