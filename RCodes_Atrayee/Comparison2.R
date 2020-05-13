library(igraph)
library(here)
library(tidyverse)
library (readr)
library (haven)
library (ggplot2)

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
########################################
# TEMPLATE ANALYSIS #
########################################

#Removing Self-Loops (Repondents Nominating Themselves)
dt_graph2 <- simplify(dt_graph)

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

V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph), 2] == 1, "blue", 
                             ifelse(Template_Attributes[V(dt_graph), 2] == 4, "red",
                                    ifelse(Template_Attributes[V(dt_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


#Import the sample_attributes
Graph_Attributes=data.table::fread(here::here("data", "CGCS-GraphData-NodeTypes.csv"))

########################################
# GRAPH 1 ANALYSIS #
########################################

#Removing Self-Loops (Repondents Nominating Themselves)
qt1_graph2 <- simplify(qt1_graph)

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

V(qt1_graph2)$color <- ifelse(Graph_Attributes[V(qt1_graph), 2] == 1, "blue", 
                              ifelse(Graph1_Attributes[V(qt1_graph), 2] == 4, "red",
                                     ifelse(Graph1_Attributes[V(qt1_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 2 ANALYSIS #
########################################

#Removing Self-Loops (Repondents Nominating Themselves)
qt2_graph2 <- simplify(qt2_graph)

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt2_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt2_graph2)$color <- "grey"
V(qt2_graph2)[degree(qt2_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt2_graph2)$size=degree(qt2_graph, mode = "in")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt2_graph2)$color <- ifelse(Graph_Attributes[V(qt2_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt2_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt2_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt2_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt2_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 3 ANALYSIS #
########################################

qt3_graph2 <- simplify(qt3_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt3_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt3_graph2)$color <- "grey"
V(qt3_graph2)[degree(qt3_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt3_graph2)$size=degree(qt3_graph, mode = "in")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt3_graph2)$color <- ifelse(Graph_Attributes[V(qt3_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt3_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt3_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt3_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt3_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 4 ANALYSIS #
########################################

qt4_graph2 <- simplify(qt4_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt4_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt4_graph2)$color <- "grey"
V(qt4_graph2)[degree(qt4_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt4_graph2)$size=degree(qt4_graph, mode = "in")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt4_graph2)$color <- ifelse(Graph_Attributes[V(qt4_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt4_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt4_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt4_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt4_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


########################################
# GRAPH 5 ANALYSIS #
########################################

qt5_graph2 <- simplify(qt5_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt5_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt5_graph2)$color <- "grey"
V(qt5_graph2)[degree(qt5_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt5_graph2)$size=degree(qt5_graph, mode = "in")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt5_graph2)$color <- ifelse(Graph_Attributes[V(qt5_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt5_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt5_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt5_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt5_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# CONNECTIVITY ANALYSIS #
########################################

#Density
graph.density(dt_graph2, loop=FALSE) #0.1730669
graph.density(qt1_graph2,loop=FALSE) #0.1421225
graph.density(qt2_graph2,loop=FALSE) #0.1737503
graph.density(qt3_graph2,loop=FALSE) #0.1183057
graph.density(qt4_graph2,loop=FALSE) #0.0978348
graph.density(qt5_graph2,loop=FALSE) #0.05403557

# Decreasing order of similarity with Template: Graph2 > Graph1 > Graph3 > Graph4 > Graph5

#Average Path Length
mean_distance(dt_graph2) #1.874689
mean_distance(qt1_graph2) #2.083075
mean_distance(qt2_graph2) #2.085761
mean_distance(qt3_graph2) #2.026447
mean_distance(qt4_graph2) #2.429907
mean_distance(qt5_graph2) #2.283071

# Decreasing order of similarity with Template: Graph3 > Graph1 ~ Graph2 > Graph5 > Graph4

#Degree Distribution
Graph1_DegreeDis <- degree_distribution(qt1_graph)   #Turns this into a data object we can export
Graph1_DegreeDis <- as.data.frame(Graph1_DegreeDis)

Graph2_DegreeDis <- degree_distribution(qt2_graph)   #Turns this into a data object we can export
Graph2_DegreeDis <- as.data.frame(Graph2_DegreeDis)

Graph3_DegreeDis <- degree_distribution(qt3_graph)   #Turns this into a data object we can export
Graph3_DegreeDis <- as.data.frame(Graph3_DegreeDis)

Graph4_DegreeDis <- degree_distribution(qt4_graph)   #Turns this into a data object we can export
Graph4_DegreeDis <- as.data.frame(Graph4_DegreeDis)

Graph5_DegreeDis <- degree_distribution(qt5_graph)   #Turns this into a data object we can export
Graph5_DegreeDis <- as.data.frame(Graph5_DegreeDis)

Template_DegreeDis <- degree_distribution(dt_graph)   #Turns this into a data object we can export
Template_DegreeDis <- as.data.frame(Template_DegreeDis)

qplot(Template_DegreeDis, data=Template_DegreeDis, geom="histogram")
qplot(Graph1_DegreeDis, data=Graph1_DegreeDis, geom="histogram")
qplot(Graph2_DegreeDis, data=Graph2_DegreeDis, geom="histogram")
qplot(Graph3_DegreeDis, data=Graph3_DegreeDis, geom="histogram")
qplot(Graph4_DegreeDis, data=Graph4_DegreeDis, geom="histogram")
qplot(Graph5_DegreeDis, data=Graph5_DegreeDis, geom="histogram")

# Decreasing order of similarity with Template: Graph2 > Graph1 > Graph3 > Graph4 > Graph5

#Clustering Coefficeint
transitivity(dt_graph) #0.1685912   
transitivity(qt1_graph) #0.1130306 #0.055
transitivity(qt2_graph) #0.1238481 #0.045
transitivity(qt3_graph) #0.1151288 #0.053
transitivity(qt4_graph) #0.2228648 #-0.054
transitivity(qt5_graph) #0.217119 #-0.049

# Template graph more bunchier than Graph 1, 2 and 3
# Graph 4, 5 more bunchier than Template
# Decreasing order of similarity with Template: Graph2 > Graph3 > Graph1 ~ Graph4 > Graph5

########################################
# POSITION ANALYSIS #
########################################

# 1. Degree: In, Out, All Centrality
Graph1_OutDegree <- degree(qt1_graph2, mode = "out")
Graph1_OutDegree <- as.data.frame(Graph1_OutDegree) #Range:0-77
Graph1_InDegree <- degree(qt1_graph2, mode = "in")
Graph1_InDegree <- as.data.frame(Graph1_InDegree) #Range: 0-64
Graph1_AllDegree <- degree(qt1_graph2, mode = "all")
Graph1_AllDegree <- as.data.frame(Graph1_AllDegree)#Range: 1-135

Graph2_OutDegree <- degree(qt2_graph2, mode = "out")
Graph2_OutDegree <- as.data.frame(Graph2_OutDegree) #Range:0-96
Graph2_InDegree <- degree(qt2_graph2, mode = "in")
Graph2_InDegree <- as.data.frame(Graph2_InDegree) #Range: 0-96
Graph2_AllDegree <- degree(qt2_graph2, mode = "all")
Graph2_AllDegree <- as.data.frame(Graph2_AllDegree)#Range: 1-192

Graph3_OutDegree <- degree(qt3_graph2, mode = "out")
Graph3_OutDegree <- as.data.frame(Graph3_OutDegree) #Range:0-50
Graph3_InDegree <- degree(qt3_graph2, mode = "in")
Graph3_InDegree <- as.data.frame(Graph3_InDegree) #Range: 0-36
Graph3_AllDegree <- degree(qt3_graph2, mode = "all")
Graph3_AllDegree <- as.data.frame(Graph3_AllDegree)#Range: 1-68

Graph4_OutDegree <- degree(qt4_graph2, mode = "out")
Graph4_OutDegree <- as.data.frame(Graph4_OutDegree) #Range:0-59
Graph4_InDegree <- degree(qt4_graph2, mode = "in")
Graph4_InDegree <- as.data.frame(Graph4_InDegree) #Range: 0-35
Graph4_AllDegree <- degree(qt4_graph2, mode = "all")
Graph4_AllDegree <- as.data.frame(Graph4_AllDegree)#Range: 1-64

Graph5_OutDegree <- degree(qt5_graph2, mode = "out")
Graph5_OutDegree <- as.data.frame(Graph5_OutDegree) #Range:0-67
Graph5_InDegree <- degree(qt5_graph2, mode = "in")
Graph5_InDegree <- as.data.frame(Graph5_InDegree) #Range: 0-30
Graph5_AllDegree <- degree(qt5_graph2, mode = "all")
Graph5_AllDegree <- as.data.frame(Graph5_AllDegree)#Range: 1-72

Template_OutDegree <- degree(dt_graph2, mode = "out")
Template_OutDegree <- as.data.frame(Template_OutDegree) #Range: 0-136
Template_InDegree <- degree(dt_graph2, mode = "in")
Template_InDegree <- as.data.frame(Template_InDegree) #Range: 0-72
Template_AllDegree <- degree(dt_graph2, mode = "all")
Template_AllDegree <- as.data.frame(Template_AllDegree)#Range: 1-208

# Decreasing order of similarity with Template (wrt All Nodes): Graph2 > Graph1 > Graph3~Graph4~Graph5

########################################
# TEMPLATE ANALYSIS #
########################################

#Removing Self-Loops (Repondents Nominating Themselves)
dt_graph2 <- simplify(dt_graph)

#Import the sample_attributes
Template_Attributes=data.table::fread(here::here("data", "CGCS-Template-NodeTypes.csv"))

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2, niter=5000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(dt_graph2)$color <- "grey"
V(dt_graph2)[degree(dt_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(dt_graph2)$size=degree(dt_graph, mode = "all")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph), 2] == 1, "blue", 
                            ifelse(Template_Attributes[V(dt_graph), 2] == 4, "red",
                                   ifelse(Template_Attributes[V(dt_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


#Import the sample_attributes
Graph_Attributes=data.table::fread(here::here("data", "CGCS-GraphData-NodeTypes.csv"))

########################################
# GRAPH 1 ANALYSIS #
########################################

qt1_graph2 <- simplify(qt1_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt1_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt1_graph2)$color <- "grey"
V(qt1_graph2)[degree(qt1_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt1_graph2)$size=degree(qt1_graph, mode = "all")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt1_graph2)$color <- ifelse(Graph_Attributes[V(qt1_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt1_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt1_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 2 ANALYSIS #
########################################

qt2_graph2 <- simplify(qt2_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt2_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt2_graph2)$color <- "grey"
V(qt2_graph2)[degree(qt2_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt2_graph2)$size=degree(qt2_graph, mode = "all")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt2_graph2)$color <- ifelse(Graph_Attributes[V(qt2_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt2_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt2_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt2_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt2_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 3 ANALYSIS #
########################################
qt3_graph2 <- simplify(qt3_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt3_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt3_graph2)$color <- "grey"
V(qt3_graph2)[degree(qt3_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt3_graph2)$size=degree(qt3_graph, mode = "all")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt3_graph2)$color <- ifelse(Graph_Attributes[V(qt3_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt3_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt3_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt3_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt3_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 4 ANALYSIS #
########################################

qt4_graph2 <- simplify(qt4_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt4_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt4_graph2)$color <- "grey"
V(qt4_graph2)[degree(qt4_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt4_graph2)$size=degree(qt4_graph, mode = "all")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt4_graph2)$color <- ifelse(Graph_Attributes[V(qt4_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt4_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt4_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt4_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt4_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


########################################
# GRAPH 5 ANALYSIS #
########################################

qt5_graph2 <- simplify(qt5_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt5_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt5_graph2)$color <- "grey"
V(qt5_graph2)[degree(qt5_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt5_graph2)$size=degree(qt5_graph, mode = "all")/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt5_graph2)$color <- ifelse(Graph_Attributes[V(qt5_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt5_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt5_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt5_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt5_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

# 2.Closeness Centrality:

Template_Closeness <- closeness(dt_graph, mode = "all")
Template_Closeness <- as.data.frame(Template_Closeness) # Range:0.002949853-0.007042254

Graph1_Closeness <- closeness(qt1_graph, mode="all")
Graph1_Closeness <- as.data.frame(Graph1_Closeness) # Range:0.002197802-0.006369427

Graph2_Closeness <- closeness(qt2_graph, mode="all")
Graph2_Closeness <- as.data.frame(Graph2_Closeness) # Range:0.003472222-0.007352941

Graph3_Closeness <- closeness(qt3_graph, mode="all")
Graph3_Closeness <- as.data.frame(Graph3_Closeness) # Range:0.002624672-0.006802721

Graph4_Closeness <- closeness(qt4_graph, mode="all")
Graph4_Closeness <- as.data.frame(Graph4_Closeness) # Range:0.004016064-0.007407407

Graph5_Closeness <- closeness(qt5_graph, mode="all")
Graph5_Closeness <- as.data.frame(Graph5_Closeness) # Range:0.003937008-0.007462687

# Not much variation; Probably not an important measure.
# Decreasing order of similarity with Template: Graph3 > Graph2 > Graph1 > Graph5 = Graph4

# 3. Betweeness Centrality

Template_Betweeness <- betweenness(dt_graph)
Template_Betweeness <- as.data.frame(Template_Betweeness) # Range: 0.00-682.1806727

Graph1_Betweeness <- betweenness(qt1_graph)
Graph1_Betweeness <- as.data.frame(Graph1_Betweeness) # Range: 0.00-1012.7805777

Graph2_Betweeness <- betweenness(qt2_graph)
Graph2_Betweeness <- as.data.frame(Graph2_Betweeness) # Range: 0.00-893.3087233

Graph3_Betweeness <- betweenness(qt3_graph)
Graph3_Betweeness <- as.data.frame(Graph3_Betweeness) # Range: 0.00-466.4803012

Graph4_Betweeness <- betweenness(qt4_graph)
Graph4_Betweeness <- as.data.frame(Graph4_Betweeness) # Range: 0.00-912.652983

Graph5_Betweeness <- betweenness(qt5_graph)
Graph5_Betweeness <- as.data.frame(Graph5_Betweeness) # Range: 0.00-912.652983

########################################
# TEMPLATE ANALYSIS #
########################################

#Import the sample_attributes
Template_Attributes=data.table::fread(here::here("data", "CGCS-Template-NodeTypes.csv"))
dt_graph2 <- simplify(dt_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2, niter=5000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(dt_graph2)$color <- "grey"
V(dt_graph2)[degree(dt_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(dt_graph2)$size=betweenness(dt_graph)/20 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph), 2] == 1, "blue", 
                            ifelse(Template_Attributes[V(dt_graph), 2] == 4, "red",
                                   ifelse(Template_Attributes[V(dt_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


#Import the sample_attributes
Graph_Attributes=data.table::fread(here::here("data", "CGCS-GraphData-NodeTypes.csv"))

########################################
# GRAPH 1 ANALYSIS #
########################################
qt1_graph2 <- simplify(qt1_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt1_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt1_graph2)$color <- "grey"
V(qt1_graph2)[degree(qt1_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt1_graph2)$size=betweenness(qt1_graph)/50 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt1_graph2)$color <- ifelse(Graph_Attributes[V(qt1_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt1_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt1_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 2 ANALYSIS #
########################################
qt2_graph2 <- simplify(qt2_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt2_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt2_graph2)$color <- "grey"
V(qt2_graph2)[degree(qt2_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt2_graph2)$size=betweenness(qt2_graph)/50 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt2_graph2)$color <- ifelse(Graph_Attributes[V(qt2_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt2_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt2_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt2_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt2_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 3 ANALYSIS #
########################################
qt3_graph2 <- simplify(qt3_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt3_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt3_graph2)$color <- "grey"
V(qt3_graph2)[degree(qt3_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt3_graph2)$size=betweenness(qt3_graph)/50 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt3_graph2)$color <- ifelse(Graph_Attributes[V(qt3_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt3_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt3_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt3_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt3_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 4 ANALYSIS #
########################################
qt4_graph2 <- simplify(qt4_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt4_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt4_graph2)$color <- "grey"
V(qt4_graph2)[degree(qt4_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt4_graph2)$size=betweenness(qt4_graph)/50 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt4_graph2)$color <- ifelse(Graph_Attributes[V(qt4_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt4_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt4_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt4_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt4_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


########################################
# GRAPH 5 ANALYSIS #
########################################
qt5_graph2 <- simplify(qt5_graph)
#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt5_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt5_graph2)$color <- "grey"
V(qt5_graph2)[degree(qt5_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt5_graph2)$size=betweenness(qt5_graph)/50 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt5_graph2)$color <- ifelse(Graph_Attributes[V(qt5_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt5_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt5_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt5_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt5_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


# 4. Eigen Vector Centrality:

Template_EigenCentrality <- eigen_centrality(dt_graph)
Template_EigenCentrality <- as.data.frame(Template_EigenCentrality) #  Range:2.889807e-05-1.000000e+00; Value:90.31093

Graph1_EigenCentrality <- eigen_centrality(qt1_graph)
Graph1_EigenCentrality <- as.data.frame(Graph1_EigenCentrality) #Range:	8.486762e-07-1.000000e+00;Value:58.79659

Graph2_EigenCentrality <- eigen_centrality(qt2_graph)
Graph2_EigenCentrality <- as.data.frame(Graph2_EigenCentrality) #Range:0.0002027564-1.0000000000;Value:79.19767

Graph3_EigenCentrality <- eigen_centrality(qt3_graph)
Graph3_EigenCentrality <- as.data.frame(Graph3_EigenCentrality) #Range:1.370524e-06-1.0000000000;Value:35.96877

Graph4_EigenCentrality <- eigen_centrality(qt4_graph)
Graph4_EigenCentrality <- as.data.frame(Graph4_EigenCentrality) #Range:0.008849692-1.0000000000;Value:29.84092

Graph5_EigenCentrality <- eigen_centrality(qt5_graph)
Graph5_EigenCentrality <- as.data.frame(Graph5_EigenCentrality) #Range:0.006716513-1.0000000000;Value:	27.68101

imp_nodes_template <- which(Template_EigenCentrality$vector >= 0.5) # 2  3  4  5 15 16
imp_nodes_graph1 <- which(Graph1_EigenCentrality$vector >= 0.5) # 2  3  7  9 10 21
imp_nodes_graph2 <- which(Graph2_EigenCentrality$vector >= 0.5) # 4  5  6 14 15 18
imp_nodes_graph3 <- which(Graph3_EigenCentrality$vector >= 0.5) # 2  9 10
imp_nodes_graph4 <- which(Graph4_EigenCentrality$vector >= 0.5) #  7  8 14 16 17 30 38 53
imp_nodes_graph5 <- which(Graph5_EigenCentrality$vector >= 0.5) # 1  2  4  6 23 30 34

########################################
# TEMPLATE ANALYSIS #
########################################
dt_graph2<-simplify(dt_graph)
qt1_graph2<-simplify(qt1_graph)
qt2_graph2<-simplify(qt2_graph)
qt3_graph2<-simplify(qt3_graph)
qt4_graph2<-simplify(qt4_graph)
qt5_graph2<-simplify(qt5_graph)
#Import the sample_attributes
Template_Attributes=data.table::fread(here::here("data", "CGCS-Template-NodeTypes.csv"))

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2, niter=5000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(dt_graph2)$color <- "grey"
V(dt_graph2)[degree(dt_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(dt_graph2)$size <- eigen_centrality(dt_graph)/3

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(dt_graph2)$color <- ifelse(Template_Attributes[V(dt_graph), 2] == 1, "blue", 
                            ifelse(Template_Attributes[V(dt_graph), 2] == 4, "red",
                                   ifelse(Template_Attributes[V(dt_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


#Import the sample_attributes
Graph_Attributes=data.table::fread(here::here("data", "CGCS-GraphData-NodeTypes.csv"))

########################################
# GRAPH 1 ANALYSIS #
########################################

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt1_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want
#Node or Vetex Options: Size and Color
V(qt1_graph2)$color <- "grey"
V(qt1_graph2)[degree(qt1_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt1_graph2)$size=eigen_centrality(qt1_graph)/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt1_graph2)$color <- ifelse(Graph_Attributes[V(qt1_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt1_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt1_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt1_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt1_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 2 ANALYSIS #
########################################

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt2_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt2_graph2)$color <- "grey"
V(qt2_graph2)[degree(qt2_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt2_graph2)$size=eigen_centrality(qt2_graph)/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt2_graph2)$color <- ifelse(Graph_Attributes[V(qt2_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt2_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt2_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt2_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt2_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 3 ANALYSIS #
########################################

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt3_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt3_graph2)$color <- "grey"
V(qt3_graph2)[degree(qt3_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt3_graph2)$size=eigen_centrality(qt3_graph)/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt3_graph2)$color <- ifelse(Graph_Attributes[V(qt3_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt3_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt3_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt3_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt3_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)

########################################
# GRAPH 4 ANALYSIS #
########################################

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt4_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt4_graph2)$color <- "grey"
V(qt4_graph2)[degree(qt4_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt4_graph2)$size=eigen_centrality(qt4_graph)/3 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt4_graph2)$color <- ifelse(Graph_Attributes[V(qt4_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt4_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt4_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt4_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt4_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)


########################################
# GRAPH 5 ANALYSIS #
########################################

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(qt5_graph2, niter=1000) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(qt5_graph2)$color <- "grey"
V(qt5_graph2)[degree(qt5_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(qt5_graph2)$size=eigen_centrality(qt5_graph)/3 

#NodeType	Description
#  1	      Person
#  2	  Product category
#  3	      Document
#  4	  Financial category
#  5	      Country

V(qt5_graph2)$color <- ifelse(Graph_Attributes[V(qt5_graph), 2] == 1, "blue", 
                             ifelse(Graph1_Attributes[V(qt5_graph), 2] == 4, "red",
                                    ifelse(Graph1_Attributes[V(qt5_graph), 2] == 5, "green", "orange")))

#Edge Options: Color
E(qt5_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(qt5_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-", vertex.label = NA)













