
#
# Exploratory Data Analysis
# Course Project 1
# Construction of plots from the  Electric power consumption dataset
#The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#1.Date: Date in format dd/mm/yyyy 
#2.Time: time in format hh:mm:ss 
#3.Global_active_power: household global minute-averaged active power (in kilowatt) 
#4.Global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
#5.Voltage: minute-averaged voltage (in volt) 
#6.Global_intensity: household global minute-averaged current intensity (in ampere) 
#7.Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, 
#containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). 
#8.Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, 
#containing a washing-machine, a tumble-drier, a refrigerator and a light. 
#9.Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner


# set the working dir, create a dir work processing file.
 setwd("C://R_Coursera//exploratoryDataAnalysis")
 csvfilename = "./data/household_power_consumption.txt"

# create a dir for the task
if (!file.exists("./data")) {dir.create("./data")}

dateDownloaded<- date()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file (fileUrl, destfile="./data/data.zip")

csvdata<-unzip("./data/data.zip", exdir="./data")


tab5rows <- read.table(csvfilename, sep=";", header = TRUE, nrows = 5)
classes <- sapply(tab5rows, class)
tabAll <- read.table(csvfilename, sep=";", header = TRUE, colClasses = classes, na.strings = "?"  )

#mash the date and time together and add as a new column
datetime<-paste(tabAll[,1], tabAll[,2])
tabAll <- cbind(tabAll, datetime)

tabAll$datetime=strptime(tabAll$datetime,format="%d/%m/%Y%n%H:%M:%s")

 
 
tabAll[,1] = as.Date(tabAll[,1], format="%d/%m/%Y") 

 str=paste("2007-02-01|2007-02-02" )
sub<- tabAll[grep(str,tabAll[,1]),] 

sub <- cbind(sub, days=weekdays(sub$datetime, abbreviate=TRUE) )
 
# create  graph
 hist(sub$Global_active_power, xlab="Global active power (kilowatts)", col="red", main="Global Active Power")
 # create png 
dev.copy(png, file="./data/plot1.png", width=480, height=480)
#clean up
dev.off()
 







