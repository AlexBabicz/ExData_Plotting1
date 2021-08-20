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

# Making Plot 2
plot(hpc_relevant$DateTime, hpc_relevant$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Copy the plot to a PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
