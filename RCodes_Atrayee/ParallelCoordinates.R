library(ggpubr)
library(GGally)

ncol(dt)

ggparcoord(dt, columns = 1: ncol(dt), groupColumn = 3) # Parallel Coords for the Template
ggparcoord(qt1, columns = 1: ncol(qt1), groupColumn = 3) # Parallel Coords for Graph 1
ggparcoord(qt2, columns = 1: ncol(qt2), groupColumn = 3) # Parallel Coords for Graph 2

# For Communication Channel:
par(mfrow = c(1,3))
par_temp <- ggparcoord(dt01, groupColumn = 3)
par_g1<- ggparcoord(qt1_01,columns = 1:7, groupColumn = 3)
par_g2 <- ggparcoord(qt2_01,columns = 1:7, groupColumn = 3)
ggarrange(par_temp, par_g1, par_g2)

