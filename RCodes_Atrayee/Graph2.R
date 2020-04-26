library(here)
library(tidyverse)

# Load The Data:
qt2 <- data.table::fread(here::here("data", "Q1-Graph2.csv"))
head(qt2)
tail(qt2)

# Summarising the Data:
summary(qt2)
nrow(qt2) #1300
ncol(qt2) #11

# Differentiating between channels:
qt2_01 <- qt2 %>% filter(qt2$eType == 0 | qt2$eType == 1) # Communication Channel
nrow(qt2_01) # 435
qt2_23 <- qt2 %>% filter(qt2$eType == 2 | qt2$eType == 3) # Procurement Channel
nrow(qt2_23) # 14
qt2_4 <- qt2 %>% filter(qt2$eType == 4) # Co-authorship Channel
nrow(qt2_4) # 4
qt2_5 <- qt2 %>% filter(qt2$eType == 5) # Demographic Channel
nrow(qt2_5) # 823
qt2_6 <- qt2 %>% filter(qt2$eType == 6) # Travel Channel
nrow(qt2_6) # 24
# Highest data for Demographic, Communication and Travel Channel.

# Analysis of the Communication channel:
glimpse(qt2_01)
unique(qt2_01)
unique(qt2_01$eType) # 0 1
unique(qt2_01$SourceLocation) 
unique(qt2_01$TargetLocation) 
unique(qt2_01$SourceLatitude) 
unique(qt2_01$SourceLongitude) 
unique(qt2_01$TargetLatitude) 
unique(qt2_01$TargetLongitude) 
unique(qt2_01$Source) 
unique(qt2_01$Target) 

colnames(qt2_01)

# Analysis of the Demographic channel:
glimpse(qt2_5)
unique(qt2_5)
unique(qt2_5$eType) # 5
unique(qt2_5$SourceLocation) # NA
unique(qt2_5$TargetLocation) # NA
unique(qt2_5$SourceLatitude) # NA
unique(qt2_5$SourceLongitude) # NA
unique(qt2_5$TargetLatitude) # NA
unique(qt2_5$TargetLongitude) # NA
unique(qt2_5$Source)
unique(qt2_5$Target)
unique(qt2_5$Weight)


qt2_5 <- subset(qt2_5, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(qt2_5)
any(qt2_5$Source) == any(qt2_5$Target) # True
range(qt2_5$Source) # 464563-656156
range(qt2_5$Target) # 459381-656156
range(qt2_5$Time) # 31536000-31536000
income_cat_qt2 <- NULL
# Income Categories:
for (i in (qt2_5$Source)) {
  for (j in (cat$NodeID)) {                   # cat_list contains all the demographic nodeIDs (from the DemographicNodeExtraction Script)
    if(i == j){
      income_cat_qt2 <- append(income_cat_qt2,i)
    }
  }
}

print(income_cat_qt2) # income categories extracted
unique(income_cat_qt2) # 3
qt2_5_sub1 <- subset(qt2_5, qt2_5$Source == income_cat_qt2) # Subset of data with only income categories
str(qt2_5_sub1)
plot(qt2_5_sub1$Source, qt2_5_sub1$Weight) # Plot of Monetary income in each category

# Expense Categories:
expense_cat_qt2 <- NULL
for (k in qt2_5$Target) {
  for(l in cat$NodeID){ 
    if(k==l){
      expense_cat_qt2 <- append(expense_cat_qt2, k)
    }
  }
  
}
print(expense_cat_qt2) # expense categories extracted
unique(expense_cat_qt2) # 27
qt2_5_sub2 <- subset(qt2_5, qt2_5$Target == expense_cat_qt2) # Subset of data with only expense categories
str(qt2_5_sub2)
plot(qt2_5_sub2$Target, qt2_5_sub2$Weight) # Plot of Monetary expenses in each category


hist(qt2_5$Weight)
unique(qt2_5$Weight)
range(qt2_5$Weight) #0.17-196567.00
# To-do : normalise the weights to better visualise in graph. Convert to csv maybe.

#any(qt2_6$Target) == any(qt2_6$Source)

# Travel Channel:
glimpse(qt2_6)
unique(qt2_6)
unique(qt2_6$eType) # 6
unique(qt2_6$SourceLocation) # 3 4 2 1 0
unique(qt2_6$TargetLocation) # 1 3 4 2
unique(qt2_6$SourceLatitude) # -25   1 -22 -29  33
unique(qt2_6$SourceLongitude) # -111 -165   91  -13  -41
unique(qt2_6$TargetLatitude) # -29 -25   1 -22
unique(qt2_6$TargetLongitude) # -13 -111 -165   91
unique(qt2_6$Source)
unique(qt2_6$Target)
unique(qt2_6$Weight) #3 7 1 5 2 6 4


range(qt2_6$Source) # 464459 635665
range(qt2_6$Target) # 499467 657173
range(qt2_6$Time) # 22264074 29780874


hist(qt2_6$Weight)
unique(qt2_6$Weight) #3 7 1 5 2 6 4
range(qt2_6$Weight) #1 7

# Procurement Channel:
glimpse(qt2_23)
unique(qt2_23)
unique(qt2_23$eType) # 2 3
unique(qt2_23$SourceLocation) # NA
unique(qt2_23$TargetLocation) # NA
unique(qt2_23$SourceLatitude) # NA
unique(qt2_23$SourceLongitude) # NA
unique(qt2_23$TargetLatitude) # NA
unique(qt2_23$TargetLongitude) # NA
unique(qt2_23$Source) # 550287 512397
unique(qt2_23$Target) # 657187
unique(qt2_23$Weight) 

qt2_23 <- subset(qt2_23, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(qt2_23)
range(qt2_23$Source) 
range(qt2_23$Target) 
range(qt2_23$Time) # 13302589 20170502

hist(qt2_23$Weight)
unique(qt2_23$Weight) 
range(qt2_23$Weight) #1 5

