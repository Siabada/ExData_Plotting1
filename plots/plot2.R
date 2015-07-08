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

# plot 2
png(filename="plot2.png", width=480, height=480)
plot(data$Global_active_power, type="lines",
     axes=FALSE,
     ann=FALSE)
title(ylab="Global Active Power (kilowatts)")
axis(1, at=c(0, length(data$Global_active_power)/2, length(data$Global_active_power)), labels=c("Thu", "Fri", "Sat"))
axis(2, at=2*0:max(data$Global_active_power), las=0)
box()
dev.off()