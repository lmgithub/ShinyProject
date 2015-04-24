setwd("/home/lm/Projects/Data Products/ShinyProject")
# Reading data
ds <- read.csv("Data/RPOP.csv", header=TRUE)
ds <- subset(ds, select=c(Country, Age.groups, Gender, Year, Value))
# to wide format with Males and Females columns
require(reshape2)
dsTmp.wide <- dcast(ds, Country + Age.groups + Year ~ Gender, value.var="Value")
# calculating Rate of Males (% of total population)
dsTmp.wide$Rate <- round((dsTmp.wide$Males / (dsTmp.wide$Males+dsTmp.wide$Females)) * 100, 4)
# Melting back to tidy format
dsTmp.long <- melt(dsTmp.wide, id=c("Country", "Age.groups", "Year", "Rate"))
names(dsTmp.long)[5] <- "Gender"
# calculating Rate Females/Mails
dsTmp.long$Rate[dsTmp.long$Gender=="Females"] <- 100 - dsTmp.long$Rate[dsTmp.long$Gender=="Females"]
# Saving prepared dataset
write.csv(dsTmp.long, "Data/RPOP_prepared.csv")
