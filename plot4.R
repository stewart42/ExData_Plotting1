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
png(filename = "plot4.png", width = 480, height = 480);

par(mfrow = c(2,2));

plot(data$DateTime, data$Global_active_power, type="l", ylab = "Global Active Power", xlab = "")
plot(data$DateTime, data$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(data$DateTime, data$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering");
lines(data$DateTime, data$Sub_metering_1, col = "black");
lines(data$DateTime, data$Sub_metering_2, col = "red");
lines(data$DateTime, data$Sub_metering_3, col = "blue");
legend("topright", col = c("black", "red", "blue"), lty = "solid",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n");

plot(data$DateTime, data$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime");


dev.off();
