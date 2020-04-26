library(GGally)

ncol(dt)

ggparcoord(dt, columns = 1: ncol(dt), groupColumn = 4) # Parallel Coords for the Template
ggparcoord(qt1, columns = 1: ncol(qt1), groupColumn = 4) # Parallel Coords for Graph 1
ggparcoord(qt2, columns = 1: ncol(qt2), groupColumn = 4) # Parallel Coords for Graph 2


