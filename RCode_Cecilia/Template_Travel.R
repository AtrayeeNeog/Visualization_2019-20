library(tidyverse)
library(ggplot2)
library(dplyr)
library(hrbrthemes)


getwd()
setwd('~/OVGU/Visualization_Project/Foto_supply')
setwd('~/OVGU/Visualization_Project/MC1/data')
G1 <- read.csv('Q1-Graph1.csv')
G2 <- read.csv('Q1-Graph2.csv')
G3 <- read.csv('Q1-Graph3.csv')
G4 <- read.csv('Q1-Graph4.csv')
G5 <- read.csv('Q1-Graph5.csv')
Template <- read.csv('CGCS-Template.csv')
TravelC <- read.csv('eType6.csv')
Seed_1 <- read.csv('Q2-Seed1.csv')

# Travel Channel
Temp_Travel <-  Template %>% filter(Template$eType == 6)
G1_Travel <- filter(G1, eType == '6')
G2_Travel <- filter(G2, eType == '6')
G3_Travel <- filter(G3, eType == '6')
G4_Travel <- filter(G4, eType == '6')
G5_Travel <- filter(G5, eType == '6')

# Drop out the duplicated rows (No duplicated data)
Temp_Travel_dedupted <- Temp_Travel[!duplicated(Temp_Travel), ]
G1_Travel_dedupted <-G1_Travel[!duplicated(G1_Travel), ]
G2_Travel_dedupted <-G2_Travel[!duplicated(G2_Travel), ]
G3_Travel_dedupted <-G3_Travel[!duplicated(G3_Travel), ]
# G4 and G5 has duplicated rows, after dedupted, G4 from 115 reduced to 23
#after dedupted, G5 from 110 reduced to 22
G4_Travel_dedupted <-G4_Travel[!duplicated(G4_Travel), ]
G5_Travel_dedupted <-G5_Travel[!duplicated(G5_Travel), ]
Travel_dedupted <- TravelC[!duplicated(TravelC), ]

range(Temp_Travel$Time) #range of time: 11773606~31004806
Temp_Travel<- transform(Temp_Travel, Start_Day = Time/86400)
G1_Travel<- transform(G1_Travel, Start_Day = Time/86400)
G2_Travel<- transform(G2_Travel, Start_Day = Time/86400)
G3_Travel<- transform(G3_Travel, Start_Day = Time/86400)
G4_Travel<- transform(G4_Travel_dedupted, Start_Day = Time/86400)
G5_Travel<- transform(G5_Travel_dedupted, Start_Day = Time/86400)
Seed1_eT6<-transform(Seed1_eT6,Start_Day = Time/86400)
Seed3_eT6<-transform(Seed3_eT6,Start_Day = Time/86400)

#Create a new column to show the end day of trip 
#(by adding start day and length of trip together)
Temp_Travel<- transform(Temp_Travel, End_Day = Start_Day + Weight)
G1_Travel<- transform(G1_Travel, End_Day = Start_Day + Weight)
G2_Travel<- transform(G2_Travel, End_Day = Start_Day + Weight)
G3_Travel<- transform(G3_Travel, End_Day = Start_Day + Weight)
G4_Travel<- transform(G4_Travel, End_Day = Start_Day + Weight)
G5_Travel<- transform(G5_Travel, End_Day = Start_Day + Weight)
Seed1_eT6<- transform(Seed1_eT6, End_Day = Start_Day + Weight)
Seed3_eT6<- transform(Seed3_eT6, End_Day = Start_Day + Weight)

duplicated(Temp_Travel$Time)

group1 <- Temp_Travel[12:13, ]
group2 <- Temp_Travel[45:46, ]
groupTravel <- full_join(group1,group2)
group1 <- group1[,c(0:7,12:13)]
group2 <- group2[,c(0:7,12:13)]

group1 <- transform(group1, PersonID = as.character(Source))
group2 <- transform(group2, PersonID = as.character(Source))
 
ggplot(group2) + 
  geom_segment( aes(x=PersonID, xend=PersonID, y=Start_Day, yend=End_Day), color="grey") +
  geom_point( aes(x=PersonID, y=Start_Day), color=rgb(0.9,0.2,0.3,0.5), size = 3) +
  geom_point( aes(x=PersonID, y=End_Day), color=rgb(0.2,0.7,0.1,0.5), size = 3) +   
  coord_flip()+
  theme_ipsum() +
  theme(
    legend.position = "none",
  )+
  xlab("Person ID")
  ylab("Travel Day")
  


ggplot(group1) + 
  geom_segment( aes(x=PersonID, xend=PersonID, y=Start_Day, yend=End_Day), color="grey") +
  geom_point( aes(x=PersonID, y=Start_Day), color=rgb(0.2,0.7,0.1,0.5), size = 3) +
  geom_point( aes(x=PersonID, y=End_Day), color=rgb(0.1,0.1,0.9,0.5), size = 3) +   
  coord_flip()+
  theme_ipsum() +
  theme(
    legend.position = "none",
  )+
  xlab("Person ID")
  ylab("Travel Data")
  
#Plot Template_Travel records 
Temp_Travel<- transform(Temp_Travel, Target_location = as.character(TargetLocation))
Temp_Travel<- transform(Temp_Travel, Person = as.character(Source))
  

ggplot(Temp_Travel) + 
  geom_segment( aes(x=Person, xend=Person, y=Start_Day, yend=End_Day), color="grey") +
  geom_point( aes(x=Person, y=Start_Day,color=SourceLocation), size = 3) +
  geom_point( aes(x=Person, y=End_Day,color=TargetLocation), size = 3) +   
  coord_flip()+
  theme_ipsum() +
  theme(
    legend.position = "none",
  )+
  xlab("Person ID")
  ylab("Travel Data")
  
ggplot(Temp_Travel, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

#Plot G1_Travel records
G1_Travel<- transform(G1_Travel, Target_location = as.character(TargetLocation))
G1_Travel<- transform(G1_Travel, Person = as.character(Source))

ggplot(G1_Travel, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

#Plot G2_Travel records
G2_Travel<- transform(G2_Travel, Target_location = as.character(TargetLocation))
G2_Travel<- transform(G2_Travel, Person = as.character(Source))

ggplot(G2_Travel, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

#Plot G3_Travel records
G3_Travel<- transform(G3_Travel, Target_location = as.character(TargetLocation))
G3_Travel<- transform(G3_Travel, Person = as.character(Source))

ggplot(G3_Travel, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()


#Plot G4_Travel records
G4_Travel<- transform(G4_Travel, Target_location = as.character(TargetLocation))
G4_Travel<- transform(G4_Travel, Person = as.character(Source))

ggplot(G4_Travel, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

#Plot G5_Travel records
G5_Travel<- transform(G5_Travel, Target_location = as.character(TargetLocation))
G5_Travel<- transform(G5_Travel, Person = as.character(Source))

ggplot(G5_Travel, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

#Seed1_Travel Channel Connection
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

#Plot Seed1_Travel records
Seed1_eT6<- transform(Seed1_eT6, Target_location = as.character(TargetLocation))
Seed1_eT6<- transform(Seed1_eT6, Person = as.character(Source))

ggplot(Seed1_eT6, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()


#Seed3_Connections
Seed_3 <- read.csv('Q2-Seed3.csv')
head(Seed_3) #Only 1 Sell Procurement channel data

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

#Plot Seed3_Travel records
Seed3_eT6<- transform(Seed3_eT6, Target_location = as.character(TargetLocation))
Seed3_eT6<- transform(Seed3_eT6, Person = as.character(Source))

ggplot(Seed3_eT6, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()













