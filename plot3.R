library("data.table");
data <- fread('household_power_consumption.txt', sep = ';', na.strings = "?");

# set date to date type
data$Date = as.Date(data$Date, "%d/%m/%Y");

# subset only 01/02/2007 and 02/02/2007 dates
data <- data[(data$Date >= as.Date("01/02/2007", "%d/%m/%Y") &
                  data$Date < as.Date("03/02/2007", "%d/%m/%Y")),]

# set date and time to POSIXct type
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S"));

# plot to png
png(filename = "plot3.png", width = 480, height = 480);

plot(data$DateTime, data$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering");
lines(data$DateTime, data$Sub_metering_1, col = "black");
lines(data$DateTime, data$Sub_metering_2, col = "red");
lines(data$DateTime, data$Sub_metering_3, col = "blue");
legend("topright", col = c("black", "red", "blue"), lty = "solid",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
dev.off();
