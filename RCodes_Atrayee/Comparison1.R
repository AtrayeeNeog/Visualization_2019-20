library(igraph)
library(here)
library(tidyverse)

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
#Template Network: First Try

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph) #Creating a layout object to tell iGraph what layout I want

#Node or Vertex Options: Color
V(dt_graph)$color <- "grey"
V(dt_graph)[degree(dt_graph, mode="in")>20]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow

#Edge Options: Siz
E(dt_graph)$color <- "grey"

#Plotting 
plot(dt_graph)

#Template Network: Second Try

#Let work on get the nodes better first by making the sizing proportional to the network measure we care about, in this case degree
V(dt_graph)$size=degree(dt_graph, mode = "in")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#Node or Vertex Options: Color
V(dt_graph)$color <- "grey"
V(dt_graph)[degree(dt_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow

#Edge Options: Siz
E(dt_graph)$color <- "grey"

#Plotting 
plot(dt_graph)


#Template Network: Third Try
#Removing Arrows

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(dt_graph)$color <- "grey"
V(dt_graph)[degree(dt_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(dt_graph)$size=degree(dt_graph, mode = "in")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#Edge Options: Color
E(dt_graph)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph, edge.arrow.size=0.25,edge.arrow.mode = "-")

#Template Network: Fourth Try

#Removing Self-Loops (Repondents Nominating Themselves)
dt_graph2<-simplify(dt_graph, remove.multiple=TRUE, remove.loops=TRUE)

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2) #Creating a layout object to tell iGraph what layout I want

#Node or Vetex Options: Size and Color
V(dt_graph2)$color <- "grey"
V(dt_graph2)[degree(dt_graph, mode="in")>8]$color <- "yellow"  #Destinguishing High Degree Nodes as yellow
V(dt_graph2)$size=degree(dt_graph, mode = "in")/5 #because we have wide range, I am dividing by 5 to keep the high in-degree nodes from overshadowing everything else.

#Edge Options: Color
E(dt_graph2)$color <- "grey"

#Plotting, Now Specifying an arrow size and getting rid of arrow heads
#We are letting the color and the size of the node indicate the directed nature of the graph
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-")

#Template Network: Fifth Try

#Import the sample_attributes
Template_Attributes=data.table::fread(here::here("data", "CGCS-Template-NodeTypes.csv"))

#Layout Options
set.seed(3952)  # set seed to make the layout reproducible
layout1 <- layout.fruchterman.reingold(dt_graph2) #Creating a layout object to tell iGraph what layout I want

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
plot(dt_graph2, edge.arrow.size=0.25,edge.arrow.mode = "-")
