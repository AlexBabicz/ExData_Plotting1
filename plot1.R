# Download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

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

# Making Plot 1
hist(hpc_relevant$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Copy the plot to a PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
