library(ggpubr)
library(GGally)

ncol(dt)

ggparcoord(dt, columns = 1: ncol(dt), groupColumn = 3) # Parallel Coords for the Template
ggparcoord(qt1, columns = 1: ncol(qt1), groupColumn = 3) # Parallel Coords for Graph 1
ggparcoord(qt2, columns = 1: ncol(qt2), groupColumn = 3) # Parallel Coords for Graph 2

# For Communication Channel:
com_temp <- ggparcoord(dt01, groupColumn = 3)
com_g1<- ggparcoord(qt1_01,columns = 1:ncol(qt1_01), groupColumn = 3)
com_g2 <- ggparcoord(qt2_01,columns = 1:ncol(qt2_01), groupColumn = 3)
com_g3 <- ggparcoord(qt3_01,columns = 1:ncol(qt3_01), groupColumn = 3)
com_g4 <- ggparcoord(qt4_01,columns = 1:ncol(qt4_01), groupColumn = 3)
com_g5 <- ggparcoord(qt5_01,columns = 1:ncol(qt5_01), groupColumn = 3)
ggarrange(com_temp, com_g1, com_g2, com_g3, com_g4, com_g5)

# For Demographic Channel:
dem_temp <- ggparcoord(dt5, columns = 1:ncol(dt5),groupColumn = 3)
dem_g1<- ggparcoord(qt1_5,columns = 1:ncol(qt1_5), groupColumn = 3)
dem_g2 <- ggparcoord(qt2_5,columns = 1:ncol(qt2_5), groupColumn = 3)
dem_g3 <- ggparcoord(qt3_5,columns = 1:ncol(qt3_5), groupColumn = 3)
dem_g4 <- ggparcoord(qt4_5,columns = 1:ncol(qt4_5), groupColumn = 3)
dem_g5 <- ggparcoord(qt5_5,columns = 1:ncol(qt5_5), groupColumn = 3)
ggarrange(dem_temp, dem_g1, dem_g2, dem_g3, dem_g4, dem_g5)


