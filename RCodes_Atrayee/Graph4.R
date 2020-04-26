library(here)
library(tidyverse)

# Load The Data:
qt4 <- data.table::fread(here::here("data", "Q1-Graph4.csv"))
head(qt4)
tail(qt4)

# Summarising the Data:
summary(qt4)
nrow(qt4) #732
ncol(qt4) #11

# Differentiating between channels:
qt4_01 <- qt4 %>% filter(qt4$eType == 0 | qt4$eType == 1) # Communication Channel
nrow(qt4_01) # 106
qt4_23 <- qt4 %>% filter(qt4$eType == 2 | qt4$eType == 3) # Procurement Channel
nrow(qt4_23) # 17
qt4_4 <- qt4 %>% filter(qt4$eType == 4) # Co-authorship Channel
nrow(qt4_4) # 0
qt4_5 <- qt4 %>% filter(qt4$eType == 5) # Demographic Channel
nrow(qt4_5) # 494
qt4_6 <- qt4 %>% filter(qt4$eType == 6) # Travel Channel
nrow(qt4_6) # 115
# Highest data for Demographic, Communication and Travel Channel.

# To check if any Source ID is equal to any Target ID:
for(i in qt4_6$Source){
  for(j in qt4_6$Target){
    if(i == j){
      print("Match Found")
    }
    else{
      print("No matches found")
    }
  }
}

# Analysis of the Communication channel:
glimpse(qt4_01)
unique(qt4_01)
unique(qt4_01$eType) # 0 1
unique(qt4_01$SourceLocation) # 4  0 NA  5  1  3
unique(qt4_01$TargetLocation) # 4  3 NA  5  2  1  0
unique(qt4_01$SourceLatitude) 
unique(qt4_01$SourceLongitude)
unique(qt4_01$TargetLatitude) 
unique(qt4_01$TargetLongitude) 
unique(qt4_01$Source) 
unique(qt4_01$Target) 

colnames(qt4_01)

# Analysis of the Demographic channel:
glimpse(qt4_5)
unique(qt4_5)
unique(qt4_5$eType) # 5
unique(qt4_5$SourceLocation) # NA
unique(qt4_5$TargetLocation) # NA
unique(qt4_5$SourceLatitude) # NA
unique(qt4_5$SourceLongitude) # NA
unique(qt4_5$TargetLatitude) # NA
unique(qt4_5$TargetLongitude) # NA
unique(qt4_5$Source)
unique(qt4_5$Target)
unique(qt4_5$Weight)


qt4_5 <- subset(qt4_5, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(qt4_5)


range(qt4_5$Source) # 466976 657076
range(qt4_5$Target) # 459381 657076
range(qt4_5$Time) # 31536000-31536000
income_cat_qt4 <- NULL
# Income Categories:
for (i in (qt4_5$Source)) {
  for (j in (cat$NodeID)) {                   # cat_list contains all the demographic nodeIDs (from the DemographicNodeExtraction Script)
    if(i == j){
      income_cat_qt4 <- append(income_cat_qt4,i)
    }
  }
}

print(income_cat_qt4) # income categories extracted
unique(income_cat_qt4) # 3
qt4_5_sub1 <- subset(qt4_5, qt4_5$Source == income_cat_qt4) # Subset of data with only income categories
str(qt4_5_sub1)
plot(qt4_5_sub1$Source, qt4_5_sub1$Weight) # Plot of Monetary income in each category

# Expense Categories:
expense_cat_qt4 <- NULL
for (k in qt4_5$Target) {
  for(l in cat$NodeID){ 
    if(k==l){
      expense_cat_qt4 <- append(expense_cat_qt4, k)
    }
  }
  
}
print(expense_cat_qt4) # expense categories extracted
unique(expense_cat_qt4) # 27
qt4_5_sub2 <- subset(qt4_5, qt4_5$Target == expense_cat_qt4) # Subset of data with only expense categories
str(qt4_5_sub2)
plot(qt4_5_sub2$Target, qt4_5_sub2$Weight) # Plot of Monetary expenses in each category


hist(qt4_5$Weight)
unique(qt4_5$Weight)
range(qt4_5$Weight) #2.39 141744.00
# To-do : normalise the weights to better visualise in graph. Convert to csv maybe.


