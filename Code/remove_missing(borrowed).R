
remove_missing<-function(df, axis=0){
  ##default is entry-wise deletion
  missing=c()
    if(axis==1){
    for(i in 1:(ncol(df))){
      if (any(is.na(df[,i]))){
        missing=c(missing,i)
      }
    }
    col_cleaned=df[,-missing]
  }
  else{
    for(i in 1:(nrow(df))){
      if (any(is.na(df[i,]))){
        missing=c(missing,i)
      }
    }
    col_cleaned=df[-missing,]
  }
  return(col_cleaned)
}
  
#library('RPostgreSQL')

#drv <- dbDriver('PostgreSQL')
#con <- dbConnect(drv, 
#                 host = "dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com",
#                 dbname = "training_2015",
#                 user = "frailey",
#                 password = 'frailey')

#data <-dbGetQuery(con, "SELECT * FROM frailey.building_violations_sample;")

df=remove_missing(data)
dim(df)
