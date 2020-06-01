library(tidyverse)

# Look at Template dataset
Template <- read.csv('CGCS-Template.csv')
head(Template)
tail(Template)
summary(Template)
length(duplicated(Template))

# Separate data by channels:
Email <- Template %>% filter(Template$eType == 0) # Communication Channel Email
nrow(Email) # 314
Call <- Template %>% filter(Template$eType == 1) # Communication Channel Phone
nrow(Call) #249
Sell <- Template %>% filter(Template$eType == 2) # Procurement Channel Sell
nrow(Sell) # 9
Buy <- Template %>% filter(Template$eType == 3) # Procurement Channel Buy
nrow(Buy) # 9
Author <- Template %>% filter(Template$eType == 4) # Co-authorship Channel
nrow(Author) # 1
DemoC<- Template %>% filter(Template$eType == 5) # Demographic Channel
nrow(DemoC) # 691
TravelC <- Template %>% filter(Template$eType == 6) # Travel Channel
nrow(TravelC) # 52
# Highest data for Demographic, Communication and Travel Channel.

# Person ID 0 and 39 only recieve Call from others, becasue they only appear in Target.
unique(Call$Source)#34 41 27 37 65 40 43 63 56 58 47 45 57
unique(Call$Target)#27 37 41 34 39  0 40 65 56 43 57 63 47 45 58

# Person ID 0, 66 and 45 only recieve Email from others, becasue they only appear in Target.
unique(Email$Source)#41 37 27 40 34 65 67 47 39 57 58 63 56 43
unique(Email$Target)#34 27 37 41  0 39 66 47 65 40 67 56 43 58 45 63 57

#Check the person34 in Call Channel
Person34_Call <- Call %>% filter(Call$Source == "34" | Call$Target == "34")
#Check the person34 in Email Channel
Person34_Email <- Email %>% filter(Email$Source == "34" | Email$Target == "34")
Person39_Call <- Call %>% filter(Call$Source == "39" | Call$Target == "39")

# To check if any Source ID is equal to any Target ID:
for(i in TravelC$Source){
  for(j in TravelC$Target){
    if(i == j){
      print("Match Found")
    }
  }
}

glimpse(Email)
sum(Sell$Weight) == sum(Buy$Weight)
#Working on Weights of different channels
unique(Email$Weight) #1
unique(Call$Weight) #1 all weights in Communication channel is 1
unique(Sell$Weight)
unique(Buy$Weight) 
range(Sell$Weight)#Weight Range of Procurement Channel is 100~800
all.equal(Sell$Weight, Buy$Weight)
all.equal(Sell$Time, Buy$Time)# The Sell and Buy corresponding to each other 
range(DemoC$Weight) #Weight Range of Demographic Channel is 2~200000
unique(DemoC$Weight)
range(TravelC$Weight) #Weight Range of Travel Channel is 1~6



## Look at Subgragh_1 dataset
Subgragh_1 <- read.csv('Q1-Graph1.csv')
head(Subgragh_1)
tail(Subgragh_1)
summary(Subgragh_1)

# Separate data by channels:
Email01 <- Subgragh_1 %>% filter(Subgragh_1$eType == 0) # Communication Channel Email
nrow(Email01) # 187
Call01 <- Subgragh_1 %>% filter(Subgragh_1$eType == 1) # Communication Channel Phone
nrow(Call01) #131
Sell01 <- Subgragh_1 %>% filter(Subgragh_1$eType == 2) # Procurement Channel Sell
nrow(Sell01) # 7
Buy01 <- Subgragh_1 %>% filter(Subgragh_1$eType == 3) # Procurement Channel Buy
nrow(Buy01) # 7
Author01 <- Subgragh_1 %>% filter(Subgragh_1$eType == 4) # Co-authorship Channel
nrow(Author01) # 1
DemoC01<- Subgragh_1 %>% filter(Subgragh_1$eType == 5) # Demographic Channel
nrow(DemoC01) # 846
TravelC01 <- Subgragh_1 %>% filter(Subgragh_1$eType == 6) # Travel Channel
nrow(TravelC01) # 37

# To check if any Source ID is equal to any Target ID:
for(i in TravelC01$Source){
  for(j in TravelC01$Target){
    if(i == j){
      print("Match Found")
    }
  }
}

glimpse(Email01)
sum(Sell01$Weight) == sum(Buy01$Weight)
#Working on Weights of different channels
unique(Email01$Weight) #1
unique(Call01$Weight) #1 all weights in Communication channel is 1
unique(Sell01$Weight)
unique(Buy01$Weight) 
range(Sell01$Weight)#Weight Range of Procurement Channel is 122~792
all.equal(Sell01$Weight, Buy01$Weight)
all.equal(Sell01$Time, Buy01$Time)# The Sell and Buy corresponding to each other 
range(DemoC01$Weight) #Weight Range of Demographic Channel is 0.46~900735.00
unique(DemoC01$Weight)
range(TravelC01$Weight) #Weight Range of Travel Channel is 1~5


## Look at Subgragh_2 dataset
Subgragh_2 <- read.csv('Q1-Graph2.csv')
head(Subgragh_2)
tail(Subgragh_2)
summary(Subgragh_2)

# Separate data by channels:
Email02 <- Subgragh_2 %>% filter(Subgragh_2$eType == 0) # Communication Channel Email
nrow(Email02) # 258
Call02 <- Subgragh_2 %>% filter(Subgragh_2$eType == 1) # Communication Channel Phone
nrow(Call02) #177
Sell02 <- Subgragh_2 %>% filter(Subgragh_2$eType == 2) # Procurement Channel Sell
nrow(Sell02) # 7
Buy02 <- Subgragh_2 %>% filter(Subgragh_2$eType == 3) # Procurement Channel Buy
nrow(Buy02) # 7
Author02 <- Subgragh_2 %>% filter(Subgragh_2$eType == 4) # Co-authorship Channel
nrow(Author02) # 4
DemoC02<- Subgragh_2 %>% filter(Subgragh_2$eType == 5) # Demographic Channel
nrow(DemoC02) # 823
TravelC02 <- Subgragh_2 %>% filter(Subgragh_2$eType == 6) # Travel Channel
nrow(TravelC02) # 24

# To check if any Source ID is equal to any Target ID:
for(i in TravelC02$Source){
  for(j in TravelC02$Target){
    if(i == j){
      print("Match Found")
    }
  }
}

glimpse(Email02)
sum(Sell02$Weight) == sum(Buy02$Weight)
#Working on Weights of different channels
unique(Email02$Weight) #1
unique(Call02$Weight) #1 all weights in Communication channel is 1
unique(Sell02$Weight)
unique(Buy02$Weight) 
range(Sell02$Weight)#Weight Range of Procurement Channel is 209~958
all.equal(Sell02$Weight, Buy02$Weight)
all.equal(Sell02$Time, Buy02$Time)# The Sell and Buy corresponding to each other 
range(DemoC02$Weight) #Weight Range of Demographic Channel is 0.17~196567.00
unique(DemoC02$Weight)
range(TravelC02$Weight) #Weight Range of Travel Channel is 1~7


## Look at Subgragh_3 dataset
Subgragh_3 <- read.csv('Q1-Graph3.csv')
head(Subgragh_3)
tail(Subgragh_3)
summary(Subgragh_3)

# Separate data by channels:
Email03 <- Subgragh_3 %>% filter(Subgragh_3$eType == 0) # Communication Channel Email
nrow(Email03) # 109
Call03 <- Subgragh_3 %>% filter(Subgragh_3$eType == 1) # Communication Channel Phone
nrow(Call03) #51
Sell03 <- Subgragh_3 %>% filter(Subgragh_3$eType == 2) # Procurement Channel Sell
nrow(Sell03) # 6
Buy03 <- Subgragh_3 %>% filter(Subgragh_3$eType == 3) # Procurement Channel Buy
nrow(Buy03) # 6
Author03 <- Subgragh_3 %>% filter(Subgragh_3$eType == 4) # Co-authorship Channel
nrow(Author03) # 1
DemoC03<- Subgragh_3 %>% filter(Subgragh_3$eType == 5) # Demographic Channel
nrow(DemoC03) # 519
TravelC03 <- Subgragh_3 %>% filter(Subgragh_3$eType == 6) # Travel Channel
nrow(TravelC03) # 37

# To check if any Source ID is equal to any Target ID:
for(i in TravelC03$Source){
  for(j in TravelC03$Target){
    if(i == j){
      print("Match Found")
    }
  }
}

glimpse(Email03)
sum(Sell03$Weight) == sum(Buy03$Weight)
#Working on Weights of different channels
unique(Email03$Weight) #1
unique(Call03$Weight) #1 all weights in Communication channel is 1
unique(Sell03$Weight)
unique(Buy03$Weight) 
range(Sell03$Weight)#Weight Range of Procurement Channel is 110~398
all.equal(Sell03$Weight, Buy03$Weight)
all.equal(Sell03$Time, Buy03$Time)# The Sell and Buy corresponding to each other 
range(DemoC03$Weight) #Weight Range of Demographic Channel is 1.53~159997.00
unique(DemoC03$Weight)
range(TravelC03$Weight) #Weight Range of Travel Channel is 1~6


## Look at Subgragh_4 dataset
Subgragh_4 <- read.csv('Q1-Graph4.csv')
head(Subgragh_4)
tail(Subgragh_4)
summary(Subgragh_4)

# Separate data by channels:
Email04 <- Subgragh_4 %>% filter(Subgragh_4$eType == 0) # Communication Channel Email
nrow(Email04) # 45
Call04 <- Subgragh_4 %>% filter(Subgragh_4$eType == 1) # Communication Channel Phone
nrow(Call04) #61
Sell04 <- Subgragh_4 %>% filter(Subgragh_4$eType == 2) # Procurement Channel Sell
nrow(Sell04) # 5
Buy04 <- Subgragh_4 %>% filter(Subgragh_4$eType == 3) # Procurement Channel Buy
nrow(Buy04) # 12
Author04 <- Subgragh_4 %>% filter(Subgragh_4$eType == 4) # Co-authorship Channel
nrow(Author04) # 0
DemoC04<- Subgragh_4 %>% filter(Subgragh_4$eType == 5) # Demographic Channel
nrow(DemoC04) # 494
TravelC04 <- Subgragh_4 %>% filter(Subgragh_4$eType == 6) # Travel Channel
nrow(TravelC04) # 115

# To check if any Source ID is equal to any Target ID:
for(i in TravelC04$Source){
  for(j in TravelC04$Target){
    if(i == j){
      print("Match Found")
    }
  }
}

glimpse(Email04)
sum(Sell04$Weight) == sum(Buy04$Weight)
#Working on Weights of different channels
unique(Email04$Weight) #1
unique(Call04$Weight) #1 all weights in Communication channel is 1
unique(Sell04$Weight)
unique(Buy04$Weight) # Sell and Buy have different Weights (Not pairwise match)
range(Sell04$Weight)#Weight Range of Procurement Sell Channel is 2~1398
range(Buy04$Weight)#Weight Range of Procurement Buy Channel is 1~596
range(DemoC04$Weight) #Weight Range of Demographic Channel is 2.39~141744.00
unique(DemoC04$Weight)
range(TravelC04$Weight) #Weight Range of Travel Channel is -1~6


## Look at Subgragh_5 dataset
Subgragh_5 <- read.csv('Q1-Graph5.csv')
head(Subgragh_5)
tail(Subgragh_5)
summary(Subgragh_5)

# Separate data by channels:
Email05 <- Subgragh_5 %>% filter(Subgragh_5$eType == 0) # Communication Channel Email
nrow(Email05) # 17
Call05 <- Subgragh_5 %>% filter(Subgragh_5$eType == 1) # Communication Channel Phone
nrow(Call05) #14
Sell05 <- Subgragh_5 %>% filter(Subgragh_5$eType == 2) # Procurement Channel Sell
nrow(Sell05) # 11
Buy05 <- Subgragh_5 %>% filter(Subgragh_5$eType == 3) # Procurement Channel Buy
nrow(Buy05) # 40
Author05 <- Subgragh_5 %>% filter(Subgragh_5$eType == 4) # Co-authorship Channel
nrow(Author05) # 0
DemoC05<- Subgragh_5 %>% filter(Subgragh_5$eType == 5) # Demographic Channel
nrow(DemoC05) # 203
TravelC05 <- Subgragh_5 %>% filter(Subgragh_5$eType == 6) # Travel Channel
nrow(TravelC05) # 110

# To check if any Source ID is equal to any Target ID:
for(i in TravelC05$Source){
  for(j in TravelC05$Target){
    if(i == j){
      print("Match Found")
    }
  }
}

glimpse(Email05)
sum(Sell05$Weight) == sum(Buy05$Weight)
#Working on Weights of different channels
unique(Email05$Weight) #1
unique(Call05$Weight) #1 all weights in Communication channel is 1
unique(Sell05$Weight)
unique(Buy05$Weight) # Sell and Buy have different Weights (Not pairwise match)
range(Sell05$Weight)#Weight Range of Procurement Sell Channel is 1~6663
range(Buy05$Weight)#Weight Range of Procurement Buy Channel is 1~2116
range(DemoC05$Weight) #Weight Range of Demographic Channel is 0.17~441206.00
unique(DemoC05$Weight)
range(TravelC05$Weight) #Weight Range of Travel Channel is -1~8

