library(tidyverse)

getwd()
setwd('~/OVGU/Visualization_Project/MC1/data')
Co_AuthC <- read.csv('eType4.csv')
Sell_C <- read.csv('eType2.csv')
Buy_C <- read.csv('eType3.csv')
DemoC <- read.csv('eType5.csv')
TravelC <- read.csv('eType6.csv')


# Drop out the duplicated rows (No duplicated data)
CoAuth_Channel_dedupted <- Co_AuthC[!duplicated(Co_AuthC), ]
Demographic_dedupted <- DemoC[!duplicated(DemoC), ]
#There are a bit duplicated rows in Sell Procurement Channel, 389050 obs left.
Sell_dedupted <- Sell_C[!duplicated(Sell_C), ]
#There is only one duplicated row in Buy Procurement Channel, 389210 obs left.
Buy_dedupted <- Buy_C[!duplicated(Buy_C), ] 

Procurement_dedupted <- ProC[!duplicated(ProC), ]
#Travel Channel has a lot of duplicated data, there are only 298481 left after deduplicated.
Travel_dedupted <- TravelC[!duplicated(TravelC), ]

#Seed1_Connections
Seed_1 <- read.csv('Q2-Seed1.csv')
head(Seed_1) #Only 1 Co-authorship channel data

#Find out all papers that Person600971 has written.
Seed_600971 <- filter(Co_AuthC, Source == "600971")
#Below are the all publications that Person 600971 involved with
Pulication_579269 <- filter(Co_AuthC, Target == "579269")
Pulication_463021 <- filter(Co_AuthC, Target == "463021")
Pulication_607498 <- filter(Co_AuthC, Target == "607498")
Pulication_530665 <- filter(Co_AuthC, Target == "530665")

# Merge all there data frames together, 
#these are the edges that connected with Seed1_Person 600971
Seed1_eT4 <- rbind(Seed_600971,Pulication_463021,Pulication_530665,
                   Pulication_607498,Pulication_579269)

#7 other people who had written some papers with 600971: 
#561356 609913 611692 540660 475588 470085 484189u
unique(Seed1_eT4$Source)

#eType5 -> Demographic Channel
Person_600971 <- filter(DemoC, Source == "600971"| Target == "600971")
#Add DemographicCategories to make item more understandable
Category <- read.csv('DemographicCategories.csv')
Seed1_eT5 <- merge(Person_600971, Category, by.x = "Target", by.y = "NodeID", all.x = TRUE, all.y = FALSE)

#eType6 -> Travel Channel
Travel_600971 <- filter(Travel_dedupted, Source == "600971")

#Look up other people who travel to the some place at the same time and stayed in the same period of time there. 
#There are 9 Travel records of person 600971
Travel600971_01 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '5' & Time == '19785600' & Weight == '1')
Travel600971_02 <- filter(Travel_dedupted, SourceLocation == "5" & TargetLocation == '1' & Time == '25401600' & Weight == '1')
Travel600971_03 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '2' & Time == '6307200' & Weight == '1')
Travel600971_04 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '1' & Time == '26006400' & Weight == '0')
Travel600971_05 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '2' & Time == '23587200' & Weight == '0')
Travel600971_06 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '1' & Time == '15465600' & Weight == '5')
Travel600971_07 <- filter(Travel_dedupted, SourceLocation == "0" & TargetLocation == '4' & Time == '1641600' & Weight == '-1')
Travel600971_08 <- filter(Travel_dedupted, SourceLocation == "0" & TargetLocation == '5' & Time == '24019200' & Weight == '3')
Travel600971_09 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '3' & Time == '2505600' & Weight == '5')
#Finally, we get the list of 61 Travel records that are same with Person 600971
#Besides 600971 itself, there are 52 Travel records, and related with 52 other people.
Seed1_eT6 <- rbind(Travel600971_01,Travel600971_02,Travel600971_03,Travel600971_04,
                   Travel600971_05, Travel600971_06, Travel600971_07,Travel600971_08,
                   Travel600971_09)
unique(Seed1_eT6$Source) # 53 Person ID


#Seed2_Connections
Seed_2 <- read.csv('Q2-Seed2.csv')
head(Seed_2) #Only 1 Co-authorship channel data

# Person 538771 are only connected with other people by Co-Authership Channel
Seed_538771 <- filter(Co_AuthC, Source == "538771")
#Below are the all publications that Person 538771 involved with
#Write a for loop to find out all records that related with these publications
Pulication_579269 <- filter(Co_AuthC, Target == "579269")
Seed2_eT4 <- filter_all(Co_AuthC$Target == Seed_538771$Target)


#Seed3_Connections
Seed_3 <- read.csv('Q2-Seed3.csv')
head(Seed_3) #Only 1 Sell Procurement channel data

#eType0 and 1:
#3161 People connected with Person574136 by Communication Channel.
Seed_574136 <- filter(Co_AuthC, Source == "574136")
#574136 didn't write any paper

#eType5 -> Demographic Channel
Person_574136 <- filter(DemoC, Source == "574136"| Target == "574136")
#Add DemographicCategories to make item more understandable
Seed3_eT5 <- merge(Person_574136, Category, by.x = "Target", by.y = "NodeID", all.x = TRUE, all.y = FALSE)


#eType2 and 3 
#There are 3 Records that Person574136 sell Item657187
# Also, 3 corresponding buy records that 3 people buy Item657187 from Person574136
Seed_574136 <- filter(Sell_dedupted, Source == "574136" & Target == "657187")
Item_657187 <- filter(Buy_dedupted, Target == "657187" & Time == "1991785" & Weight == "633")
Item_657187_01 <- filter(Buy_dedupted, Target == "657187" & Time == "6742286" & Weight == "546")
Item_657187_02 <- filter(Buy_dedupted, Target == "657187" & Time == "22839875" & Weight == "82")
Seed3_eT2n3 <- rbind(Seed_574136,Item_657187,Item_657187_01,Item_657187_02)

#eType6 -> Travel Channel
#Look up other people who travel to the some place at the same time and stayed in the same period of time there. 
#There are 4 Travel records of person 574136
Travel_574136 <- filter(Travel_dedupted, Source == "574136")
Travel574136_01 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '1' & Time == '2160000' & Weight == '2')
Travel574136_02 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '0' & Time == '13305600' & Weight == '1')
Travel574136_03 <- filter(Travel_dedupted, SourceLocation == "3" & TargetLocation == '2' & Time == '19008000' & Weight == '1')
Travel574136_04 <- filter(Travel_dedupted, SourceLocation == "4" & TargetLocation == '2' & Time == '12096000' & Weight == '4')

#Finally, we get the list of 26 Travel records that are same with Person 574136
#Besides 574136 itself, there are 22 Travel records, and related with 22 other people.
Seed3_eT6 <- rbind(Travel574136_01,Travel574136_02,Travel574136_03,Travel574136_04)
unique(Seed3_eT6$Source)
       
library(dplyr)
library(ggplot2)
library(hrbrthemes)
       
setwd('~/OVGU/Visualization_Project/graphsExtended')
Seed1_Extend <- read.csv('Seed1-Graph2NonCom.csv')
S1_extendT<- filter(Seed1_Extend, eType == "6")
S1_extendT <- select(S1_extendT, -X)

S1_extendT <- transform(S1_extendT, TargetLocation = case_when(
    Target=="561157" ~ "0",
    Target=="657173" ~ "1",
    Target=="499467" ~ "2",
    Target=="625756" ~ "3",
    Target=="509607" ~ "4",
    Target=="616453" ~ "5",
  ))
unique(S1_extendT$TargetLocation)
unique(S1_extendT$Target)
#drop duplicated data
S1_extendT <-S1_extendT[!duplicated(S1_extendT), ]
S1_extendT <-transform(S1_extendT ,Start_Day = Time/86400)
S1_extendT<- transform(S1_extendT, End_Day = Start_Day + Weight)
unique(S1_extendT$Source)

#Plot Seed1_Travel records
S1_extendT<- transform(S1_extendT, Target_location = as.character(TargetLocation))
S1_extendT<- transform(S1_extendT, Person = as.character(Source))

ggplot(S1_extendT, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()
unique(S3_extendT_d$Source)

##Start with Seed3
Seed3_Extend <- read.csv('Seed3-Graph2NonCom.csv')
S3_extendT<- filter(Seed3_Extend, eType == "6")
S3_extendT <- select(S3_extendT, -X)

S3_extendT <- transform(S3_extendT, TargetLocation = case_when(
  Target=="561157" ~ "0",
  Target=="657173" ~ "1",
  Target=="499467" ~ "2",
  Target=="625756" ~ "3",
  Target=="509607" ~ "4",
  Target=="616453" ~ "5",
))
#Check if there is any N/A after new variable
unique(S3_extendT$TargetLocation)
unique(S3_extendT$Target)

#drop duplicated data
S3_extendT_d <-S3_extendT[!duplicated(S3_extendT), ]
#Add Start_Day according to Time
S3_extendT_d <-transform(S3_extendT ,Start_Day = Time/86400)
S3_extendT_d<- transform(S3_extendT, End_Day = Start_Day + Weight)


#Plot Seed1_Travel records
S3_extendT_d<- transform(S3_extendT_d, Target_location = as.character(TargetLocation))
S3_extendT_d<- transform(S3_extendT_d, Person = as.character(Source))

ggplot(S3_extendT_d, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

Seed3_ex <- semi_join(Seed3_eT6, Travel_dedupted,by="Source")





