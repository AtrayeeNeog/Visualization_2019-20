library(tidyverse)
library(tidygraph)
library(network)

# Communication Channel:
# For Template:
Sources <- dt01 %>%
  distinct(Source) %>%
  rename(label = Source)

Targets <- dt01 %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes <- full_join(Sources, Targets, by = "label")
nodes
nodes <- nodes %>% rowid_to_column("id")
nodes

# Creating an Edge List:
per_route <- dt01 %>%  
  group_by(Source, Target) %>%
  summarise(weight = n()) %>% 
  ungroup()
per_route

edges <- per_route %>% 
  left_join(nodes, by = c("Source" = "label")) %>% 
  rename(from = id)

edges <- edges %>% 
  left_join(nodes, by = c("Target" = "label")) %>% 
  rename(to = id)

edges <- select(edges, from, to, weight)
edges

# Creating a Network:
routes_network <- network(edges, vertex.attr = nodes, matrix.type = "edgelist", ignore.eval = FALSE)
class(routes_network)
routes_network


# Graph 1:
Sources_G1 <- qt1 %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G1 <- qt1 %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G1 <- full_join(Sources_G1, Targets_G1, by = "label")
nodes_G1
nodes_G1 <- nodes_G1 %>% rowid_to_column("id")
nodes_G1

# Creating an Edge List:
per_route_G1 <- qt1 %>%  
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


# Graph 2:
Sources_G2 <- qt2 %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G2 <- qt2 %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G2 <- full_join(Sources_G2, Targets_G2, by = "label")
nodes_G2
nodes_G2 <- nodes_G2 %>% rowid_to_column("id")
nodes_G2

# Creating an Edge List:
per_route_G2 <- qt2 %>%  
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


# Graph 3:
Sources_G3 <- qt3 %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G3 <- qt3 %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G3 <- full_join(Sources_G3, Targets_G3, by = "label")
nodes_G3
nodes_G3 <- nodes_G3 %>% rowid_to_column("id")
nodes_G3

# Creating an Edge List:
per_route_G3 <- qt3 %>%  
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


# Graph 4:
Sources_G4 <- qt4 %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G4 <- qt4 %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G4 <- full_join(Sources_G4, Targets_G4, by = "label")
nodes_G4
nodes_G4 <- nodes_G4 %>% rowid_to_column("id")
nodes_G4

# Creating an Edge List:
per_route_G4 <- qt4 %>%  
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


# Graph 5:
Sources_G5 <- qt5 %>%
  distinct(Source) %>%
  rename(label = Source)

Targets_G5 <- qt5 %>%
  distinct(Target) %>%
  rename(label = Target)

# Creating a Node List:
nodes_G5 <- full_join(Sources_G5, Targets_G5, by = "label")
nodes_G5
nodes_G5 <- nodes_G5 %>% rowid_to_column("id")
nodes_G5

# Creating an Edge List:
per_route_G5 <- qt5 %>%  
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


par(mfrow = c(3,2))
plot(routes_network, vertex.cex = 3)
plot(routes_network_G1, vertex.cex = 3)
plot(routes_network_G2, vertex.cex = 3)
plot(routes_network_G3, vertex.cex = 3)
plot(routes_network_G4, vertex.cex = 3)
plot(routes_network_G5, vertex.cex = 3)


