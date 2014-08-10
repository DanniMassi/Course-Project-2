#Coursera Exploratory Data Analysis Course Project 2
#Author: Daniela Massiceti
#Date: 8th August 2014

#Plot 3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
#plot answer this question.

#load libraries
library(ggplot2)
library(plyr)

#read data from files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#subset NEI to only include Baltimore City
baltimoreSubset <- subset(NEI, fips == "24510")

#total emissions per source type in Baltimore City
totalEmissionsPerType <- ddply(baltimoreSubset, .(year, type), function(x) sum(x$Emissions))

#make plot 3
p <- qplot(year, V1, data=totalEmissionsPerType, color=type, geom="line")
p <- p + ggtitle(expression("Total" ~ PM[2.5] ~ " Emissions per Year per Source Type in Baltimore City")) 
p <- p + theme(plot.title=element_text(size=12))
p <- p + xlab("Year") 
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
print(p)

#write plot 3 to .png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

#remove NEI and SCC objects
rm(NEI)
rm(SCC)