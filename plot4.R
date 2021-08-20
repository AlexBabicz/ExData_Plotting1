# Read the data
initial <- read.table("./data/household_power_consumption.txt", 
                      header = T, 
                      sep =";",
                      na.strings = "?",
                      nrows = 100)
classes <- sapply(initial, class)
hpc <- read.table("./data/household_power_consumption.txt", 
                  header = T, 
                  sep =";",
                  na.strings = "?",
                  colClasses = classes)
head(hpc)
str(hpc)

# Subset the data
hpc_relevant <- subset(hpc, Date == "1/2/2007" | Date == "2/2/2007")

# Combine and convert the Date and Time variables
hpc_relevant$DateTime <- strptime(paste(hpc_relevant$Date, hpc_relevant$Time), 
                                  "%d/%m/%Y %H:%M:%S")

# Open the PNG device
png(file="plot4.png", width=480, height=480)
# Making Plot 4
par(mfrow = c(2, 2))
# Top left plot aka plot2
plot(hpc_relevant$DateTime, hpc_relevant$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")
# Top right plot
plot(hpc_relevant$DateTime, hpc_relevant$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
# Bottom left plot aka plot3
plot(hpc_relevant$DateTime, hpc_relevant$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(hpc_relevant$DateTime, hpc_relevant$Sub_metering_1,
      col = "black")
lines(hpc_relevant$DateTime, hpc_relevant$Sub_metering_2,
      col = "red")
lines(hpc_relevant$DateTime, hpc_relevant$Sub_metering_3,
      col = "blue")
# Had to adjust the legend position from "topright" manually since it was always
# off
legend(x=max(hpc_relevant$DateTime)-125000, y=max(hpc_relevant$Sub_metering_1)+2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"),
       bty = "n")
# Bottom right plot
plot(hpc_relevant$DateTime, hpc_relevant$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# close the PNG device
dev.off()
