
# Loding the ff package for loading huge datasets
install.packages("ff")
library(ff)


# Reading the huge CGCS-GraphData.csv dataset first 10m row and then 5m at a time with ff library
CGCS_Data <- read.csv.ffdf(file="CGCS-GraphData.csv", 
                           header=TRUE, 
                           VERBOSE=TRUE, 
                           first.rows=10000000, 
                           next.rows=5000000, 
                           colClasses=NA, )

# take a peek into the CGCS_Data
head(CGCS_Data)
typeof(CGCS_Data)
nrow(CGCS_Data)
ncol(CGCS_Data)
tail(CGCS_Data)