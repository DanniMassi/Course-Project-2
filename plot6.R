#Coursera Exploratory Data Analysis Course Project 2
#Author: Daniela Massiceti
#Date: 8th August 2014

#Plot 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#load libraries
library(ggplot2)
library(plyr)

#read data from files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#vehicles in Baltimore subset
vehiclesInBaltimore <- subset(NEI, fips=="24510" & type=="ON-ROAD")

#vehicles in Los Angeles subset
vehiclesInLA <- subset(NEI, fips=="06037" & type=="ON-ROAD")

#total emissions for vehicles in Baltimore
totalEmissionsBaltimore <- ddply(vehiclesInBaltimore, .(year), function(x) sum(x$Emissions))
totalEmissionsBaltimore$city <- "BAL"
colnames(totalEmissionsBaltimore) <- c('year', 'Emissions', 'city')

#total emissions for vehicles in LA
totalEmissionsLA <- ddply(vehiclesInLA, .(year), function(x) sum(x$Emissions))
totalEmissionsLA$city <- "LA"
colnames(totalEmissionsLA) <- c('year', 'Emissions', 'city')

#vehicular emissions in Baltimore and LA
allvehicles <- rbind(totalEmissionsBaltimore, totalEmissionsLA)
allvehicles$year <- factor(allvehicles$year, levels=c('1999', '2002', '2005', '2008'))

#make plot 6

p <- ggplot(data=allvehicles, aes(x=year, y=Emissions)) + geom_bar(stat="identity", aes(fill=year)) + guides(fill=F)
p <- p + ggtitle(expression(PM[2.5] ~ " Emissions for Vehicular Sources in Baltimore City, Maryland vs Los Angeles, California")) 
p <- p + theme(plot.title=element_text(size=10))
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)")) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ city)
print(p)

#write plot 6 to .png file
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()

#remove NEI and SCC objects
rm(NEI)
rm(SCC)