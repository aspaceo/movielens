## test of movielens data  ----------------------------------------------------

setwd('/Users/Paul/Desktop/movielens/')

## load u.data  ---------------------------------------------------------------
dt <- read.table(file = 'u.data', header = F, sep = '\t'
                 , col.names = c('user_id', 'item_id', 'rating', 'timestamp')
)

## now what?? implement amazon's algorithm??  ---------------------------------
table(dt$item_id)

