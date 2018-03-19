#Exploratory Data Analysis - Johns Hopkins University

#Plot 3
data_loc <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(data_loc, temp)
pwr_data <- read.table(unz(temp, filename = "household_power_consumption.txt"), header=TRUE, sep=";")
unlink(temp)

pwr_data$Global_active_power <- as.numeric(as.character(pwr_data$Global_active_power))
pwr_data$Date <- as.Date(pwr_data$Date, format="%d/%m/%Y")
sub_data <- subset(pwr_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
sub_data$Sub_metering_1 <- as.numeric(as.character(sub_data$Sub_metering_1))
sub_data$Sub_metering_2 <- as.numeric(as.character(sub_data$Sub_metering_2))
sub_data$Sub_metering_3 <- as.numeric(as.character(sub_data$Sub_metering_3))

sub_data$Date <- as.character(sub_data$Date)
sub_data$Time <- as.character(sub_data$Time)

len <- length(sub_data$Date)
date_time <- as.vector(NULL)
for(i in 1:len){
  date_time[i] <- paste(sub_data$Date[i], sub_data$Time[i])
  date_time <- c(date_time, date_time[i])
}

date_time2 <- strptime(date_time, "%Y-%m-%d %H:%M:%S")
new_data <- cbind(sub_data, date_time2[1:2880])

png('plot3.png', width=480, height=480)
with(new_data, plot(date_time2[1:2880], new_data$Sub_metering_2, pch="", xlab="", ylab="Energy sub metering", yaxt="n", ylim=c(-0.5,38)))
lines(new_data$date_time2[1:2880], new_data$Sub_metering_1, yaxt="n")
lines(new_data$date_time2[1:2880], new_data$Sub_metering_2, col="red", yaxt="n")
lines(new_data$date_time2[1:2880], new_data$Sub_metering_3, col="blue", yaxt="n")
v1 <- c(0,10,20,30)
v2 <- c("0","10","20","30")
axis(side=2, at=v1, labels=v2)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1))
dev.off()