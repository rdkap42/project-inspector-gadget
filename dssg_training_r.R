
# Load in Data
drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv, 
                 host = "dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com",
                 dbname = "training_2015",
                 user = "brew",
                 password = "brew")

data <- dbGetQuery(con, "SELECT * FROM ben_brew.Building_Violations_sample_50000;")

# make column names lower case 

colnames(data) <- tolower(colnames(data))

# get ride of spaces 
library(stringr)

colnames(data) <- str_replace_all(colnames(data), "\\s+", "_")

#Dimension and summary 

dim(data)
summary(data)
sapply(data, class)

#find missing comments in violation_inspector_comments
sum(is.na(data$violation_inspector_comments) | data$violation_inspector_comments =="")


#Group by violation status and date 
library(dplyr)
data$violation_status <- as.factor(data$violation_status)
dat <- data %>%
  group_by(violation_date) %>%
  summarise(status_open = sum(violation_status == "OPEN"),
            status_no = sum(violation_status == "NO ENTRY"),
            status_comp = sum(violation_status == "COMPLIED"))


#Histograms 

hist(dat$status_comp, col = "lightblue",
     breaks = 20,
     main = "Violation Status Complied",
     xlab = "Complied")





