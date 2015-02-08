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

data$Global_active_power <- as.numeric(data$Global_active_power) *2/1000

png("plot2.png")
plot(x=data$Time, y=data$Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)") 
lines(x=data$Time, y=data$Global_active_power)
dev.off()