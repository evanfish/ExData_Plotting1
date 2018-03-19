#Exploratory Data Analysis - Johns Hopkins University

#Plot 1
data_loc <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(data_loc, temp)
pwr_data <- read.table(unz(temp, filename = "household_power_consumption.txt"), header=TRUE, sep=";")
unlink(temp)

pwr_data$Global_active_power <- as.numeric(as.character(pwr_data$Global_active_power))
pwr_data$Date <- as.Date(pwr_data$Date, format="%d/%m/%Y")

sub_data <- subset(pwr_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

png('plot1.png', width=480, height=480)
hist(sub_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()