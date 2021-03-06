library(here)
library(tidyverse)

# Load The Data:
qt1 <- data.table::fread(here::here("data", "Q1-Graph1.csv"))
head(qt1)
tail(qt1)

# Summarising the Data:
summary(qt1)
nrow(qt1) #1216
ncol(qt1) #11

# Differentiating between channels:
qt1_01 <- qt1 %>% filter(qt1$eType == 0 | qt1$eType == 1) # Communication Channel
nrow(qt1_01) # 318
qt1_23 <- qt1 %>% filter(qt1$eType == 2 | qt1$eType == 3) # Procurement Channel
nrow(qt1_23) # 14
qt1_4 <- qt1 %>% filter(qt1$eType == 4) # Co-authorship Channel
nrow(qt1_4) # 1
qt1_5 <- qt1 %>% filter(qt1$eType == 5) # Demographic Channel
nrow(qt1_5) # 846
qt1_6 <- qt1 %>% filter(qt1$eType == 6) # Travel Channel
nrow(qt1_6) # 37
# Highest data for Demographic, Communication and Travel Channel.

# To check if any Source ID is equal to any Target ID:
for(i in qt1_6$Source){
  for(j in qt1_6$Target){
    if(i == j){
      print("Match Found")
    }
    else{
      print("No matches found")
    }
  }
}

# Analysis of the Communication channel:
glimpse(qt1_01)
unique(qt1_01)
unique(qt1_01$eType) # 0 1
unique(qt1_01$SourceLocation) # NA 0 2 3
unique(qt1_01$TargetLocation) # NA 0 2 3
unique(qt1_01$SourceLatitude) # NA  34.5741  34.2958 -27.2563  29.3296 -20.9062 -21.8004  25.0754 -25.4639 -24.5657 -18.3758  30.4483  35.8806
unique(qt1_01$SourceLongitude) # NA  -42.0541  -39.0260   91.7676  -37.8076   92.3982   89.7045  -40.6293 -111.2490 -110.6500   91.0250  -42.5341  -34.5372
unique(qt1_01$TargetLatitude) # NA  30.4483  29.3296  34.2958  34.5741  28.3004 -27.2563 -22.6503 -21.8004 -20.9062  25.0754 -24.5657 -20.8686 -18.3758
                                  # 32.6654 -25.4639 -17.1099  35.8806
unique(qt1_01$TargetLongitude) # NA  -42.5341  -37.8076  -39.0260  -42.0541  -47.4036   91.7676   92.6106   89.7045   92.3982  -40.6293 -110.6500   89.4217
                                        #91.0250  -48.6701 -111.2490   90.7971  -34.5372
unique(qt1_01$Source) # 599956 490041 533140 568093 632150 635665 616050 512397 623295 589639 550287 550361 596193
                          # 464459 492777 570411 640464
unique(qt1_01$Target) # 635665 490041 599956 589639 591682 616050 568093 632150 464459 533140 512397 550287 559657
                            # 492777 570411 493044 596193 550361 640464 623295

colnames(qt1_01)

# Analysis of the Demographic channel:
glimpse(qt1_5)
unique(qt1_5)
unique(qt1_5$eType) # 5
unique(qt1_5$SourceLocation) # NA
unique(qt1_5$TargetLocation) # NA
unique(qt1_5$SourceLatitude) # NA
unique(qt1_5$SourceLongitude) # NA
unique(qt1_5$TargetLatitude) # NA
unique(qt1_5$TargetLongitude) # NA
unique(qt1_5$Source)
unique(qt1_5$Target)
unique(qt1_5$Weight)


qt1_5 <- subset(qt1_5, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(qt1_5)


range(qt1_5$Source) # 463777-654981
range(qt1_5$Target) # 459381-654981
range(qt1_5$Time) # 31536000-31536000
income_cat_qt1 <- NULL
# Income Categories:
for (i in (qt1_5$Source)) {
  for (j in (cat$NodeID)) {                   # cat_list contains all the demographic nodeIDs (from the DemographicNodeExtraction Script)
    if(i == j){
      income_cat_qt1 <- append(income_cat_qt1,i)
    }
  }
}

print(income_cat_qt1) # income categories extracted
unique(income_cat_qt1) # 3
qt1_5_sub1 <- subset(qt1_5, qt1_5$Source == income_cat_qt1) # Subset of data with only income categories
str(qt1_5_sub1)
plot(qt1_5_sub1$Source, qt1_5_sub1$Weight) # Plot of Monetary income in each category

# Expense Categories:
expense_cat_qt1 <- 0
for (k in qt1_5$Target) {
  for(l in cat$NodeID){ 
    if(k==l){
      expense_cat_qt1 <- append(expense_cat_qt1, k)
    }
  }

}
print(expense_cat_qt1) # expense categories extracted
unique(expense_cat_qt1) # 27
qt1_5_sub2 <- subset(qt1_5, qt1_5$Target == expense_cat_qt1) # Subset of data with only expense categories
str(qt1_5_sub2)
plot(qt1_5_sub2$Target, qt1_5_sub2$Weight) # Plot of Monetary expenses in each category


hist(qt1_5$Weight)
unique(qt1_5$Weight)
range(qt1_5$Weight) #0.46-900735.00
# To-do : normalise the weights to better visualise in graph. Convert to csv maybe.

# Travel Channel:

glimpse(qt1_6)
unique(qt1_6)
unique(qt1_6$eType) # 6
unique(qt1_6$SourceLocation) # 4 3 2 1 0 5
unique(qt1_6$TargetLocation) # 3 1 4 2 0 5
unique(qt1_6$SourceLatitude) # 1 -25 -22 -29  33  22
unique(qt1_6$SourceLongitude) # -165 -111   91  -13  -41  156
unique(qt1_6$TargetLatitude) # -25 -29   1 -22  33  22
unique(qt1_6$TargetLongitude) # -111  -13 -165   91  -41  156
unique(qt1_6$Source)
unique(qt1_6$Target)
unique(qt1_6$Weight) #4 2 5 3 1


range(qt1_6$Source) # 464459 649553
range(qt1_6$Target) # 499467 657173
range(qt1_6$Time) # 14845147 30224347
income_cat_qt1 <- NULL


hist(qt1_6$Weight)
unique(qt1_6$Weight) #4 2 5 3 1
range(qt1_6$Weight) #1 5

# Procurement Channel:
glimpse(qt1_23)
unique(qt1_23)
unique(qt1_23$eType) # 2 3
unique(qt1_23$SourceLocation) # NA
unique(qt1_23$TargetLocation) # NA
unique(qt1_23$SourceLatitude) # NA
unique(qt1_23$SourceLongitude) # NA
unique(qt1_23$TargetLatitude) # NA
unique(qt1_23$TargetLongitude) # NA
unique(qt1_23$Source) # 550287 512397
unique(qt1_23$Target) # 657187
unique(qt1_23$Weight) 

qt1_23 <- subset(qt1_23, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(qt1_23)
range(qt1_23$Source) 
range(qt1_23$Target) 
range(qt1_23$Time) # 10250285 17671007

hist(qt1_23$Weight)
unique(qt1_23$Weight) 
range(qt1_23$Weight) #1 5

