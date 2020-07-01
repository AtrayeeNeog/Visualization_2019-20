library(tidyverse)
library(plyr)
library(ggplot2)

getwd()
setwd('~/OVGU/Visualization_Project/extractedSeeds')
Seed1 <- read.csv('Seed1-Graph2NonCom.csv')
Seed3 <- read.csv('Seed3-Graph2NonCom.csv')

seed1_2 <- Seed1 %>% filter(Seed1$eType==2)
seed1_3 <- Seed1 %>% filter(Seed1$eType==3)

# Trying to find interesting items which were sold multiple times.
items_sold <- count(seed1_2, c("Source","Target"))
# Trying to find interesting items which were bought multiple times.
items_bought <- count(seed1_3, c("Source","Target"))
# We need items which are sold and bought more than 7 times by the same people.
items_sold <- items_sold %>% filter(items_sold$freq >= 7)
items_bought <- items_bought %>% filter(items_bought$freq >= 7)

## Items which are both sold and bought more than 7 times:
frequent_items<-intersect(items_sold$Target, items_bought$Target)
##547205 469675 461577

max(items_sold$freq) #275
min(items_sold$freq)#7
max(items_bought$freq)#18
min(items_bought$freq) #7
unique(items_sold$Target)
unique(items_bought$Target)

trans <- filter(Seed1, Seed1$Target==547205)
ggplot(trans, aes(x=as.character(Source), y=Time, color = as.character(eType), fill=as.character(eType))) + 
  geom_point(shape=23, size = 5)+theme(axis.text.x=element_text(size=10, angle=90))+labs(title="Source Target Combinations for Big Graph",
                                                                                         x="Source & Target Combination", y = "Time")








