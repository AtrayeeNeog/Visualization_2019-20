library(here)

df <- data.table::fread(here::here("data", "CGCS-GraphData.csv"))
head(df)
tail(df)
nrow(df)
data <- data.frame(df) 
nrow(data)
summary(data)
