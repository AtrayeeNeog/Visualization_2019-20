library(igraph)
library(here)
library(tidyverse)
library (readr)
library (haven)
library (ggplot2)

# Load The Data:
dt <- data.table::fread(here::here("data", "CGCS-Template.csv"))
qt1 <- data.table::fread(here::here("data", "Q1-Graph1.csv"))
head(dt)
tail(dt)

# Summarising the Data:
summary(dt)
nrow(dt)
ncol(dt)

dt_network <- subset(dt, select = c(Source, Target, Weight))
qt1_network <- subset(qt1, select = c(Source, Target, Weight))

dt_edgelist <- dt_network
dt_graph <- graph.data.frame(dt_edgelist, directed = TRUE)

qt1_edgelist <- qt1_network
qt1_graph <- graph.data.frame(qt1_edgelist, directed = TRUE)

#Visualisations:


#Template Network:

#Removing Self-Loops (Repondents Nominating Themselves)
dt_graph2<-simplify(dt_graph, remove.multiple=TRUE, remove.loops=TRUE)

#Import the sample_attributes
Template_Attributes=data.table::fread(here::here("data", "CGCS-Template-NodeTypes.csv"))

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2, niter=5000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(dt_graph2)$color <- "grey"
V(dt_graph2)[degree(dt_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(dt_graph2)$size=degree(dt_graph, mode = "in")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph2), 2] == 1, "blue", 
                             ifelse(Template_Attributes[V(dt_graph2), 2] == 4, "red",
                                    ifelse(Template_Attributes[V(dt_graph2), 2] == 5, "green", "orange")))

#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

# Graph1 Network:

#Removing Self-Loops (Repondents Nominating Themselves)
qt1_graph2<-simplify(qt1_graph, remove.multiple=TRUE, remove.loops=TRUE)

#Import the sample_attributes
Graph1_Attributes=data.table::fread(here::here("data", "CGCS-GraphData-NodeTypes.csv"))

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt1_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt1_graph2)$color <- "grey"
V(qt1_graph2)[degree(qt1_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt1_graph2)$size=degree(qt1_graph, mode = "in")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt1_graph2)$color <- ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

# Graph1 Network: Kamadi Kawai

#Removing Self-Loops (Repondents Nominating Themselves)
qt1_graph2<-simplify(qt1_graph, remove.multiple=TRUE, remove.loops=TRUE)

#Import the sample_attributes
Graph1_Attributes=data.table::fread(here::here("data", "CGCS-GraphData-NodeTypes.csv"))

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout_with_kk(qt1_graph2) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt1_graph2)$color <- "grey"
V(qt1_graph2)[degree(qt1_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt1_graph2)$size=degree(qt1_graph, mode = "in")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt1_graph2)$color <- ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 1, "blue", 
                              ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 4, "red",
                                     ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


#CONNECTIVITY ANALYSIS:

#Density
graph.density(qt1_graph2,loop=FALSE) #0.1144226
graph.density(dt_graph2, loop=FALSE) #0.1121996

#Average Path Length
mean_distance(qt1_graph2) #2.083075
mean_distance(dt_graph2) #1.874689

#Degree Distribution
degree_distribution(qt1_graph2)
Graph1_DegreeDis <- degree_distribution(qt1_graph2)   #Turns this into a data object we can export

Graph1_DegreeDis2 <- as.data.frame(Graph1_DegreeDis)

degree_distribution(dt_graph2)
Template_DegreeDis <- degree_distribution(dt_graph2)   #Turns this into a data object we can export

Template_DegreeDis2 <- as.data.frame(Template_DegreeDis)

qplot(Graph1_DegreeDis, data=Graph1_DegreeDis2, geom="histogram", binwidth=.001)
qplot(Template_DegreeDis, data=Template_DegreeDis2, geom="histogram", binwidth=.001)

#Clustering Coefficeint 
transitivity(qt1_graph2) #0.1130306
transitivity(dt_graph2) #0.1685912   # Template graph more bunchier than Graph 1

#POSITION ANALYSIS

#Degree: In, Out, All Centrality
Graph1_OutDegree <- degree(qt1_graph2, mode = "out")
Graph1_OutDegree <- as.data.frame(Graph1_OutDegree) #Highest number of links: 44


degree(qt1_graph2, mode = "in")
Graph1_InDegree <- degree(qt1_graph2, mode = "in")
Graph1_InDegree <- as.data.frame(Graph1_InDegree) #Highest number of links: 44

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt1_graph2,niter=500)
#Node or Vetex Options: Size and Color
V(qt1_graph2)$size=degree(Graph1_Graph, mode = "all")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(qt1_graph2)$color <- ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 1, "blue", 
                              ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 4, "red",
                                     ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

#Degree: In, Out, All Centrality
Template_OutDegree <- degree(dt_graph2, mode = "out")
Template_OutDegree <- as.data.frame(Template_OutDegree) #Highest number of links: 36


degree(dt_graph2, mode = "in")
Template_InDegree <- degree(dt_graph2, mode = "in")
Template_InDegree <- as.data.frame(Template_InDegree) #Highest number of links: 36


#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2,niter=500)
#Node or Vetex Options: Size and Color
V(dt_graph2)$size=degree(Template_Graph, mode = "all")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph2), 2] == 1, "blue", 
                              ifelse(Template_Attributes[V(dt_graph2), 2] == 4, "red",
                                     ifelse(Template_Attributes[V(dt_graph2), 2] == 5, "green", "orange")))

#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

## Interestingly the number of in-links is equal to the number of out-links for both Template and Graph 1.

#Closeness Centrality:

Graph1_Closeness <- closeness(qt1_graph2, mode="all")
Graph1_Closeness <- as.data.frame(Graph1_Closeness) # Range:0.002197802-0.006369427

Template_Closeness <- closeness(dt_graph2, mode = "all")
Template_Closeness <- as.data.frame(Template_Closeness) # Range: 0.002949853-0.007042254

# Not much variatio; Probably not an important measure.

#Betweeness Centrality
Graph1_Betweeness <- betweenness(qt1_graph2)
Graph1_Betweeness <- as.data.frame(Graph1_Betweeness) # Range: 0.00 - 1021.3388889

Template_Betweeness <- betweenness(dt_graph2)
Template_Betweeness <- as.data.frame(Template_Betweeness) # Range: 0.00 - 690.9019841

## Lots of variation in the range, can be an interesting measure. Hence the Visualisation:

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt1_graph2,niter=500)
#Node or Vetex Options: Size and Color
V(qt1_graph2)$size=betweenness(Graph1_Graph, mode = "all")/200 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(qt1_graph2)$color <- ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 1, "blue", 
                              ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 4, "red",
                                     ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 5, "green", "orange")))
#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2,niter=500)
#Node or Vetex Options: Size and Color
V(dt_graph2)$size=betweenness(Template_Graph, mode = "all")/200 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph2), 2] == 1, "blue", 
                              ifelse(Template_Attributes[V(dt_graph2), 2] == 4, "red",
                                     ifelse(Template_Attributes[V(dt_graph2), 2] == 5, "green", "orange")))
#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

#Eigen Vector Centrality

eigen_centrality(qt1_graph2)
Graph1_EigenCentrality <- eigen_centrality(qt1_graph2)

Graph1_EigenCentrality <- as.data.frame(Graph1_EigenCentrality) # Range: 2.790809e-05 - 1.000000e+00

Template_EigenCentrality <- eigen_centrality(dt_graph2)

Template_EigenCentrality <- as.data.frame(Template_EigenCentrality) # Range: 0.001191586 - 1.000000000


#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt1_graph2,niter=500)
#Node or Vetex Options: Size and Color
V(qt1_graph2)$size=eigen_centrality(Graph1_Graph, mode = "all")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(qt1_graph2)$color <- ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 1, "blue", 
                              ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 4, "red",
                                     ifelse(Graph1_Attributes[V(qt1_graph2), 2] == 5, "green", "orange")))
#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2,niter=500)
#Node or Vetex Options: Size and Color
V(dt_graph2)$size=eigen_centrality(Template_Graph, mode = "all")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.
V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph2), 2] == 1, "blue", 
                             ifelse(Template_Attributes[V(dt_graph2), 2] == 4, "red",
                                    ifelse(template_Attributes[V(dt_graph2), 2] == 5, "green", "orange")))
#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


# Segue to Advanced Network Visualization Techniques #

#Community Detection Algorithms in iGraph: Approaches Supported by iGraph
#Detecting communitities by iteratively calculating edge betweeness (e.g., Girvan & Newman 2001)
#Detecting communities by using eigenvector matrices (e.g., Newman 2006)
#Detecting communities by iteratively optimizing for modularity (e.g., Blondel, Guillaume, Lambiotte, & Lefebvre 2008)
#Detecting communities using random walk methods (e.g, Pons & Latapy 2005; Reichardt & Bornholdt 2006)
#Detecting communities using label propogation techniques (e.g., Ragavan, Albert, & Kumara 2007)

#Edge-Betweeness: Girvan-Newman (2001)

GNC_graph1 <- cluster_edge_betweenness(qt1_graph2, weights = NULL)
V(qt1_graph2)$color <-membership(GNC_graph1)              #Plot setting specifying the coloring of vertices by community
qt1_graph2$palette <- diverging_pal(length(GNC_graph1))   #Plot setting specifying the color pallette I am using (iGraph supports 3)
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

GNC_template <- cluster_edge_betweenness(dt_graph2, weights = NULL)
V(dt_graph2)$color <-membership(GNC_template)              #Plot setting specifying the coloring of vertices by community
dt_graph2$palette <- diverging_pal(length(GNC_template))   #Plot setting specifying the color pallette I am using (iGraph supports 3)
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

