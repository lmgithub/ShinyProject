library(shiny)
library(ggplot2)

# Data
ds <- read.csv("Data/RPOP_prepared.csv", header=TRUE)

# Settings variables
vGender <- as.vector(sort(unique(ds$Gender)))
vAge <- as.vector(sort(unique(ds$Age.groups)))
vYear <- as.vector(sort(unique(ds$Year)))
vUnits <- c("% of total", "Persons (in thousands)")