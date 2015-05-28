data <- '/home/benbrew/Documents/project'

setwd(data)

# read in data
violation <- read.csv("Building_Violations.csv")
permit <- read.csv("Building_Permits.csv")

# make lower case 
colnames(violation) <- tolower(colnames(violation))
colnames(permit) <- tolower(colnames(permit))

#### Violation

# view variable names 
names(violation)

# group by date and violation status  
library(dplyr)
dat <- violation %>%
  group_by(violation.date) %>%
  summarise(status_open = sum(violation.status == "OPEN"),
            status_no = sum(violation.status == "NO ENTRY"),
            status_comp = sum(violation.status == "COMPLIED"))
