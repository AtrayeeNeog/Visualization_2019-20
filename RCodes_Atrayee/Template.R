library(here)
library(tidyverse)
library(plyr)

# Load The Data:
dt <- data.table::fread(here::here("data", "CGCS-Template.csv"))
head(dt)
tail(dt)

# Summarising the Data:
summary(dt)
nrow(dt)
ncol(dt)

# Differentiating between channels:
dt01 <- dt %>% filter(dt$eType == 0 | dt$eType == 1) # Communication Channel
nrow(dt01) # 563
dt23 <- dt %>% filter(dt$eType == 2 | dt$eType == 3) # Procurement Channel
nrow(dt23) # 18
dt4 <- dt %>% filter(dt$eType == 4) # Co-authorship Channel
nrow(dt4) # 1
dt5 <- dt %>% filter(dt$eType == 5) # Demographic Channel
nrow(dt5) # 591
dt6 <- dt %>% filter(dt$eType == 6) # Travel Channel
nrow(dt6) # 52
# Highest data for Demographic, Communication and Travel Channel.

# To check if any Source ID is equal to any Target ID:
for(i in dt6$Source){
  for(j in dt6$Target){
    if(i == j){
      print("Match Found")
    }
    else{
      print("No matches found")
    }
  }
}

# List the nodes appearing in more than one Channel:
head(dt4)
unique(dt01$Source) #41 37 34 27 40 65 67 47 39 43 57 58 63 56 45
unique(dt23$Source) # 67 39
unique(dt4$Source) #0
unique(dt5$Source) # 2 510031 552988  27 29 31  33  34  35  36 620120 37  38  39  40  41     
# 42  43  44  45  46  47  48  49  52  53  54  55  56  57  58  59  60  61  62  63
# 64  65  0
unique(dt6$Source) # 78 80 77 79 82 83 84 73 75 74 39 40 41 87 85 86

common_list <- NULL
for (i in dt01$Source) {
  for (j in dt23$Source) {
    if(i==j){
      common_list <- append(common_list,i)
      common_list <- unique(common_list)
    }
    
  }
  
}
for (i in dt01$Source) {
  for (j in dt4$Source) {
    if(i==j){
      common_list <- append(common_list,i)
      common_list <- unique(common_list)
    }
    
  }
  
}
for (i in dt01$Source) {
  for (j in dt5$Source) {
    if(i==j){
      common_list <- append(common_list,i)
      common_list <- unique(common_list)
    }
    
  }
  
}
for (i in dt01$Source) {
  for (j in dt6$Source) {
    if(i==j){
      common_list <- append(common_list,i)
      common_list <- unique(common_list)
    }
    
  }
  
}
common_list
length(common_list)

# Analysis of the Communication channel:
glimpse(dt01)
unique(dt01)
unique(dt01$eType) # 0 1
unique(dt01$SourceLocation) # NA  5  3  4  0
unique(dt01$TargetLocation) # NA  5  0  3  4
unique(dt01$SourceLatitude) # NA
unique(dt01$SourceLongitude) # NA
unique(dt01$TargetLatitude) # NA
unique(dt01$TargetLongitude) # NA
unique(dt01$Source)
unique(dt01$Target)

dt01 <- subset(dt01, select = -c(SourceLatitude, SourceLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
dt01 <- subset(dt01, select = -c(TargetLatitude, TargetLongitude))
dt01 <- subset(dt01, select = -Weight) # Weight removed as all values 1.
colnames(dt01)
any(dt01$Source) == any(dt01$Target) # True
range(dt01$Source) # 27-67
range(dt01$Target) # 0-67
range(dt01$Time) # 86400-27222388

# Analysis of the Demographic channel:
glimpse(dt5)
unique(dt5)
unique(dt5$eType) # 5
unique(dt5$SourceLocation) # NA
unique(dt5$TargetLocation) # NA 
unique(dt5$SourceLatitude) # NA
unique(dt5$SourceLongitude) # NA
unique(dt5$TargetLatitude) # NA
unique(dt5$TargetLongitude) # NA
unique(dt5$Source) 
unique(dt5$Target)
unique(dt5$Weight)

dt5 <- subset(dt5, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(dt5)
#any(dt5$Source) == any(dt5$Target) # True
range(dt5$Source) # 0-620120
range(dt5$Target) # 0-644226
range(dt5$Time) # 31536000-31536000
income_cat <- subset(dt5$Source, dt5$Source >= 500000)
unique(income_cat) #Income Categories: 510031(Gifts), 552988(Money Income before Taxes), 620120(Personal Taxes)
expense_cat <- subset(dt5$Target, dt5$Target >= 500000)
sort(unique(expense_cat)) # Expense Categories: 503218(Natural Gas) 503701(Miscellaneous) 520660(Healthcare) 523927(Restaurants) 527449 (Alcohol) 
                                  # 536346(Home Maintenance) 537281(HouseKeeping) 567195 (Personal insurance and pensions) 
                                  # 571970(Reading) 575030 (Transportation) 577992 (Education) 580426 (Telephone services) 
                                  # 589943(Lodging away from home) 595298(Groceries) 595581(Donations) 606730(Entertainment)
                                  # 616315(Apparel and services) 620120(Personal taxes) 621924(Mortgage payments) 
                                  # 630626(Rented dwellings) 632961(Personal care products and services) 
                                  # 640784(Tobacco) 642329(Household operations) 644226(Property taxes)

hist(dt5$Weight)
unique(dt5$Weight)
range(dt5$Weight) #2-200000

# Income Categories:
dt5_sub1 <- subset(dt5, dt5$Source >= 500000) # Subset of data with only income categories
str(dt5_sub1)
plot(dt5_sub1$Source, dt5_sub1$Weight) # Plot of Monetary income in each category

# Expense Categories:
dt5_sub2 <- subset(dt5, dt5$Target >= 500000) # Subset of data with only expense categories
str(dt5_sub2)
plot(dt5_sub2$Target, dt5_sub2$Weight) # Plot of Monetary expenses in each category

#any(dt6$Source) == any(dt6$Target)

# Travel Channel:

glimpse(dt6)
unique(dt6)
unique(dt6$eType) # 6
unique(dt6$SourceLocation) # 3 4 2 1 0 5
unique(dt6$TargetLocation) # 1 3 4 2 0 5
unique(dt6$SourceLatitude) # NA
unique(dt6$SourceLongitude) # NA
unique(dt6$TargetLatitude) # NA
unique(dt6$TargetLongitude) # NA
unique(dt6$Source) #78 80 77 79 82 83 84 73 75 74 39 40 41 87 85 86
unique(dt6$Target) #81 70 69 76 71 72
unique(dt6$Weight) #2 1 3 4 5 6


range(dt6$Source) # 39 87
range(dt6$Target) # 69 81
range(dt6$Time) # 11773606 31004806

hist(dt6$Weight)
unique(dt6$Weight) #2 1 3 4 5 6
range(dt6$Weight) #1 6

# Remove Duplicate rows:
head(dt6)
dt6 <- subset(dt6, select = -c(SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # Source and Target Latitude and Longitude columns removed as all Null.
dt6 <- dt6[!duplicated(dt6),]
nrow(dt6)
# No Duplicate rows in Travel Channel
target_count <- count(dt6, 'Target')
target_count
time_count <- count(dt6, 'Time')
time_count <- time_count %>% filter(time_count$freq > 1)
time_count
weight_count <- count(dt6, 'Weight')
weight_count
sourceloc_count <- count(dt6, 'SourceLocation')
sourceloc_count
targetloc_count <- count(dt6, 'TargetLocation')
targetloc_count
# Extracting the top 3 most repeated values from each Column:
target <- dt6 %>% filter(Target==71 | Target==70 | Target==69 )



# No rows with exactly equal Target, Time, Weight, SourceLoc and TargetLoc

# Procurement Channel:
glimpse(dt23)
unique(dt23)
unique(dt23$eType) # 2 3
unique(dt23$SourceLocation) # NA
unique(dt23$TargetLocation) # NA
unique(dt23$SourceLatitude) # NA
unique(dt23$SourceLongitude) # NA
unique(dt23$TargetLatitude) # NA
unique(dt23$TargetLongitude) # NA
unique(dt23$Source) # 67 39
unique(dt23$Target) # 657187: Same as Graph 1, 2, 3, 5
unique(dt23$Weight) # 300 100 600 800

dt23 <- subset(dt23, select = -c(SourceLocation, TargetLocation, SourceLatitude, SourceLongitude, TargetLatitude, TargetLongitude)) # SOurce and Target Latitude and Longitude columns removed as all Null.
colnames(dt23)
range(dt23$Source) 
range(dt23$Target) 
range(dt23$Time) # 9519349 19649264

hist(dt23$Weight)
unique(dt23$Weight) 
range(dt23$Weight) #100 800







