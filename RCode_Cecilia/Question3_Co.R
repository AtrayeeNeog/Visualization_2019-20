getwd()
setwd('~/OVGU/Visualization_Project/MC1/data')
Co_Authorship<- read.csv('eType4.csv')
Temp <- read.csv('CGCS-Template.csv')


library(tidyverse)  # data manipulation
library(cluster)    # clustering algorithms
library(factoextra) # clustering algorithms & visualization
library(ggplot2)
install.packages('igraph')
library(scholar)
library(networkDynamic)
library(ndtv)
library(igraph)
library(intergraph)
library(visNetwork)
library(stringr)

length(unique(Co_Authorship$Source)) #66,173 Person appeared in Co-authorship Channel
length(unique(Co_Authorship$Target)) #33,570 Publications recorded in Co-authorship Channel

Authorship <- subset(Co_Authorship,select = -c(eType,SourceLocation,SourceLatitude,
                                               SourceLongitude,TargetLocation, 
                                               TargetLatitude,TargetLongitude))
New_Author <- scale(Authorship)
head(New_Author)
target_count <- count(Authorship, 'Target')

#Play with the Subgraph_2 and see what could get
Person_563211 <- filter(Authorship, Source == '563211')
Person_541017 <- filter(Authorship, Source == '541017')
Publication_601492 <- filter(Authorship, Target == '601492')
Publication_564798 <- filter(Authorship, Target == '564798')
Publication_561114 <- filter(Authorship, Target == '561114')
Publication_627390 <- filter(Authorship, Target == '627390')
Graph2relatedPublication <- rbind(Publication_601492,Publication_564798,
                   Publication_561114,Publication_627390)

#Plot the co-authorship network
levs <- unique(unlist(Authorship, use.names = FALSE))
adj <- table(lapply(Authorship, factor, levs))
g1 <- graph_from_adjacency_matrix(adj)
plot(g1)





