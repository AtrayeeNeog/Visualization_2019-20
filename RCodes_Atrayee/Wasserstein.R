library(igraph)
library(here)
library(tidyverse)
library (readr)
library (haven)
library (ggplot2)
library(transport)
library(plyr)


# Load The Data:
dt <- data.table::fread(here::here("data", "CGCS-Template.csv"))
qt1 <- data.table::fread(here::here("data", "Q1-Graph1.csv"))
qt2 <- data.table::fread(here::here("data", "Q1-Graph2.csv"))
qt3 <- data.table::fread(here::here("data", "Q1-Graph3.csv"))
qt4 <- data.table::fread(here::here("data", "Q1-Graph4.csv"))
qt5 <- data.table::fread(here::here("data", "Q1-Graph5.csv"))

dt_network <- subset(dt, select = c(Source, Target, Weight))
qt1_network <- subset(qt1, select = c(Source, Target, Weight))
qt2_network <- subset(qt2, select = c(Source, Target, Weight))
qt3_network <- subset(qt3, select = c(Source, Target, Weight))
qt4_network <- subset(qt4, select = c(Source, Target, Weight))
qt5_network <- subset(qt5, select = c(Source, Target, Weight))

dt_edgelist <- dt_network
dt_graph <- graph.data.frame(dt_edgelist, directed = TRUE)

qt1_edgelist <- qt1_network
qt1_graph <- graph.data.frame(qt1_edgelist, directed = TRUE)

qt2_edgelist <- qt2_network
qt2_graph <- graph.data.frame(qt2_edgelist, directed = TRUE)

qt3_edgelist <- qt3_network
qt3_graph <- graph.data.frame(qt3_edgelist, directed = TRUE)

qt4_edgelist <- qt4_network
qt4_graph <- graph.data.frame(qt4_edgelist, directed = TRUE)

qt5_edgelist <- qt5_network
qt5_graph <- graph.data.frame(qt5_edgelist, directed = TRUE)


dt_graph2<-simplify(dt_graph)
qt1_graph2<-simplify(qt1_graph)
qt2_graph2<-simplify(qt2_graph)
qt3_graph2<-simplify(qt3_graph)
qt4_graph2<-simplify(qt4_graph)
qt5_graph2<-simplify(qt5_graph)

#Authority Scores:
authority_template <- authority_score(dt_graph2)
authority_G1 <- authority_score(qt1_graph2)
authority_G2 <- authority_score(qt2_graph2)
authority_G3 <- authority_score(qt3_graph2)
authority_G4 <- authority_score(qt4_graph2)
authority_G5 <- authority_score(qt5_graph2)

vector_dt <- data.frame(authority_template$vector)
vector_dt$authority_template.vector
vector_G1 <- data.frame(authority_G1$vector)
vector_G2 <- data.frame(authority_G2$vector)
vector_G3 <- data.frame(authority_G3$vector)
vector_G4 <- data.frame(authority_G4$vector)
vector_G5 <- data.frame(authority_G5$vector)

vector_dt$authority_template.vector
vector_G1$authority_G1.vector

ggplot(vector_dt, aes(x=authority_template.vector)) +
  geom_histogram(fill="red", alpha=0.5, position="identity")+labs(title="Histogram for Authority Score for Template")

ggplot(vector_G1, aes(x=authority_G1.vector)) +
  geom_histogram(fill="blue", alpha=0.5, position="identity")+labs(title="Histogram for Authority Score for Template")

ggplot() + 
  geom_histogram(data = vector_dt, aes(x = authority_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vector_G1, aes(x = authority_G1.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph1", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph1", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vector_dt, aes(x = authority_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vector_G2, aes(x = authority_G2.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph2", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph2", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vector_dt, aes(x = authority_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vector_G3, aes(x = authority_G3.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph3", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph3", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vector_dt, aes(x = authority_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vector_G4, aes(x = authority_G4.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph4", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph4", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vector_dt, aes(x = authority_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vector_G5, aes(x = authority_G5.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph5", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph5", "r" = "Template"))



# Hub Scores:
hub_template <- hub_score(dt_graph2)
hub_G1 <- hub_score(qt1_graph2)
hub_G2 <- hub_score(qt2_graph2)
hub_G3 <- hub_score(qt3_graph2)
hub_G4 <- hub_score(qt4_graph2)
hub_G5 <- hub_score(qt5_graph2)

vectorH_dt <- data.frame(hub_template$vector)
vectorH_dt$hub_template.vector
vectorH_G1 <- data.frame(hub_G1$vector)
vectorH_G2 <- data.frame(hub_G2$vector)
vectorH_G3 <- data.frame(hub_G3$vector)
vectorH_G4 <- data.frame(hub_G4$vector)
vectorH_G5 <- data.frame(hub_G5$vector)

vectorH_dt$hub_template.vector
vectorH_G1$hub_G1.vector


ggplot() + 
  geom_histogram(data = vectorH_dt, aes(x = hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vectorH_G1, aes(x = hub_G1.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph1", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph1", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vectorH_dt, aes(x = hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vectorH_G2, aes(x = hub_G2.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph2", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph2", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vectorH_dt, aes(x = hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vectorH_G3, aes(x = hub_G3.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph3", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph3", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vectorH_dt, aes(x = hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vectorH_G4, aes(x = hub_G4.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph4", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph4", "r" = "Template"))
ggplot() + 
  geom_histogram(data = vectorH_dt, aes(x = hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = vectorH_G5, aes(x = hub_G5.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph5", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph5", "r" = "Template"))

# Total Hits:
hits_template <- data.frame(vector_dt$authority_template.vector+vectorH_dt$hub_template.vector)
hits_G1 <- data.frame(vector_G1$authority_G1.vector+vectorH_G1$hub_G1.vector)
hits_G2 <- data.frame(vector_G2$authority_G2.vector+vectorH_G2$hub_G2.vector)
hits_G3 <- data.frame(vector_G3$authority_G3.vector+vectorH_G3$hub_G3.vector)
hits_G4 <- data.frame(vector_G4$authority_G4.vector+vectorH_G4$hub_G4.vector)
hits_G5 <- data.frame(vector_G5$authority_G5.vector+vectorH_G5$hub_G5.vector)

hits_template$vector_dt.authority_template.vector...vectorH_dt.hub_template.vector
hits_G1$vector_G1.authority_G1.vector...vectorH_G1.hub_G1.vector

ggplot() + 
  geom_histogram(data = hits_template, aes(x = vector_dt.authority_template.vector...vectorH_dt.hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = hits_G1, aes(x = vector_G1.authority_G1.vector...vectorH_G1.hub_G1.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph1", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph1", "r" = "Template"))+labs(title="Histogram for Total Hits Score for Template and Graph1")

ggplot() + 
  geom_histogram(data = hits_template, aes(x = vector_dt.authority_template.vector...vectorH_dt.hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = hits_G2, aes(x = vector_G2.authority_G2.vector...vectorH_G2.hub_G2.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph2", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph2", "r" = "Template"))+labs(title="Histogram for Total Hits Score for Template and Graph2")

ggplot() + 
  geom_histogram(data = hits_template, aes(x = vector_dt.authority_template.vector...vectorH_dt.hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = hits_G3, aes(x = vector_G3.authority_G3.vector...vectorH_G3.hub_G3.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph3", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph3", "r" = "Template"))

ggplot() + 
  geom_histogram(data = hits_template, aes(x = vector_dt.authority_template.vector...vectorH_dt.hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = hits_G4, aes(x = vector_G4.authority_G4.vector...vectorH_G4.hub_G4.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph4", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph4", "r" = "Template"))

ggplot() + 
  geom_histogram(data = hits_template, aes(x = vector_dt.authority_template.vector...vectorH_dt.hub_template.vector, fill = "r"), alpha = 0.5) +
  geom_histogram(data = hits_G5, aes(x = vector_G5.authority_G5.vector...vectorH_G5.hub_G5.vector, fill = "b"), alpha = 0.5) +
  scale_colour_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph5", "r" = "Template")) +
  scale_fill_manual(name ="vector", values = c("r" = "red", "b" = "blue"), labels=c("b" = "Graph5", "r" = "Template"))


# Wasserstein method:
# Template: 
# Combine all nodes together:
dtS_nodes <- data.frame(dt_network$Source)
colnames(dtS_nodes)[colnames(dtS_nodes) == 'dt_network.Source'] <- 'Node'
head(dtS_nodes)
dtT_nodes <- data.frame(dt_network$Target)
colnames(dtT_nodes)[colnames(dtT_nodes) == 'dt_network.Target'] <- 'Node'
head(dtT_nodes)
dt_nodes<- rbind(dtS_nodes, dtT_nodes)
# Find the frequency of occurrence of each node:
dt_count <- count(dt_nodes, "Node")
head(dt_count)

# Graph1:
G1S_nodes <- data.frame(qt1_network$Source)
colnames(G1S_nodes)[colnames(G1S_nodes) == 'qt1_network.Source'] <- 'Node'
head(G1S_nodes)
G1T_nodes <- data.frame(qt1_network$Target)
colnames(G1T_nodes)[colnames(G1T_nodes) == 'qt1_network.Target'] <- 'Node'
head(G1T_nodes)
G1_nodes<- rbind(G1S_nodes, G1T_nodes)
# Find the frequency of occurrence of each node:
G1_count <- count(G1_nodes, "Node")
head(G1_count)

# Graph2:
G2S_nodes <- data.frame(qt2_network$Source)
colnames(G2S_nodes)[colnames(G2S_nodes) == 'qt2_network.Source'] <- 'Node'
head(G2S_nodes)
G2T_nodes <- data.frame(qt2_network$Target)
colnames(G2T_nodes)[colnames(G2T_nodes) == 'qt2_network.Target'] <- 'Node'
head(G2T_nodes)
G2_nodes<- rbind(G2S_nodes, G2T_nodes)
# Find the frequency of occurrence of each node:
G2_count <- count(G2_nodes, "Node")
head(G2_count)

# Graph3:
G3S_nodes <- data.frame(qt3_network$Source)
colnames(G3S_nodes)[colnames(G3S_nodes) == 'qt3_network.Source'] <- 'Node'
head(G3S_nodes)
G3T_nodes <- data.frame(qt3_network$Target)
colnames(G3T_nodes)[colnames(G3T_nodes) == 'qt3_network.Target'] <- 'Node'
head(G3T_nodes)
G3_nodes<- rbind(G3S_nodes, G3T_nodes)
# Find the frequency of occurrence of each node:
G3_count <- count(G3_nodes, "Node")
head(G3_count)

# # Graph4:
G4S_nodes <- data.frame(qt4_network$Source)
colnames(G4S_nodes)[colnames(G4S_nodes) == 'qt4_network.Source'] <- 'Node'
head(G4S_nodes)
G4T_nodes <- data.frame(qt4_network$Target)
colnames(G4T_nodes)[colnames(G4T_nodes) == 'qt4_network.Target'] <- 'Node'
head(G4T_nodes)
G4_nodes<- rbind(G4S_nodes, G4T_nodes)
# Find the frequency of occurrence of each node:
G4_count <- count(G4_nodes, "Node")
head(G4_count)

# # Graph5:
G5S_nodes <- data.frame(qt5_network$Source)
colnames(G5S_nodes)[colnames(G5S_nodes) == 'qt5_network.Source'] <- 'Node'
head(G5S_nodes)
G5T_nodes <- data.frame(qt5_network$Target)
colnames(G5T_nodes)[colnames(G5T_nodes) == 'qt5_network.Target'] <- 'Node'
head(G5T_nodes)
G5_nodes<- rbind(G5S_nodes, G5T_nodes)
# Find the frequency of occurrence of each node:
G5_count <- count(G5_nodes, "Node")
head(G5_count)


dt_pgrid <- pgrid(as.matrix(dt_count))
G1_pgrid <- pgrid(as.matrix(G1_count))
G2_pgrid <- pgrid(as.matrix(G2_count))
G3_pgrid <- pgrid(as.matrix(G3_count))
G4_pgrid <- pgrid(as.matrix(G4_count))
G5_pgrid <- pgrid(as.matrix(G5_count))

dt_pgrid
G1_pgrid
G2_pgrid
G3_pgrid
G4_pgrid
G5_pgrid

unique(dt_count$Node)
unique(G1_count$Node)
unique(G2_count$Node)
unique(G3_count$Node)
unique(G4_count$Node)
unique(G5_count$Node)

