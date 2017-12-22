# to plot plot3.png

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

# Generate plot3.png

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


# set the submetering
subMetering1 <- as.numeric(subData$Sub_metering_1)
subMetering2 <- as.numeric(subData$Sub_metering_2)
subMetering3 <- as.numeric(subData$Sub_metering_3)

# set height and width of png file to plot
png("plot3.png", width=480, height=480)

# plot against datetime & energy sub metering
plot(dateTime, subMetering1, type="l", ylab="Energy Sub metering", xlab="")
lines(dateTime, subMetering2, type="l", col="red")
lines(dateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# close device
dev.off()
