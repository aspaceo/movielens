## test of movielens data  ----------------------------------------------------

## libraries  -----------------------------------------------------------------
library(dplyr)
library(magrittr)

## directory  -----------------------------------------------------------------
setwd('/Users/Paul/Desktop/movielens/')

## load u.data  ---------------------------------------------------------------
dt <- read.table(file = 'u.data', header = F, sep = '\t'
                 , col.names = c('user_id', 'item_id', 'rating', 'timestamp')
)

item <- read.csv(file = 'movie_lkup.csv'
                 , header = T
                 , sep = ','
                 , stringsAsFactors = F
                 )

## fix movie_names  -----------------------------------------------------------
dt_named <- merge(dt, item)
## unique identifier (using name), as some names are duplicated  --------------
dt_named$unique_id <- paste(dt_named$item_id, ': ', dt_named$movie_title, sep = '')

## now what?? implement amazon's algorithm??  ---------------------------------

## generate a matix??  --------------------------------------------------------
mt <- matrix(nrow = length(unique(dt_named$user_id)) ## customer --------------------
             , ncol = length(unique(dt_named$item_id)) ## movie  --------------------
             , dimnames = list(unique(dt_named$user_id), unique(dt_named$unique_id))
             , data = 0
             
)

## update matrix with customer ratings  ---------------------------------------
for (i in 1:nrow(dt_named)) {
  user <- as.character(dt_named[i, 'user_id'])
  movie <- as.character(dt_named[i, 'unique_id'])
  rating <- dt_named[i, 'rating']
  ##update matrix  ------------------------------------------------------------
  mt[user, movie] <- rating
  print(i)
  
} ## for loop close  ----------------------------------------------------------

## lookup individual films  ---------------------------------------------------
unique(dt_named$unique_id)
mt[, '739: Pretty Woman (1990)']


## calculate cosine similarity  -----------------------------------------------
cosine_sim <- function(a, b) {
  ## calculate the norm of the vector  ----------------------------------------
  norm_vec <- function(x) sqrt(sum(x^2))
  
  ## take the dot product  ----------------------------------------------------
  dt_prd <- as.numeric(a %*% b)
  norm <- norm_vec(a) * norm_vec(b)
  return(dt_prd / norm)
}  ## function close  ---------------------------------------------------------

movie_i <- mt[, '739: Pretty Woman (1990)']
movie_ii <- mt[, '568: Speed (1994)']
cosine_sim(movie_i, movie_ii)

## movie comparisons  ---------------------------------------------------------
  ## pretty woman:
      ## shawshank => 0.42
      ## ace ventura => 0.26
      ## braveheart => 0.49
      ## us marshalls => 0.099
      ## speed => 0.56