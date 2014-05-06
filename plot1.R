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

## Plot the histogram of Global Active Power

png(file ="plot1.png", width = 480, height = 480)
hist(cons.Feb2007$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()