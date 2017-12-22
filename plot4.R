# to plot plot4.png

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

# Generate plot4.png

# set data file
dataFile <- "C:/Users/rekha/Documents/household_power_consumption.txt"

# read data file
df<- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#subset data for dates between "1/2/2007 & 2/2/2007"
subData <- df[df$Date %in% c("1/2/2007","2/2/2007") ,]

#get the date & Time so we can get the day
dateTime <- strptime(paste(subData$Date, subData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# get the measure Global_active_power to plot
globalActivePower <- as.numeric(subData$Global_active_power)

# get the measurew Global recative power
globalReactivePower <- as.numeric(subData$Global_reactive_power)

# get the measure Voltage
voltage <- as.numeric(subData$Voltage)

#get the sub meterings
subMetering1 <- as.numeric(subData$Sub_metering_1)
subMetering2 <- as.numeric(subData$Sub_metering_2)
subMetering3 <- as.numeric(subData$Sub_metering_3)

#get the png height and width & parameters to drsw 2 X 2
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# plot against datetime and global active power
plot(dateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

#plot against date time and voltage
plot(dateTime, voltage, type="l", xlab="datetime", ylab="Voltage")

# plot against datetime and sub meetering
plot(dateTime, subMetering1, type="l", ylab="Energy sub metering", xlab="")
lines(dateTime, subMetering2, type="l", col="red")
lines(dateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

#plot against datetime and global reactive power
plot(dateTime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

#close device
dev.off()