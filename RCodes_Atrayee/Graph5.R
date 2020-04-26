library(here)
library(tidyverse)

# Load The Data:
qt5 <- data.table::fread(here::here("data", "Q1-Graph5.csv"))
head(qt5)
tail(qt5)

# Summarising the Data:
summary(qt5)
nrow(qt5) #395
ncol(qt5) #11

# Differentiating between channels:
qt5_01 <- qt5 %>% filter(qt5$eType == 0 | qt5$eType == 1) # Communication Channel
nrow(qt5_01) # 31
qt5_23 <- qt5 %>% filter(qt5$eType == 2 | qt5$eType == 3) # Procurement Channel
nrow(qt5_23) # 51
qt5_4 <- qt5 %>% filter(qt5$eType == 4) # Co-authorship Channel
nrow(qt5_4) # 0
qt5_5 <- qt5 %>% filter(qt5$eType == 5) # Demographic Channel
nrow(qt5_5) # 203
qt5_6 <- qt5 %>% filter(qt5$eType == 6) # Travel Channel
nrow(qt5_6) # 110
# Highest data for Demographic, Travel Channel and Procurement.

# To check if any Source ID is equal to any Target ID:
for(i in qt5_6$Source){
  for(j in qt5_6$Target){
    if(i == j){
      print("Match Found")
    }
    else{
      print("No matches found")
    }
  }
}

# Analysis of the Communication channel:
glimpse(qt5_01)
unique(qt5_01)
unique(qt5_01$eType) # 0 1
unique(qt5_01$SourceLocation) # NA  2  0  4  3
unique(qt5_01$TargetLocation) # NA  4  3  1  5
unique(qt5_01$SourceLatitude) 
unique(qt5_01$SourceLongitude)
unique(qt5_01$TargetLatitude) 
unique(qt5_01$TargetLongitude) 
unique(qt5_01$Source) 
unique(qt5_01$Target) 

colnames(qt5_01)

# Analysis of the Demographic channel:
glimpse(qt5_5)
unique(qt5_5)
unique(qt5_5$eType) # 5
unique(qt5_5$SourceLocation) # NA
unique(qt5_5$TargetLocation) # NA
unique(qt5_5$SourceLatitude) # NA
unique(qt5_5$SourceLongitude) # NA
unique(qt5_5$TargetLatitude) # NA
unique(qt5_5$TargetLongitude) # NA
unique(qt5_5$Source)
unique(qt5_5$Target)
unique(qt5_5$Weight)


qt5_5 <- subset(qt5_5, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(qt5_5)


range(qt5_5$Source) # 466976 657076
range(qt5_5$Target) # 459381 657076
range(qt5_5$Time) # 31536000-31536000
income_cat_qt5 <- NULL
# Income Categories:
for (i in (qt5_5$Source)) {
  for (j in (cat$NodeID)) {                   # cat_list contains all the demographic nodeIDs (from the DemographicNodeExtraction Script)
    if(i == j){
      income_cat_qt5 <- append(income_cat_qt5,i)
    }
  }
}

print(income_cat_qt5) # income categories extracted
unique(income_cat_qt5) # 3
qt5_5_sub1 <- subset(qt5_5, qt5_5$Source == income_cat_qt5) # Subset of data with only income categories
str(qt5_5_sub1)
plot(qt5_5_sub1$Source, qt5_5_sub1$Weight) # Plot of Monetary income in each category

# Expense Categories:
expense_cat_qt5 <- NULL
for (k in qt5_5$Target) {
  for(l in cat$NodeID){ 
    if(k==l){
      expense_cat_qt5 <- append(expense_cat_qt5, k)
    }
  }
  
}
print(expense_cat_qt5) # expense categories extracted
unique(expense_cat_qt5) # 27
qt5_5_sub2 <- subset(qt5_5, qt5_5$Target == expense_cat_qt5) # Subset of data with only expense categories
str(qt5_5_sub2)
plot(qt5_5_sub2$Target, qt5_5_sub2$Weight) # Plot of Monetary expenses in each category


hist(qt5_5$Weight)
unique(qt5_5$Weight)
range(qt5_5$Weight) #0.17 441206.00
# To-do : normalise the weights to better visualise in graph. Convert to csv maybe.

# Travel Channel:
glimpse(qt5_6)
unique(qt5_6)
unique(qt5_6$eType) # 6
unique(qt5_6$SourceLocation) 
unique(qt5_6$TargetLocation) 
unique(qt5_6$SourceLatitude) 
unique(qt5_6$SourceLongitude) 
unique(qt5_6$TargetLatitude) 
unique(qt5_6$TargetLongitude) 
unique(qt5_6$Source)
unique(qt5_6$Target)
unique(qt5_6$Weight) 


range(qt5_6$Source) 
range(qt5_6$Target) 
range(qt5_6$Time) # 1987200 28684800

hist(qt5_6$Weight)
unique(qt5_6$Weight) 
range(qt5_6$Weight) # -1  8




