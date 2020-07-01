getwd()
library(tidyverse)
library(plyr)

TravelC <- read.csv('eType6.csv')
#Travel Channel has a lot of duplicated data, there are only 298481 left after deduplicated.
Travel_dedupted <- TravelC[!duplicated(TravelC), ]

## Each variable with it's Frequency Counts:
target_count <- count(Travel_dedupted, 'Target')

# Communication Channel
Communication <- Template %>% filter(Template$eType == 0 | Template$eType == 1)
nrow(Communication) # 563
# Procurement Channel
Procurement <- Template %>% filter(Template$eType == 2 | Template$eType == 3)
nrow(Procurement) # 18

common_list <- NULL
for (i in Communication$Source) {
  for (j in Procurement$Source) {
    if(i==j){
      common_list <- append(common_list,i)
      common_list <- unique(common_list)
    }
    
  }
  
}

sort(Travel_dedupted$Target,decreasing=TRUE)[1:3]






