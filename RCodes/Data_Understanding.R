getwd()
setwd('~/OVGU/Visualization_Project/MC1/data')
subgraph_1 <- read.csv('Q1-Graph1.csv')
head(subgraph_1)
tail(subgraph_1)
str(subgraph_1)
nrow(subgraph_1)
subset(subgraph_1,Time == 31536000)

Communication <- subgraph_1[ which(subgraph_1$eType == '0' | subgraph_1$eType == '1'),]
Procurement <- subgraph_1[which(subgraph_1$eType == '2' | subgraph_1$eType == '3'),]
Co_authorship <- subgraph_1[which(subgraph_1$eType == '4'),]
Demographics <- subgraph_1[which(subgraph_1$eType == '5'),]
Travel <- subgraph_1[which(subgraph_1$eType == '6'),]
Category <- read.csv('DemographicCategories.csv')
joined_Demograohics <- merge(Demographics, Category, by.x = "Target", by.y = "NodeID", all.x = TRUE, all.y = FALSE)

