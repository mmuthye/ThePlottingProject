#Plot 4

# Import the required libraries, if any
library(dplyr)
library(data.table)

# Define the hard values to be used in the code, 
# includes - URL to the dataset, dataset filename and the dates to be filtered
DatasetURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
DatasetZip <- "exdata_data_household_power_consumption.zip"
DatasetFilename <- "household_power_consumption.txt" 
DateFilter <- "^[1,2]/2/2007"   # Expression for dates: 1/2/2007 and 2/2/2007

# Check if the dataset already exists / downloaded. If not, then download the file 
if (!file.exists(DatasetFilename)) {
        download.file(DatasetURL, DatasetZip)
        unzip(DatasetZip)
} 

# Load the Household Power Consumption (hpc) dataset. 
# Below considerations are made:
# 1. Instead of loading the entire dataset, rows with dates 1/2/2007 OR 2/2/2007 are filtered
# 2. Column names are required to be set since the headers got filtered out due to #1 above
# 3. na.strings set to ? since ? is indicating missing data

hpc_ds <- read.table(text = grep(DateFilter, readLines(DatasetFilename), value=TRUE), sep = ';', na.strings = '?', 
                     col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Convert the Time and Date columns from character to Date and Time formats.
# Note: Time needs to be convered into Date Time function
hpc_ds <- mutate(hpc_ds, Time = strptime(paste(Date, Time, sep = " "), "%d/%m/%Y %H:%M:%S"))
hpc_ds <- mutate(hpc_ds, Date = as.Date(Date, "%d/%m/%Y"))

# Remove the unwanted variables that will no longer be required to free up memory
rm(hpc)

# Draw Plot 4

# Define a 2x2 sized frame for plotting 4 different graphs
par(mfrow = c(2,2))

# Plot the 4 graphs
#Graph-1
plot(hpc_ds$Time, hpc_ds$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

#Graph-2
plot(hpc_ds$Time, hpc_ds$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

#Graph-3 - Includes points and legend added to the plot
plot(hpc_ds$Time, hpc_ds$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(hpc_ds$Time, hpc_ds$Sub_metering_2, type = "l", col = "red")
points(hpc_ds$Time, hpc_ds$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"), legend = names(hpc_ds)[7:9], bty = "n", cex = 0.5) 

#Graph-4
plot(hpc_ds$Time, hpc_ds$Global_reactive_power, type = "l", ylab = "Global reactive power", xlab = "datetime")


# Copy the plot into png format with the specified width and height
dev.copy(png, file = "plot4.png", width=480, height=480)

# Set the device off
dev.off()
