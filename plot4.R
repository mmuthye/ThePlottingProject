#Plot 4

# Add a reference to Plot1 file since the function to download and create filtered dataset is part of plot1
# This way repeating the code to download and creating the filtered dataset is avoided 
source("plot1.R")

# Get the filtered dataset file by calling getDataset() method defined in Plot1.R file
hpc_ds <- getDataset()

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
