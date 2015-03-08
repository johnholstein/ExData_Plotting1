#setting working directory
setwd("~/Project")
tempf <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = tempf, mode = "b", method = "curl")
#cleaning files
unzip(tempf)
unlink(tempf)


data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ';', na.strings="?")
data[,1] <- as.Date(data[,1], format("%d/%m/%Y"))
for (i in 2:9) {
  data[,i] <- as.double(data[,i])
}

library(dplyr)
date1 <- as.Date('2007-02-01')
date2 <- as.Date('2007-02-02')
data <- filter(data, Date >= date1, Date <= date2)
setwd("ExData_Plotting1/figure")
png(file = "plot1.png",width = 480, height = 480, units = "px")
with(data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim=c(0,1200)))
dev.off()
