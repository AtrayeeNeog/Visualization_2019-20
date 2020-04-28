library(visNetwork)
library(networkD3)


# Communication Channel:
# Weighted edges:
edges <- mutate(edges, width = weight/5 + 1)
edges_G1 <- mutate(edges_G1, width = weight/5 + 1)
edges_G2 <- mutate(edges_G2, width = weight/5 + 1)
edges_G3 <- mutate(edges_G3, width = weight/5 + 1)
edges_G4 <- mutate(edges_G4, width = weight/5 + 1)
edges_G5 <- mutate(edges_G5, width = weight/5 + 1)


# Interactive Graphs with visNetwork:
temp_com <- visNetwork(nodes, edges)%>% visIgraphLayout(layout = "layout_with_fr") %>% visEdges(arrows = "middle")
visPhysics(temp_com, stabilization = FALSE, enabled = FALSE)
g1_com <- visNetwork(nodes_G1, edges_G1)%>% visIgraphLayout(layout = "layout_with_fr") %>% visEdges(arrows = "middle")
visPhysics(g1_com, stabilization = FALSE, enabled = FALSE)
g2_com <- visNetwork(nodes_G2, edges_G2)%>% visIgraphLayout(layout = "layout_with_fr") %>% visEdges(arrows = "middle")
visPhysics(g2_com, stabilization = FALSE, enabled = FALSE)
g3_com <- visNetwork(nodes_G3, edges_G3)%>% visIgraphLayout(layout = "layout_with_fr") %>% visEdges(arrows = "middle")
visPhysics(g3_com, stabilization = FALSE, enabled = FALSE)
g4_com <- visNetwork(nodes_G4, edges_G4)%>% visIgraphLayout(layout = "layout_with_fr") %>% visEdges(arrows = "middle")
visPhysics(g4_com, stabilization = FALSE, enabled = FALSE)
g5_com <- visNetwork(nodes_G5, edges_G5)%>% visIgraphLayout(layout = "layout_with_fr") %>% visEdges(arrows = "middle")
visPhysics(g5_com, stabilization = FALSE, enabled = FALSE)

# Network D3:
nodes_d3 <- mutate(nodes, id = id - 1)
edges_d3 <- mutate(edges, from = from - 1, to = to - 1)
forceNetwork(Links = edges_d3, Nodes = nodes_d3, Source = "from", Target = "to", 
             NodeID = "label", Group = "id", Value = "weight", 
             opacity = 1, fontSize = 16, zoom = TRUE)
nodes_d3_g1 <- mutate(nodes_G1, id = id - 1)
edges_d3_g1 <- mutate(edges_G1, from = from - 1, to = to - 1)
forceNetwork(Links = edges_d3_g1, Nodes = nodes_d3_g1, Source = "from", Target = "to", 
             NodeID = "label", Group = "id", Value = "weight", 
             opacity = 1, fontSize = 16, zoom = TRUE)
nodes_d3_g2 <- mutate(nodes_G2, id = id - 1)
edges_d3_g2 <- mutate(edges_G2, from = from - 1, to = to - 1)
forceNetwork(Links = edges_d3_g2, Nodes = nodes_d3_g2, Source = "from", Target = "to", 
             NodeID = "label", Group = "id", Value = "weight", 
             opacity = 1, fontSize = 16, zoom = TRUE)
nodes_d3_g3 <- mutate(nodes_G3, id = id - 1)
edges_d3_g3 <- mutate(edges_G3, from = from - 1, to = to - 1)
forceNetwork(Links = edges_d3_g3, Nodes = nodes_d3_g3, Source = "from", Target = "to", 
             NodeID = "label", Group = "id", Value = "weight", 
             opacity = 1, fontSize = 16, zoom = TRUE)
nodes_d3_g4 <- mutate(nodes_G4, id = id - 1)
edges_d3_g4 <- mutate(edges_G4, from = from - 1, to = to - 1)
forceNetwork(Links = edges_d3_g4, Nodes = nodes_d3_g4, Source = "from", Target = "to", 
             NodeID = "label", Group = "id", Value = "weight", 
             opacity = 1, fontSize = 16, zoom = TRUE)
nodes_d3_g5 <- mutate(nodes_G5, id = id - 1)
edges_d3_g5 <- mutate(edges_G5, from = from - 1, to = to - 1)
forceNetwork(Links = edges_d3_g5, Nodes = nodes_d3_g5, Source = "from", Target = "to", 
             NodeID = "label", Group = "id", Value = "weight", 
             opacity = 1, fontSize = 16, zoom = TRUE)






