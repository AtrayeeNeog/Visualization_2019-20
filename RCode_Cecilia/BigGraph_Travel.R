library(tidyverse)
library(plyr)
library(ggplot2)
library(hrbrthemes)

## BigGraph Travel Channel:
# Load The Data
getwd()
setwd('~/OVGU/Visualization_Project/MC1/data')
Travel <- read.csv("eType6.csv")
Travel_dedupted <- Travel[!duplicated(Travel), ]

Travel<- transform(Travel_dedupted, Start_Day = Time/86400)
Travel<- transform(Travel, End_Day = Start_Day + Weight)
nrow(Travel)#298481 records
Travel_New <- filter(Travel, Weight != -1)
nrow(Travel_New) #196760

# Each variable with it's Frequency Counts:
target_count <- count(Travel_New, 'TargetLocation')
target_count <- target_count[order(target_count$freq,decreasing = TRUE),]
target_count # 3,0,5,2,1,4 in order


sourceloc_count <- count(Travel_New, 'SourceLocation')
sourceloc_count <- sourceloc_count[order(sourceloc_count$freq,decreasing = TRUE),]
sourceloc_count #4,1,2,5,0,3 in order However, Travel to location 4 is really high 55695

travel_count <- count(Travel_New, c('SourceLocation','TargetLocation'))
time_count <- time_count %>% filter(time_count$freq > 1)
travel_count <- travel_count[order(travel_count$freq,decreasing = TRUE),]
head(travel_count)

time_count <- count(Travel_New, 'Start_Day')
time_count <- time_count %>% filter(time_count$freq > 1)
time_count <- time_count[order(time_count$freq,decreasing = TRUE),]
head(time_count) #The top3 values are: 96,364,280
weight_count <- count(Travel_New, 'Weight')
weight_count #-1(drop),2,3,1,4,0 (in the freq order)
#So the top 3 values are: 2,3,1

#Count for SourceLocation4 to all other places
Sourloc4 <- filter(Travel_New, SourceLocation == '4')
target_source4_count <- count(Sourloc4, 'TargetLocation')
target_source4_count <- target_source4_count[order(target_source4_count$freq,decreasing = TRUE),]
head(target_source4_count)

#Count for SourceLocation1 to all other places
Sourloc1 <- filter(Travel_New, SourceLocation == '1')
target_source1_count <- count(Sourloc1, 'TargetLocation')
target_source1_count <- target_source1_count[order(target_source1_count$freq,decreasing = TRUE),]
head(target_source1_count)

#Count for SourceLocation2 to all other places
Sourloc2 <- filter(Travel_New, SourceLocation == '2')
target_source2_count <- count(Sourloc2, 'TargetLocation')
target_source2_count <- target_source2_count[order(target_source2_count$freq,decreasing = TRUE),]
head(target_source2_count)

#Count for SourceLocation5 to all other places
Sourloc5 <- filter(Travel_New, SourceLocation == '5')
target_source5_count <- count(Sourloc5, 'TargetLocation')
target_source5_count <- target_source5_count[order(target_source5_count$freq,decreasing = TRUE),]
head(target_source5_count)

#Count for SourceLocation0 to all other places
Sourloc0 <- filter(Travel_New, SourceLocation == '0')
target_source0_count <- count(Sourloc0, 'TargetLocation')
target_source0_count <- target_source0_count[order(target_source0_count$freq,decreasing = TRUE),]
head(target_source0_count)

#Count for SourceLocation3 to all other places
Sourloc3 <- filter(Travel_New, SourceLocation == '3')
target_source3_count <- count(Sourloc3, 'TargetLocation')
target_source3_count <- target_source3_count[order(target_source3_count$freq,decreasing = TRUE),]
head(target_source3_count)

Targetloc5 <- filter(Travel_New, TargetLocation == '5')
nrow(Targetloc5)

#Extract the records of travel from Location 4 to 5
Location4to5 <- filter(Travel_New, SourceLocation == '4'& TargetLocation == '5')
nrow(Location4to5)#11264
Time4to5_count <- count(Location4to5,"Start_Day")
Time4to5_count<- Time4to5_count[order(Time4to5_count$freq,decreasing = TRUE),]
head(Time4to5_count) #Day118 and 353 has the most travel
TT118 <- filter(Location4to5, Start_Day == "118") #47
TT353 <- filter(Location4to5, Start_Day == "353") #47
#Check if there are common person in this two time #535648 599610 has travelled at both of time
nodes_common = NULL
for (i in TT118$Source) {
  for (j in TT353$Source) {
    if(i==j){
      nodes_common <- append(nodes_common,i)
      nodes_common <- unique(nodes_common)
    }
    
  }
  
}


#Extract the records of travel from Location 4 to 3
Location4to3 <- filter(Travel_New, SourceLocation == '4'& TargetLocation == '3')
nrow(Location4to3)#11326
Time4to3_count <- count(Location4to3,"Start_Day")
Time4to3_count<- Time4to5_count[order(Time4to3_count$freq,decreasing = TRUE),]
head(Time4to3_count) #Day74 has the most travel
TT74 <- filter(Location4to3, Start_Day == "74")

#Extract the records of travel from Location 1 to 5
Location1to5 <- filter(Travel_New, SourceLocation == '1'& TargetLocation == '5')
nrow(Location1to5)#6329
Time1to5_count <- count(Location1to5,"Start_Day")
Time1to5_count<- Time4to5_count[order(Time1to5_count$freq,decreasing = TRUE),]
head(Time1to5_count) #Day78 has the most travel
TT78 <- filter(Location4to3, Start_Day == "78")

#Extract the records of travel from Location 4 to 0
Location4to0 <- filter(Travel_New, SourceLocation == '4'& TargetLocation == '0')
nrow(Location4to0) #10770
Time4to0_count <- count(Location4to0,"Start_Day")
Time4to0_count<- Time4to0_count[order(Time4to0_count$freq,decreasing = TRUE),]
head(Time4to0_count)#Day87 has the most travel
TT87 <- filter(Location4to3, Start_Day == "87")

#Extract the records of travel from Location 4 to 1
Location4to1 <- filter(Travel_New, SourceLocation == '4'& TargetLocation == '1')
nrow(Location4to1) #11290
Time4to1_count <- count(Location4to1,"Start_Day")
Time4to1_count<- Time4to1_count[order(Time4to1_count$freq,decreasing = TRUE),]
head(Time4to1_count)#Day96 has the most travel
TT96 <- filter(Location4to1, Start_Day == "96")

#Extract the records of travel from Location 4 to 2
Location4to2 <- filter(Travel_New, SourceLocation == '4'& TargetLocation == '2')
nrow(Location4to2) #11045
Time4to2_count <- count(Location4to2,"Start_Day")
Time4to2_count<- Time4to2_count[order(Time4to2_count$freq,decreasing = TRUE),]
head(Time4to2_count)#Day87 137 has the most travel
TT137 <- filter(Location4to2, Start_Day == "137")

#Extract the records of travel from Location 1 to 4
Location1to4 <- filter(Travel_New, SourceLocation == '1'& TargetLocation == '4')
nrow(Location1to4) #5754
Time1to4_count <- count(Location1to4,"Start_Day")
Time1to4_count<- Time1to4_count[order(Time1to4_count$freq,decreasing = TRUE),]
head(Time1to4_count)#Day14 has the most travel
TT14 <- filter(Location1to4, Start_Day == "14")

New <- rbind(TT74,TT78,TT96,TT87,TT14,TT137)
nrow(New)
length(unique(New$Source))
#Plot Main_Travel records:
New <- transform(New, Target_location = as.character(TargetLocation))
New <- transform(New, Source_location = as.character(SourceLocation))
New <- transform(New, Person = as.character(Source))

ggplot(New, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()



#Extract the records of travel from Location 2 to 5
Location2to5 <- filter(Travel_New, SourceLocation == '2'& TargetLocation == '5')
nrow(Location2to5)#6103

#Extract the records of travel from Location 5 to 3
Location5to3 <- filter(Travel_New, SourceLocation == '5'& TargetLocation == '3')
nrow(Location5to3)#5795

#Extract the records of travel from Location 0 to 5
Location0to5 <- filter(Travel_New, SourceLocation == '0'& TargetLocation == '5')
nrow(Location0to5)#5266

#Extract the records of travel from Location 3 to 2
Location3to2 <- filter(Travel_New, SourceLocation == '3'& TargetLocation == '2')
nrow(Location3to2)#5544

#Extract the records of travel from Location 3 to 5
Location3to5 <- filter(Travel_New, SourceLocation == '3'& TargetLocation == '5')
nrow(Location3to5)#5445



person_count<- count(Location4to5, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) #641650 tralled the most 6 times from 4 to 5

person_count<- count(Location4to3, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) #534034,590227,629717 tralled the most 6 times

person_count<- count(Location1to5, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) # 461287,467163,587919,625681,626021 tralled the most 5 times from 1 to 5

person_count<- count(Location2to5, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) # 538809 tralled the most 5 times from 2 to 5

person_count<- count(Location5to3, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) # 544200 tralled the most 6 times from 5 to 3

person_count<- count(Location0to5, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) # 643925 tralled the most 6 times from 0 to 5

person_count<- count(Location3to2, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) # 635665 tralled the most 6 times from 3 to 2

person_count<- count(Location3to5, 'Source')
person_count <- person_count[order(person_count$freq,decreasing = TRUE),]
head(person_count) # 484356,516231,585634,624297 tralled the most 5 times from 3 to 5

Person1 <- filter(Travel_New, Source == '635665')
Person2 <- filter(Travel_New, Source == '641650')
Person3 <- filter(Travel_New, Source == '534034')
Person4 <- filter(Travel_New, Source == '590227')
Person5 <- filter(Travel_New, Source == '629717')
Person6 <- filter(Travel_New, Source == '544200')
Person7 <- filter(Travel_New, Source == '643925')

Travel_most <- rbind(Person1,Person2,Person3,Person4,Person5,Person6,Person7)

#Plot Main_Travel records:
Travel_most<- transform(Travel_most, Target_location = as.character(TargetLocation))
Travel_most<- transform(Travel_most, Source_location = as.character(SourceLocation))
Travel_most<- transform(Travel_most, Person = as.character(Source))

ggplot(Travel_most, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

ggplot(Mainperson_T) + 
  geom_segment( aes(x=Person, xend=Person, y=Start_Day, yend=End_Day), color="grey") +
  geom_point( aes(x=Person, y=Start_Day), color=rgb(0.2,0.7,0.1,0.5), size = 3) +
  geom_point( aes(x=Person, y=End_Day), color=rgb(0.1,0.1,0.9,0.5), size = 3) +   
  coord_flip()+
  theme_ipsum() +
  theme(
    legend.position = "none",
  )+
  xlab("Person ")
ylab("Travel Data")


#Take these most frequent persons out


#Only take the people who have travelled more than 3 times
main_person<- filter(person_count, freq > '4')
nrow(main_person) #11 persons
#Extract the travel records of this 11 persons
Mainperson_T <- merge(x=Location4to5, y=main_person,by="Source")
nrow(Mainperson_T) #56 travel records
length(unique(Mainperson_T$Source)) #11 persons

#Check the time of travel for these records
MainT_Time_count <- count(Mainperson_T,"Start_Day")
MainT_Time_count<- MainT_Time_count[order(MainT_Time_count$freq,decreasing = TRUE),]
head(MainT_Time_count) #The travel times are more than 20 at Day 56,220,63,287

Day56 <- filter(Mainperson_T, Start_Day == "56")
unique(Day56$Source)
Day63 <- filter(Mainperson_T, Start_Day == "63")
unique(Day63$Source)

#Plot Main_Travel records:
Mainperson_T<- transform(Mainperson_T, Target_location = as.character(TargetLocation))
Mainperson_T<- transform(Mainperson_T, Source_location = as.character(SourceLocation))
Mainperson_T<- transform(Mainperson_T, Person = as.character(Source))

ggplot(Mainperson_T, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

ggplot(Mainperson_T) + 
  geom_segment( aes(x=Person, xend=Person, y=Start_Day, yend=End_Day), color="grey") +
  geom_point( aes(x=Person, y=Start_Day), color=rgb(0.2,0.7,0.1,0.5), size = 3) +
  geom_point( aes(x=Person, y=End_Day), color=rgb(0.1,0.1,0.9,0.5), size = 3) +   
  coord_flip()+
  theme_ipsum() +
  theme(
    legend.position = "none",
  )+
  xlab("Person ")
ylab("Travel Data")









Target <- filter(Travel, Target =="561157" | Target == "509607" | Target == "657173") #169218 travel records; 
weight <- filter(Travel, Weight == '2' | Weight=='3' | Weight=='1' )
nrow(weight) # 109252 rows 
sourceloc <- filter(Travel, SourceLocation == '4' | SourceLocation=='0' | SourceLocation=='1' )
nrow(sourceloc) #171426 travel records
targetloc <- filter(Travel, TargetLocation == '0' | TargetLocation=='4' | TargetLocation=='1' )
nrow(targetloc) #169218 travel records
time <- filter(Travel, Time == '8294400' | Time =='31449600' | Time =='24192000' )

df_1 <- rbind(Target, weight, sourceloc,targetloc,time)
df_1 <- df_1[!duplicated(df_1), ]
nrow(df_1) #272481 travel records
unique(df_1$Source)


# Target 561157:
Target561157 <- filter(df_1, Target == '561157' )
unique(Target561157$SourceLocation)
df_1 %>% filter(Target==561157) 
sourceloc_count_561157 <- count(Target561157, 'SourceLocation')
sourceloc_count_561157 <- sourceloc_count_561157[order(sourceloc_count_561157$freq,decreasing = TRUE),]
head(sourceloc_count_561157) #Sourcelocation "0" and "4" are much higher than others

Target561157_Sloc4 <- filter(Target561157, Target=='561157' & SourceLocation=='4')
person_count_561157_4 <- count(Target561157_Sloc4, 'Source')
person_count_561157_4 <- person_count_561157_4[order(person_count_561157_4$freq,decreasing = TRUE),]
head(person_count_561157_4)

#Plot Template_Travel records 
Target561157_Sloc4<- transform(Target561157_Sloc4, Target_location = as.character(TargetLocation))
Target561157_Sloc4<- transform(Target561157_Sloc4, Source_location = as.character(SourceLocation))
Target561157_Sloc4<- transform(Target561157_Sloc4, Person = as.character(Source))

ggplot(Common_list, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

# Only take the people who have travel more than 3 times from Target 561157 to Location4
main_person_561157 <- filter(person_count_561157_4, freq >= '3')

nodes_common = NULL
for (i in main_person_561157$Source) {
  for (j in Target561157_Sloc4$Source) {
    if(i==j){
      nodes_common <- append(nodes_common,i)
      nodes_common <- unique(nodes_common)
    }
    
  }
  
}



Common_list <- merge(x=Target561157_Sloc4, y=main_person_561157,by="Source")
length(unique(Common_list$Source))
#remove weight = -1
Common_list <- filter(Common_list, Weight != -1) #481 person left
time_count_target561157 <- count(Common_list, "Start_Day")
time_count_target561157<- time_count_target561157[order(time_count_target561157$freq,decreasing = TRUE),]

Time_count_socl4 <- count(Common_list, "Time")
Time_count_socl4<- Time_count_socl4[order(Time_count_socl4$freq,decreasing = TRUE),]
head(time_count_target561157)
travel0 <- filter(Common_list,Start_Day == 143)
nrow(travel0)
travel1 <- filter(Common_list,Start_Day == 126)
nrow(travel1)
travel2 <- filter(Common_list,Start_Day == 257)
nrow(travel2)
travel3 <- filter(Common_list,Start_Day == 137)
nrow(travel3)
travel4 <- filter(Common_list,Start_Day == 227)
nrow(travel4)
travel5<- filter(Common_list,Start_Day == 87)
nrow(travel5)
travel6 <- filter(Common_list,Start_Day == 88)
nrow(travel6)
travel7 <- filter(Common_list,Start_Day == 220)
nrow(travel7)

Travel_freq <- rbind(travel0,travel1,travel2,travel3,travel4,travel5,travel6,travel7)
nrow(Travel_freq)
unique(Travel_freq$Source)

ggplot(Travel_freq, aes(x=Start_Day, y=Person, color=Target_location)) + 
  geom_point(size=3,shape=15) +
  theme_ipsum()

ggplot(Travel) + 
  geom_segment( aes(x=Person, xend=Person, y=Start_Day, yend=End_Day), color="grey") +
  geom_point( aes(x=Person, y=Start_Day), color=rgb(0.2,0.7,0.1,0.5), size = 3) +
  geom_point( aes(x=Person, y=End_Day), color=rgb(0.1,0.1,0.9,0.5), size = 3) +   
  coord_flip()+
  theme_ipsum() +
  theme(
    legend.position = "none",
  )+
  xlab("Person ")
ylab("Travel Data")

Target561157_Sloc0 <- filter(Target561157, Target=='561157' & SourceLocation=='0')
person_count_561157_0 <- count(Target561157_Sloc0, 'Source')
person_count_561157_0<- person_count_561157_4[order(person_count_561157_4$freq,decreasing = TRUE),]
head(person_count_561157_0)

# Only take the people who have travel more than 3 times from Target 561157 to Location0
main_person_561157_0 <- filter(person_count_561157_0, freq >= '3')
length(unique(main_person_561157_0$Source))










