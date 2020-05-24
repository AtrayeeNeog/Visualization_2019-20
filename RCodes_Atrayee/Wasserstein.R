library(igraph)
library(here)
library(tidyverse)
library (readr)
library (haven)
library (ggplot2)
library(transport)

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


