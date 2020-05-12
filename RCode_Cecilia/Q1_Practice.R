getwd()
setwd('~/OVGU/Visualization_Project/MC1/data')
Template <- read.csv('CGCS-Template.csv')
Subgragh_1 <- read.csv('Q1-Graph1.csv')
Subgragh_2 <- read.csv('Q1-Graph2.csv')
Subgragh_3 <- read.csv('Q1-Graph3.csv')
Subgragh_4 <- read.csv('Q1-Graph4.csv')
Subgragh_5 <- read.csv('Q1-Graph5.csv')

install.packages("tidyverse")
install.packages("ggplot2")
install.packages(c("dplyr", "gapminder"))
install.packages("networkD3")

library(ggplot2)
ggplot(Template, aes(x = eType)) + geom_bar()
Data <- rbind(Template, Subgragh_1, Subgragh_2,Subgragh_3, Subgragh_4, Subgragh_5)
remove(Data)
Template$Original_Data <- "Template"
Subgragh_1$Original_Data <- "Subgragh_1"
Subgragh_2$Original_Data <- "Subgragh_2"
Subgragh_3$Original_Data <- "Subgragh_3"
Subgragh_4$Original_Data <- "Subgragh_4"
Subgragh_5$Original_Data <- "Subgragh_5"