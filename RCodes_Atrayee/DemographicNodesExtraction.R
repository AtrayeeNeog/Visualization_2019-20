library(here)

cat <- data.table::fread(here::here("data", "DemographicCategories.csv"))

cat_list <- list(cat$NodeID)
cat_list
