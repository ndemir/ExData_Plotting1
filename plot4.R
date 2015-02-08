url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "data.zip"
if (!file.exists(fileName)){
  download.file(url=url, destfile=fileName, method="curl")
}

data <- read.csv(unz("data.zip", "household_power_consumption.txt"), sep = ";")

data$Time <- paste(data$Date, data$Time)
data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S")

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, (Date=="2007-02-01" | Date=="2007-02-02"))

data$Global_active_power <- as.numeric(data$Global_active_power)*2/1000

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)


png("plot4.png")
par(mfrow=c(2,2))

plot(x=data$Time, y=data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(x=data$Time, y=data$Global_active_power)

plot(x=data$Time, y=data$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(x=data$Time, y=data$Voltage)

plot(x=c(data$Time, data$Time, data$Time) , y=c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3), type="n", xlab = "", ylab = "Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = c("_", "_", "_"), col=c("black", "red", "blue"))
lines(x=data$Time, y=data$Sub_metering_1, col="black")
lines(x=data$Time, y=data$Sub_metering_2, col="red")
lines(x=data$Time, y=data$Sub_metering_3, col="blue")

plot(x=data$Time, y=data$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power")
lines(x=data$Time, y=data$Global_reactive_power)
dev.off()

