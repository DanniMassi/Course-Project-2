#Coursera Exploratory Data Analysis Course Project 2
#Author: Daniela Massiceti
#Date: 8th August 2014

#Plot 4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#load libraries
library(ggplot2)
library(plyr)

#read data from files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#coal combustion related subset
coalcombustion <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

#subset NEI to only include coal combustion-related sources
coalcombSubset <- subset(NEI, SCC %in% coalcombustion$SCC)

#total emissions for coal combustion sources 
totalEmissions <- ddply(coalcombSubset, .(year, type), function(x) sum(x$Emissions))
colnames(totalEmissions)[3] <- "Emissions"

#make plot 4
p <- qplot(year, Emissions, data=totalEmissions, color=type, geom="line")
p <- p + ggtitle(expression("Total" ~ PM[2.5] ~ " Emissions per Year for Coal Combustion Sources in US")) 
p <- p + theme(plot.title=element_text(size=12))
p <- p + xlab("Year") 
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
print(p)

#write plot 4 to .png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

#remove NEI and SCC objects
rm(NEI)
rm(SCC)