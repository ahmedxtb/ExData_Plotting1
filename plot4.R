## Set language to English (was french)

Sys.setlocale(locale = "en_GB.UTF-8")

## Load necessary package

require("sqldf")

## Read only the data from the date 2007-02-01 and 2007-02-01 in "household_power_consumption.txt"

sql_query <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
cons.Feb2007 <- read.csv2.sql("household_power_consumption.txt", sql_query, connection = NULL)

## Create a new column in cons.Feb2007 with date/time in POSIXct format

cons.Feb2007$Date_Time <- paste(cons.Feb2007$Date, cons.Feb2007$Time, sep = " ")
cons.Feb2007$Date_Time <- as.POSIXct(strptime(cons.Feb2007$Date_Time, format = "%d/%m/%Y %H:%M:%S"))

## Plot four graphs in 2 x 2 format

png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(cons.Feb2007, {
    plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    plot(Date_Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
})
with(cons.melt, plot(Date_Time, value, xlab = "", ylab = "Energy sub metering", type = "n"))
with(subset(cons.melt, variable == "Sub_metering_1"), lines(Date_Time, value))
with(subset(cons.melt, variable == "Sub_metering_2"), lines(Date_Time, value, col = "red"))
with(subset(cons.melt, variable == "Sub_metering_3"), lines(Date_Time, value, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(cons.Feb2007, plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()