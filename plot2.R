# to plot plot2.png

# read the data from the source: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

fileName <- "exdata_dataset.zip"

# Download  the zip file dataset
if (!file.exists(fileName)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, fileName, mode='wb')
}  
# Extract the datasets by unzipping
if (!file.exists("household_power_consumption.txt")) { 
  unzip(fileName) 
}

# Generate plot2.png

# set data file
dataFile <- "C:/Users/rekha/Documents/household_power_consumption.txt"

# read data file
df<- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#subset data for dates between "1/2/2007 & 2/2/2007"
subData <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

#get the date & Time so we can get the day
dateTime <- strptime(paste(subData$Date, subData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# Get the measure Global_active_power to plot
globalActivePower <- as.numeric(subData$Global_active_power)

# set height and width of png file to plot
png("plot2.png", width=480, height=480)

# plot against date & time for Global active power
plot(dateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# close device
dev.off()
