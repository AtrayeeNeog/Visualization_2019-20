library(here)
library(tidyverse)

# Load The Data:
qt3 <- data.table::fread(here::here("data", "Q1-Graph3.csv"))
head(qt3)
tail(qt3)

# Summarising the Data:
summary(qt3)
nrow(qt3) #729
ncol(qt3) #11

# Differentiating between channels:
qt3_01 <- qt3 %>% filter(qt3$eType == 0 | qt3$eType == 1) # Communication Channel
nrow(qt3_01) # 160
qt3_23 <- qt3 %>% filter(qt3$eType == 2 | qt3$eType == 3) # Procurement Channel
nrow(qt3_23) # 12
qt3_4 <- qt3 %>% filter(qt3$eType == 4) # Co-authorship Channel
nrow(qt3_4) # 1
qt3_5 <- qt3 %>% filter(qt3$eType == 5) # Demographic Channel
nrow(qt3_5) # 519
qt3_6 <- qt3 %>% filter(qt3$eType == 6) # Travel Channel
nrow(qt3_6) # 37
# Highest data for Demographic, Communication and Travel Channel.

# To check if any Source ID is equal to any Target ID:
for(i in qt3_6$Source){
  for(j in qt3_6$Target){
    if(i == j){
      print("Match Found")
    }
    else{
      print("No matches found")
    }
  }
}

# Analysis of the Communication channel:
glimpse(qt3_01)
unique(qt3_01)
unique(qt3_01$eType) # 0 1
unique(qt3_01$SourceLocation) # 1  2 NA  4  5  0
unique(qt3_01$TargetLocation) # 2 NA  1  0  4  5
unique(qt3_01$SourceLatitude) # -27.78420 -23.59530 NA -29.17140   5.91178  24.98310  32.11920   2.35166
unique(qt3_01$SourceLongitude)# -8.74823 91.35710 NA -10.49300 -161.27600  155.44600  -47.35310 -161.32200 
unique(qt3_01$TargetLatitude) # -21.89600 -21.14110        NA -29.17140 -27.78420 -23.59530  33.57410   2.35166  32.11920  24.98310 5.91178
unique(qt3_01$TargetLongitude) #  89.40000   91.14270         NA  -10.49300   -8.74823   91.35710  -40.39040 -161.32200  -47.35310 155.44600 -161.27600
unique(qt3_01$Source) 
unique(qt3_01$Target) 

colnames(qt3_01)

# Analysis of the Demographic channel:
glimpse(qt3_5)
unique(qt3_5)
unique(qt3_5$eType) # 5
unique(qt3_5$SourceLocation) # NA
unique(qt3_5$TargetLocation) # NA
unique(qt3_5$SourceLatitude) # NA
unique(qt3_5$SourceLongitude) # NA
unique(qt3_5$TargetLatitude) # NA
unique(qt3_5$TargetLongitude) # NA
unique(qt3_5$Source)
unique(qt3_5$Target)
unique(qt3_5$Weight)


qt3_5 <- subset(qt3_5, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(qt3_5)


range(qt3_5$Source) # 466976 657076
range(qt3_5$Target) # 459381 657076
range(qt3_5$Time) # 31536000-31536000
income_cat_qt3 <- NULL
# Income Categories:
for (i in (qt3_5$Source)) {
  for (j in (cat$NodeID)) {                   # cat_list contains all the demographic nodeIDs (from the DemographicNodeExtraction Script)
    if(i == j){
      income_cat_qt3 <- append(income_cat_qt3,i)
    }
  }
}

print(income_cat_qt3) # income categories extracted
unique(income_cat_qt3) # 3
qt3_5_sub1 <- subset(qt3_5, qt3_5$Source == income_cat_qt3) # Subset of data with only income categories
str(qt3_5_sub1)
plot(qt3_5_sub1$Source, qt3_5_sub1$Weight) # Plot of Monetary income in each category

# Expense Categories:
expense_cat_qt3 <- NULL
for (k in qt3_5$Target) {
  for(l in cat$NodeID){ 
    if(k==l){
      expense_cat_qt3 <- append(expense_cat_qt3, k)
    }
  }
  
}
print(expense_cat_qt3) # expense categories extracted
unique(expense_cat_qt3) # 27
qt3_5_sub2 <- subset(qt3_5, qt3_5$Target == expense_cat_qt3) # Subset of data with only expense categories
str(qt3_5_sub2)
plot(qt3_5_sub2$Target, qt3_5_sub2$Weight) # Plot of Monetary expenses in each category


hist(qt3_5$Weight)
unique(qt3_5$Weight)
range(qt3_5$Weight) #1.53 159997.00
# To-do : normalise the weights to better visualise in graph. Convert to csv maybe.


