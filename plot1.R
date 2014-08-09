#Coursera Exploratory Data Analysis Course Project 2
#Author: Daniela Massiceti
#Date: 8th August 2014

#Plot 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

#read data from files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#make plot 1
par(cex=0.9, cex.main=1.1, mar=c(5, 5, 2, 2))
yearf = factor(NEI$year)
totalEmissionsPerYear <- tapply(NEI$Emissions, yearf, sum)
plot(names(totalEmissionsPerYear), totalEmissionsPerYear, type="l", col="blue", xlab="Year", ylab=expression("Total "~PM[2.5]~" Emissions (tonnes)"), 
    main=expression("Total "~PM[2.5]~" Emissions from All Sources in United States"), xaxt = "n")
axis(1, at=names(totalEmissionsPerYear), labels=names(totalEmissionsPerYear))

#write plot 1 to .png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

#remove NEI and SCC objects
rm(NEI)
rm(SCC)