library(here)

cat <- data.table::fread(here::here("data", "DemographicCategories.csv"))

cat_list <- cat$NodeID
cat_list
