#setting working directory
setwd("~/Project")
tempf <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = tempf, mode = "b", method = "curl")
#cleaning files
unzip(tempf)
unlink(tempf)


data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ';', na.strings="?")
data2 <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data[,1] <- as.POSIXct(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S", tz = "GMT" )
library(dplyr)
date1 <- as.POSIXct('2007-02-01')
date2 <- as.POSIXct('2007-02-02')
data <- filter(data, Date >= date1, Date <= date2)

for (i in 3:9) {
  data[,i] <- as.double(data[,i])
}

setwd("ExData_Plotting1/figure")
png(file = "plot3.png",width = 480, height = 480, units = "px")
par(mar=c(5.1,4.1,4.1,2.1))
plot(data$Date,data$Sub_metering_1, typ="l", ylab="Energy sub metering", xlab = "", xaxt = "n", col = "black", ylim=c(0,40))
par(new = TRUE)
plot(data$Date,data$Sub_metering_2, typ="l", ylab="Energy sub metering", xlab = "", xaxt = "n", col = "red", ylim=c(0,40))
par(new = TRUE)
plot(data$Date,data$Sub_metering_3, typ="l", ylab="Energy sub metering", xlab = "", xaxt = "n", col = "blue", ylim=c(0,40))
legend("topright", pch = "__", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

axis(1, at = c(1,2,3), labels = c("THh","Fr", "Sa"))
dev.off()
