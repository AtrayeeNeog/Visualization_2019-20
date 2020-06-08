library(tidyverse)
getwd()
setwd('~/OVGU/Visualization_Project/MC1/data')

Travel_Channel <- read.csv('eType6.csv')
# Drop out the duplicated rows
Travel_Channel_dedupted <- Travel_Channel[!duplicated(Travel_Channel), ]

#Check the location nodes value
unique(Travel_Channel_dedupted$Target) 
# 6 values: 657173 509607 625756 616453 561157 499467

#slipt the data by different Target location
Target499467 <- filter(Travel_Channel_dedupted, Target == "499467")
Target509607 <- filter(Travel_Channel_dedupted, Target == "509607")
Target561157 <- filter(Travel_Channel_dedupted, Target == "561157")
Target616453 <- filter(Travel_Channel_dedupted, Target == "616453")
Target625756 <- filter(Travel_Channel_dedupted, Target == "625756")
Target657173 <- filter(Travel_Channel_dedupted, Target == "657173")

unique(Travel_Channel_dedupted$SourceLocation)
Slocation0 <- filter(Travel_Channel_dedupted, SourceLocation == "0")
Slocation1 <- filter(Travel_Channel_dedupted, SourceLocation == "1")
Slocation2 <- filter(Travel_Channel_dedupted, SourceLocation == "2")
Slocation3 <- filter(Travel_Channel_dedupted, SourceLocation == "3")
Slocation4 <- filter(Travel_Channel_dedupted, SourceLocation == "4")
Slocation5 <- filter(Travel_Channel_dedupted, SourceLocation == "5")

#Check the Source Latitude and Longitude
unique(Slocation0$SourceLatitude) #33
unique(Slocation0$SourceLongitude) #-41
length(Slocation0$SourceLatitude) #59544
length(Slocation0$SourceLongitude) #59544

unique(Slocation1$SourceLatitude) #-29
unique(Slocation1$SourceLongitude) #-13
length(Slocation1$SourceLatitude) #44638
length(Slocation1$SourceLongitude) #44638

unique(Slocation2$SourceLatitude) #-22
unique(Slocation2$SourceLongitude) #91
length(Slocation2$SourceLatitude) #43600
length(Slocation2$SourceLongitude) #43600

unique(Slocation3$SourceLatitude) #-25
unique(Slocation3$SourceLongitude) #-111
length(Slocation3$SourceLatitude) #41128
length(Slocation3$SourceLongitude) #41128

unique(Slocation4$SourceLatitude) #1
unique(Slocation4$SourceLongitude) #-165
length(Slocation4$SourceLatitude) #67244
length(Slocation4$SourceLongitude) #67244

unique(Slocation5$SourceLatitude) #22
unique(Slocation5$SourceLongitude) #156
length(Slocation5$SourceLatitude) #42327
length(Slocation5$SourceLongitude) #42327

range(Travel_Channel_dedupted$Time) #86400--31536000 According to Data
#Description: it means from 12am 02.01.2025 to 12am 01.01.2026









