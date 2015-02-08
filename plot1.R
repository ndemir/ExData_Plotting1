url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "data.zip"
if (!file.exists(fileName)){
  download.file(url=url, destfile=fileName, method="curl")
}

data <- read.csv(unz("data.zip", "household_power_consumption.txt"), sep = ";")

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, (Date=="2007-02-01" | Date=="2007-02-02"))
data$Global_active_power <- as.numeric(data$Global_active_power)
png("plot1.png")
hist(data$Global_active_power*2/1000, col='red', xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
