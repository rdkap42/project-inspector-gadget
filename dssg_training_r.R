
# Load in Data
drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv, 
                host = "dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com",
               dbname = "training_2015",
                user = "brew",
                 password = "brew")

data <- dbGetQuery(con, "SELECT * FROM ben_brew.Building_Violations_sample_50000;")

#load data from csv 
#data <-'/home/benbrew/Documents/'
#setwd(data)
#data <- read.csv("Building_Violations_sample_50000.csv")

# make column names lower case 

colnames(data) <- tolower(colnames(data))

# get ride of spaces 
library(stringr)

colnames(data) <- str_replace_all(colnames(data), "\\s+", "_")

#Dimension and summary 

dim(data)
summary(data)
sapply(data, class)

#ggplot 
library(ggplot2)
library(hexbin)

ggplot(data,aes(x=longitude,y=latitude)) + stat_binhex()



#create day of year variables 

data$doy <- format(data$violation_date, format = "%j")

data$doy <- as.numeric(data$doy)

data$season <- factor(ifelse(data$doy >= 1 & data$doy <= 81, "winter",
                               ifelse(data$doy >= 82 & data$doy <= 172, "spring",
                                      ifelse(data$doy >= 173 & data$doy <= 264, "summer",
                                             ifelse(data$doy >= 265 & data$doy <= 355, "fall", "winter")))))

# group by season

seasonal <- data %>%
  group_by(violation_code) %>%
  summarise(spring = sum(season == "spring"),
            winter = sum(season == "winter"),
            summer = sum(season == "summer"),
            fall = sum(season == "fall"))


#Group by violation status and date 
library(dplyr)
data$violation_status <- as.factor(data$violation_status)
dat <- data %>%
  group_by(violation_date) %>%
  summarise(status_open = sum(violation_status == "OPEN"),
            status_no = sum(violation_status == "NO ENTRY"),
            status_comp = sum(violation_status == "COMPLIED"))

## maps 

library(maps)
map("city", "chicago")

fl_map <- map("county", "fl")
summary(fl_map)


#Histograms 
hist(dat$status_comp, col = "lightblue",
     breaks = 20,
     main = "Violation Status Complied",
     xlab = "Complied")





