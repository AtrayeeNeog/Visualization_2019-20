library(igraph)
library(here)
library(tidyverse)
library (readr)
library (haven)
library (ggplot2)
library(transport)
library(plyr)
#if (!requireNamespace("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")
#BiocManager::install("waddR")
library(waddR)

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
dt_graph2<-simplify(dt_graph)
qt1_graph2<-simplify(qt1_graph)
qt2_graph2<-simplify(qt2_graph)
qt3_graph2<-simplify(qt3_graph)
qt4_graph2<-simplify(qt4_graph)
qt5_graph2<-simplify(qt5_graph)

dt_degree <- as.matrix(degree(dt_graph2))
G1_degree <- as.matrix(degree(qt1_graph2))
G2_degree <- as.matrix(degree(qt2_graph2))
G3_degree <- as.matrix(degree(qt3_graph2))
G4_degree <- as.matrix(degree(qt4_graph2))
G5_degree <- as.matrix(degree(qt5_graph2))

wasserstein_metric(dt_degree, G1_degree)
wasserstein_metric(dt_degree, G2_degree)
wasserstein_metric(dt_degree, G3_degree)
wasserstein_metric(dt_degree, G4_degree)
wasserstein_metric(dt_degree, G5_degree)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_degree, G1_degree)[spec.output]
wasserstein.test(dt_degree, G2_degree)[spec.output]
wasserstein.test(dt_degree, G3_degree)[spec.output]
wasserstein.test(dt_degree, G4_degree)[spec.output]
wasserstein.test(dt_degree, G5_degree)[spec.output]





