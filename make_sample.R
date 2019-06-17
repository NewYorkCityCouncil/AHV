library(tidyverse)
library(vroom)
library(janitor)

set.seed(20190614)

buildings <- vroom("building.csv", col_types = cols(BIN = col_character())) %>%
  clean_names()
lots <- vroom("nyc_pluto_18v2_1_csv/pluto_18v2_1.csv")

glimpse(buildings)
glimpse(lots)

bins <- buildings %>%
  left_join(lots %>% select(council, bbl), by = c("mpluto_bbl" = "bbl")) %>%
  drop_na(council) %>%
  group_by(council) %>%
  sample_n(100) %>%
  ungroup()

bins %>%
  select(bin) %>%
  write_csv("bin_sample.csv")
