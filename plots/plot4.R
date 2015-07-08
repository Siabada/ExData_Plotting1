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

# plot 4
png(filename="plot4.png", width=480, height=480)
# plot 4 
par(mfrow=c(2,2))
# 4.1
plot(data$Global_active_power, type="lines",
     axes=FALSE,
     ann=FALSE)
title(ylab="Global Active Power")
axis(1, at=c(0, length(data$Global_active_power)/2, length(data$Global_active_power)), labels=c("Thu", "Fri", "Sat"))
axis(2, at=0.1*0.0:0.5, las=0)
box()

# 4.2
plot(data$Voltage, type="lines",
     xlab="datetime",
     ylab="Voltage",
     axes=FALSE)
axis(1, at=c(0, length(data$Voltage)/2, length(data$Voltage)), labels=c("Thu", "Fri", "Sat"))
axis(2, at=2*0:max(data$Voltage), las=0)
box()

# 4.3
plot(data$Sub_metering_1, type="lines",
     axes=FALSE, ann=FALSE)
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")
axis(1, at=c(0, length(data$Global_active_power)/2, length(data$Global_active_power)), labels=c("Thu", "Fri", "Sat"))
axis(2, at=10*0:max(data$Sub_metering_1), las=0)
title(ylab="Energy sub metering")
box()
legend("topright", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       bty="n",
       cex=0.9,
       col=c("black", "red", "blue"), lty=1)
# 4.4
plot(data$Global_reactive_power, type="lines",
     xlab="datetime",
     ylab="Global_reactive_power",
     axes=FALSE)
axis(1, at=c(0, length(data$Global_reactive_power)/2, length(data$Global_reactive_power)), labels=c("Thu", "Fri", "Sat"))
axis(2, at=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5), las=0)
box()
dev.off()
