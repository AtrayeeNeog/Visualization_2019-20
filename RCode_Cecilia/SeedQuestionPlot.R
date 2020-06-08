
library(tidyverse)

install.packages("dplyr")
library(igraph)
library(networkD3)
library(network)

library(visNetwork)

getwd()
setwd('~/OVGU/Visualization_Project/graphsExtended')

#get all datasets for the Network Analysis
Seed1_Comm <- read.csv('Seed1-Graph2.csv')
Seed1_Others <- read.csv('Seed1-Graph2NonCom.csv')
Sedd1_CommC = select(Seed1_Comm, -X)
Sedd1_OtherC = select(Seed1_Others, -X)
Seed1_AllC = full_join(Sedd1_CommC,Sedd1_OtherC)

Sources <- Seed1_AllC %>%
  distinct(Source) %>%
  rename(label = Source)

Targets <- Seed1_AllC %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes <- full_join(Sources, Targets, by = "label")
nodes
nodes <- nodes %>% rowid_to_column("id")
nodes

# Creating an Edge List:
per_route_Seed1 <- Seed1_AllC %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route_Seed1

edges_Seed1 <- per_route_Seed1 %>% 
  left_join(nodes, by = c("Source" = "label")) %>% 
  rename(from = id)

edges_Seed1 <- edges_Seed1 %>% 
  left_join(nodes, by = c("Target" = "label")) %>% 
  rename(to = id)

edges_Seed1 <- select(edges_Seed1, from, to, weight)
edges_Seed1


# Creating a Network:
routes_network_Seed1 <- network(edges_Seed1, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)
routes_network_Seed1
class(routes_network_Seed1)

plot(routes_network_Seed1,vertex.cex = 1, main = "Seed1 All Channels")


# Seed3 Network Building:
Seed3_Comm <- read.csv('Seed3-Graph2Com.csv')
Seed3_Others <- read.csv('Seed3-Graph2NonCom.csv')
Sedd3_CommC = select(Seed3_Comm, -X)
Sedd3_OtherC = select(Seed3_Others, -X)
Seed3_AllC = full_join(Sedd3_CommC,Sedd3_OtherC)

Sources_S3 <- Seed3_AllC %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_S3 <- Seed3_AllC %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_S3 <- full_join(Sources_S3, Targets_S3, by = "label")
nodes_S3
nodes_S3 <- nodes_S3 %>% rowid_to_column("id")
nodes_S3

# Creating an Edge List:
per_route_S3 <- Seed3_AllC %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route_S3

edges_S3 <- per_route_S3 %>% 
  left_join(nodes_S3, by = c("Source" = "label")) %>% 
  rename(from = id)

edges_S3 <- edges_S3 %>% 
  left_join(nodes_S3, by = c("Target" = "label")) %>% 
  rename(to = id)

edges_S3 <- select(edges_S3, from, to, weight)
edges_S3

# Creating a Network:
routes_network_S3 <- network(edges_S3, vertex.attr = nodes_S3, matrix.type = "edgelist", ignore.eval = FALSE)
routes_network_S3


# Graph1 Extended Network Building:
Graph1_extend <- read.csv('dfGraph1-extended.csv')
G1_ExtendC = select(Graph1_extend, -X)

Sources_G1 <- G1_ExtendC %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G1 <- G1_ExtendC %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G1 <- full_join(Sources_G1, Targets_G1, by = "label")
nodes_G1
nodes_G1 <- nodes_G1 %>% rowid_to_column("id")
nodes_G1

# Creating an Edge List:
per_route_G1<- G1_ExtendC %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route_G1

edges_G1 <- per_route_G1 %>% 
  left_join(nodes_G1, by = c("Source" = "label")) %>% 
  rename(from = id)

edges_G1 <- edges_G1 %>% 
  left_join(nodes_G1, by = c("Target" = "label")) %>% 
  rename(to = id)

edges_G1 <- select(edges_G1, from, to, weight)
edges_G1

# Creating a Network:
routes_network_G1 <- network(edges_G1, vertex.attr = nodes_G1, matrix.type = "edgelist", ignore.eval = FALSE)
routes_network_G1

plot(routes_network_G1,vertex.cex = 1, main = "Graph1 Extended Network")


# Graph2 Extended Network Building:
Graph2_extend <- read.csv('dfGraph2-extended.csv')
G2_ExtendC = select(Graph2_extend, -X)

Sources_G2 <- G2_ExtendC %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G2 <- G2_ExtendC %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G2 <- full_join(Sources_G2, Targets_G2, by = "label")
nodes_G2
nodes_G2 <- nodes_G2 %>% rowid_to_column("id")
nodes_G2

# Creating an Edge List:
per_route_G2<- G2_ExtendC %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route_G2

edges_G2 <- per_route_G2 %>% 
  left_join(nodes_G2, by = c("Source" = "label")) %>% 
  rename(from = id)

edges_G2 <- edges_G2 %>% 
  left_join(nodes_G2, by = c("Target" = "label")) %>% 
  rename(to = id)

edges_G2 <- select(edges_G2, from, to, weight)
edges_G2

# Creating a Network:
routes_network_G2 <- network(edges_G2, vertex.attr = nodes_G2, matrix.type = "edgelist", ignore.eval = FALSE)
routes_network_G2

plot(routes_network_G2,vertex.cex = 1, main = "Graph2 Extended Network")

# Graph2 Extended Network Building:
Graph3_extend <- read.csv('dfGraph3-extended.csv')
G3_ExtendC = select(Graph3_extend, -X)

Sources_G3 <- G3_ExtendC %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G3 <- G3_ExtendC %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G3 <- full_join(Sources_G3, Targets_G3, by = "label")
nodes_G3
nodes_G3 <- nodes_G3 %>% rowid_to_column("id")
nodes_G3

# Creating an Edge List:
per_route_G3<- G3_ExtendC %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route_G3

edges_G3 <- per_route_G3 %>% 
  left_join(nodes_G3, by = c("Source" = "label")) %>% 
  rename(from = id)

edges_G3 <- edges_G3 %>% 
  left_join(nodes_G3, by = c("Target" = "label")) %>% 
  rename(to = id)

edges_G3 <- select(edges_G3, from, to, weight)
edges_G3

# Creating a Network:
routes_network_G3 <- network(edges_G3, vertex.attr = nodes_G3, matrix.type = "edgelist", ignore.eval = FALSE)
routes_network_G3

plot(routes_network_G3,vertex.cex = 1, main = "Graph3 Extended Network")


# Graph4 Extended Network Building:
Graph4_extend <- read.csv('dfGraph4-extended.csv')
G4_ExtendC = select(Graph4_extend, -X)

Sources_G4 <- G4_ExtendC %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G4 <- G4_ExtendC %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G4 <- full_join(Sources_G4, Targets_G4, by = "label")
nodes_G4
nodes_G4 <- nodes_G4 %>% rowid_to_column("id")
nodes_G4

# Creating an Edge List:
per_route_G4<- G4_ExtendC %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route_G4

edges_G4 <- per_route_G4 %>% 
  left_join(nodes_G4, by = c("Source" = "label")) %>% 
  rename(from = id)

edges_G4 <- edges_G4 %>% 
  left_join(nodes_G4, by = c("Target" = "label")) %>% 
  rename(to = id)

edges_G4 <- select(edges_G4, from, to, weight)
edges_G4

# Creating a Network:
routes_network_G4 <- network(edges_G4, vertex.attr = nodes_G4, matrix.type = "edgelist", ignore.eval = FALSE)
routes_network_G4

plot(routes_network_G4,vertex.cex = 1, main = "Graph4 Extended Network")


# Graph5 Extended Network Building:
Graph5_extend <- read.csv('dfGraph5-extended.csv')
G5_ExtendC = select(Graph5_extend, -X)

Sources_G5 <- G5_ExtendC %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G5 <- G5_ExtendC %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G5 <- full_join(Sources_G5, Targets_G5, by = "label")
nodes_G5
nodes_G5 <- nodes_G5 %>% rowid_to_column("id")
nodes_G5

# Creating an Edge List:
per_route_G5<- G5_ExtendC %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route_G5

edges_G5 <- per_route_G5 %>% 
  left_join(nodes_G5, by = c("Source" = "label")) %>% 
  rename(from = id)

edges_G5 <- edges_G5 %>% 
  left_join(nodes_G5, by = c("Target" = "label")) %>% 
  rename(to = id)

edges_G5 <- select(edges_G5, from, to, weight)
edges_G5

# Creating a Network:
routes_network_G5 <- network(edges_G5, vertex.attr = nodes_G5, matrix.type = "edgelist", ignore.eval = FALSE)
routes_network_G5

plot(routes_network_G5,vertex.cex = 1, main = "Graph5 Extended Network")











