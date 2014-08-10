#Coursera Exploratory Data Analysis Course Project 2
#Author: Daniela Massiceti
#Date: 8th August 2014

#Plot 5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#load libraries
library(ggplot2)
library(plyr)

#read data from files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#vehicle related subset
vehiclesInBaltimore <- subset(NEI, fips=="24510" & type=="ON-ROAD")

#total emissions for vehicles in Baltimore
totalEmissions <- ddply(vehiclesInBaltimore, .(year), function(x) sum(x$Emissions))
colnames(totalEmissions) <- c('year', 'Emissions')
totalEmissions$year <- factor(totalEmissions$year, levels=c('1999', '2002', '2005', '2008'))

#make plot 5
p <- ggplot(data=totalEmissions, aes(x=year, y=Emissions)) + geom_bar(stat="identity", aes(fill=year)) + guides(fill=F)
p <- p + ggtitle(expression("Total" ~ PM[2.5] ~ " Emissions per Year for Vehicular Sources in Baltimore City"))
p <- p + theme(plot.title=element_text(size=12))
p <- p + xlab("Year") + theme(legend.position='none')
p <- p + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
print(p)

#write plot 5 to .png file
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()

#remove NEI and SCC objects
rm(NEI)
rm(SCC)