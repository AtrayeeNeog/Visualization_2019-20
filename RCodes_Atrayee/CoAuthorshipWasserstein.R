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

dt01 <- dt %>% filter(dt$eType == 4) 
G101 <- qt1 %>% filter(qt1$eType == 4)
G201 <- qt2 %>% filter(qt2$eType == 4)
G301 <- qt3 %>% filter(qt3$eType == 4)
G401 <- qt4 %>% filter(qt4$eType == 4)
G501 <- qt5 %>% filter(qt5$eType == 4)

nrow(G501)

dt_network <- subset(dt01, select = c(Source, Target, Weight))
qt1_network <- subset(G101, select = c(Source, Target, Weight))
qt2_network <- subset(G201, select = c(Source, Target, Weight))
qt3_network <- subset(G301, select = c(Source, Target, Weight))
qt4_network <- subset(G401, select = c(Source, Target, Weight))
qt5_network <- subset(G501, select = c(Source, Target, Weight))

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


dt_graph2<-igraph::simplify(dt_graph, remove.multiple = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = FALSE)

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
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = FALSE, remove.loops = FALSE)

# For Degree:
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

# For Closeness:
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = FALSE, remove.loops = FALSE)

dt_closeness <- as.matrix(closeness(dt_graph2))
G1_closeness <- as.matrix(closeness(qt1_graph2))
G2_closeness <- as.matrix(closeness(qt2_graph2))
G3_closeness <- as.matrix(closeness(qt3_graph2))
G4_closeness <- as.matrix(closeness(qt4_graph2))
G5_closeness <- as.matrix(closeness(qt5_graph2))

wasserstein_metric(dt_closeness, G1_closeness)
wasserstein_metric(dt_closeness, G2_closeness)
wasserstein_metric(dt_closeness, G3_closeness)
wasserstein_metric(dt_closeness, G4_closeness)
wasserstein_metric(dt_closeness, G5_closeness)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_closeness, G1_closeness)[spec.output]
wasserstein.test(dt_closeness, G2_closeness)[spec.output]
wasserstein.test(dt_closeness, G3_closeness)[spec.output]
wasserstein.test(dt_closeness, G4_closeness)[spec.output]
wasserstein.test(dt_closeness, G5_closeness)[spec.output]

# For betweenness:
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = TRUE, remove.loops = FALSE)

dt_betweenness <- as.matrix(betweenness(dt_graph2))
G1_betweenness <- as.matrix(betweenness(qt1_graph2))
G2_betweenness <- as.matrix(betweenness(qt2_graph2))
G3_betweenness <- as.matrix(betweenness(qt3_graph2))
G4_betweenness <- as.matrix(betweenness(qt4_graph2))
G5_betweenness <- as.matrix(betweenness(qt5_graph2))

wasserstein_metric(dt_betweenness, G1_betweenness)
wasserstein_metric(dt_betweenness, G2_betweenness)
wasserstein_metric(dt_betweenness, G3_betweenness)
wasserstein_metric(dt_betweenness, G4_betweenness)
wasserstein_metric(dt_betweenness, G5_betweenness)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_betweenness, G1_betweenness)[spec.output]
wasserstein.test(dt_betweenness, G2_betweenness)[spec.output]
wasserstein.test(dt_betweenness, G3_betweenness)[spec.output]
wasserstein.test(dt_betweenness, G4_betweenness)[spec.output]
wasserstein.test(dt_betweenness, G5_betweenness)[spec.output]

# For Eigen Centrality:
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = TRUE, remove.loops = FALSE)

dt_eigen_centrality <- as.matrix((eigen_centrality(dt_graph2))$vector)
G1_eigen_centrality <- as.matrix((eigen_centrality(qt1_graph2))$vector)
G2_eigen_centrality <- as.matrix((eigen_centrality(qt2_graph2))$vector)
G3_eigen_centrality <- as.matrix((eigen_centrality(qt3_graph2))$vector)
G4_eigen_centrality <- as.matrix((eigen_centrality(qt4_graph2))$vector)
G5_eigen_centrality <- as.matrix((eigen_centrality(qt5_graph2))$vector)


wasserstein_metric(dt_eigen_centrality, G1_eigen_centrality)
wasserstein_metric(dt_eigen_centrality, G2_eigen_centrality)
wasserstein_metric(dt_eigen_centrality, G3_eigen_centrality)
wasserstein_metric(dt_eigen_centrality, G4_eigen_centrality)
wasserstein_metric(dt_eigen_centrality, G5_eigen_centrality)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_eigen_centrality, G1_eigen_centrality)[spec.output]
wasserstein.test(dt_eigen_centrality, G2_eigen_centrality)[spec.output]
wasserstein.test(dt_eigen_centrality, G3_eigen_centrality)[spec.output]
wasserstein.test(dt_eigen_centrality, G4_eigen_centrality)[spec.output]
wasserstein.test(dt_eigen_centrality, G5_eigen_centrality)[spec.output]


# For Page Rank:
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = TRUE, remove.loops = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = TRUE, remove.loops = FALSE)

dt_page_rank <- as.matrix((page.rank(dt_graph2))$vector)
G1_page_rank <- as.matrix((page.rank(qt1_graph2))$vector)
G2_page_rank <- as.matrix((page.rank(qt2_graph2))$vector)
G3_page_rank <- as.matrix((page.rank(qt3_graph2))$vector)
G4_page_rank <- as.matrix((page.rank(qt4_graph2))$vector)
G5_page_rank <- as.matrix((page.rank(qt5_graph2))$vector)


wasserstein_metric(dt_page_rank, G1_page_rank)
wasserstein_metric(dt_page_rank, G2_page_rank)
wasserstein_metric(dt_page_rank, G3_page_rank)
wasserstein_metric(dt_page_rank, G4_page_rank)
wasserstein_metric(dt_page_rank, G5_page_rank)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_page_rank, G1_page_rank)[spec.output]
wasserstein.test(dt_page_rank, G2_page_rank)[spec.output]
wasserstein.test(dt_page_rank, G3_page_rank)[spec.output]
wasserstein.test(dt_page_rank, G4_page_rank)[spec.output]
wasserstein.test(dt_page_rank, G5_page_rank)[spec.output]

# For KNN:
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = TRUE, remove.loops = TRUE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = TRUE, remove.loops = TRUE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = TRUE, remove.loops = TRUE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = TRUE, remove.loops = TRUE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = TRUE, remove.loops = TRUE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = TRUE, remove.loops = TRUE)

dt_knn <- as.matrix((knn(dt_graph2))$knn)
G1_knn <- as.matrix((knn(qt1_graph2))$knn)
G2_knn <- as.matrix((knn(qt2_graph2))$knn)
G3_knn <- as.matrix((knn(qt3_graph2))$knn)
G4_knn <- as.matrix((knn(qt4_graph2))$knn)
G5_knn <- as.matrix((knn(qt5_graph2))$knn)

wasserstein_metric(dt_knn, G1_knn)
wasserstein_metric(dt_knn, G2_knn)
wasserstein_metric(dt_knn, G3_knn)
wasserstein_metric(dt_knn, G4_knn)
wasserstein_metric(dt_knn, G5_knn)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_knn, G1_knn)[spec.output]
wasserstein.test(dt_knn, G2_knn)[spec.output]
wasserstein.test(dt_knn, G3_knn)[spec.output]
wasserstein.test(dt_knn, G4_knn)[spec.output]
wasserstein.test(dt_knn, G5_knn)[spec.output]

# For Hubs:
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = FALSE, remove.loops = FALSE)

dt_hubs <- as.matrix((hub_score(dt_graph2))$vector)
G1_hubs <- as.matrix((hub_score(qt1_graph2))$vector)
G2_hubs <- as.matrix((hub_score(qt2_graph2))$vector)
G3_hubs <- as.matrix((hub_score(qt3_graph2))$vector)
G4_hubs <- as.matrix((hub_score(qt4_graph2))$vector)
G5_hubs <- as.matrix((hub_score(qt5_graph2))$vector)

wasserstein_metric(dt_hubs, G1_hubs)
wasserstein_metric(dt_hubs, G2_hubs)
wasserstein_metric(dt_hubs, G3_hubs)
wasserstein_metric(dt_hubs, G4_hubs)
wasserstein_metric(dt_hubs, G5_hubs)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_hubs, G1_hubs)[spec.output]
wasserstein.test(dt_hubs, G2_hubs)[spec.output]
wasserstein.test(dt_hubs, G3_hubs)[spec.output]
wasserstein.test(dt_hubs, G4_hubs)[spec.output]
wasserstein.test(dt_hubs, G5_hubs)[spec.output]

# For Authorities:
dt_graph2<-igraph::simplify(dt_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt1_graph2<-igraph::simplify(qt1_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt2_graph2<-igraph::simplify(qt2_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt3_graph2<-igraph::simplify(qt3_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt4_graph2<-igraph::simplify(qt4_graph, remove.multiple = FALSE, remove.loops = FALSE)
qt5_graph2<-igraph::simplify(qt5_graph, remove.multiple = FALSE, remove.loops = FALSE)

dt_authorities <- as.matrix((authority_score(dt_graph2))$vector)
G1_authorities <- as.matrix((authority_score(qt1_graph2))$vector)
G2_authorities <- as.matrix((authority_score(qt2_graph2))$vector)
G3_authorities <- as.matrix((authority_score(qt3_graph2))$vector)
G4_authorities <- as.matrix((authority_score(qt4_graph2))$vector)
G5_authorities <- as.matrix((authority_score(qt5_graph2))$vector)

wasserstein_metric(dt_authorities, G1_authorities)
wasserstein_metric(dt_authorities, G2_authorities)
wasserstein_metric(dt_authorities, G3_authorities)
wasserstein_metric(dt_authorities, G4_authorities)
wasserstein_metric(dt_authorities, G5_authorities)

# Testing based on Wasserstein Distance:
spec.output <- c("pval", "d.wass^2", "perc.loc", "perc.size", "perc.shape")
wasserstein.test(dt_authorities, G1_authorities)[spec.output]
wasserstein.test(dt_authorities, G2_authorities)[spec.output]
wasserstein.test(dt_authorities, G3_authorities)[spec.output]
wasserstein.test(dt_authorities, G4_authorities)[spec.output]
wasserstein.test(dt_authorities, G5_authorities)[spec.output]








