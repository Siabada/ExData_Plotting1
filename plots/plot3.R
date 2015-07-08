temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, as.is=TRUE)
unlink(temp)

require(dplyr)
require(chron)

data <- filter(data, (Date == "1/2/2007" | Date == "2/2/2007"))
data$Date <- strptime(data$Date, format="%d/%m/%Y")
data$Time <- chron(times = data$Time)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# plot 3
png(filename="plot3.png", width=480, height=480)
plot(data$Sub_metering_1, type="lines",
     axes=FALSE,
     ann=FALSE)
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")
title(ylab="Energy sub metering")
axis(1, at=c(0, length(data$Global_active_power)/2, length(data$Global_active_power)), labels=c("Thu", "Fri", "Sat"))
axis(2, at=10*0:max(data$Sub_metering_1), las=0)
box()
legend("topright", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       cex=0.8, 
       col=c("black", "red", "blue"), lty=1)
dev.off()