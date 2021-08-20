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

# Making Plot 3
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
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"))

# Copy the plot to a PNG file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
