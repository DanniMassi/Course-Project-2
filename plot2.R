#Coursera Exploratory Data Analysis Course Project 2
#Author: Daniela Massiceti
#Date: 8th August 2014

#Plot 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#read data from files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#make plot 2
par(cex=0.9, cex.main=0.9, mar=c(5, 5, 2, 2))
baltimoreSubset <- subset(NEI, fips == "24510")
yearf = factor(baltimoreSubset$year)
baltimoreEmissionsPerYear <- tapply(baltimoreSubset$Emissions, yearf, sum)
plot(names(baltimoreEmissionsPerYear), baltimoreEmissionsPerYear, type="l", col="blue", xlab="Year", ylab=expression("Total "~PM[2.5]~" Emissions (tonnes)"), 
     main=expression("Total "~PM[2.5]~" Emissions from All Sources in Baltimore City, Maryland"), xaxt = "n")
axis(1, at=names(baltimoreEmissionsPerYear), labels=names(baltimoreEmissionsPerYear))

#write plot 2 to .png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

#remove NEI and SCC objects
rm(NEI)
rm(SCC)