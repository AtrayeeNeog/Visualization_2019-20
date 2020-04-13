library(here)
library(tidyverse)

# Loading the data:
df <- data.table::fread(here::here("data", "CGCS-GraphData.csv"))
head(df)
tail(df)
nrow(df)
ncol(df)
data <- data.frame(df) 
nrow(data)
#summary(data)
str(data)

# Copying into new dataframe for changes:
dt <- data.frame(data)

# Number of Communication Channels:
unique(dt$eType)
sum(which(dt$eType == 0))
sum(which(dt$eType == 1))
sum(which(dt$eType == 2))
sum(which(dt$eType == 3))
sum(which(dt$eType == 4))
sum(which(dt$eType == 5))
sum(which(dt$eType == 6))

dt0 <- dt %>% filter(dt$eType==0)
nrow(dt0)
dt1 <- dt %>% filter(dt$eType==1)
dt2 <- dt %>% filter(dt$eType==2)
dt3 <- dt %>% filter(dt$eType==3)
dt4 <- dt %>% filter(dt$eType==4)
dt5 <- dt %>% filter(dt$eType==5)
dt6 <- dt %>% filter(dt$eType==6)

