#Plot 3

# Add a reference to Plot1 file since the function to download and create filtered dataset is part of plot1
# This way repeating the code to download and creating the filtered dataset is avoided 
source("plot1.R")

# Get the filtered dataset file by calling getDataset() method defined in Plot1.R file
hpc_ds <- getDataset()

# Draw Plot 3

plot(hpc_ds$Time, hpc_ds$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(hpc_ds$Time, hpc_ds$Sub_metering_2, type = "l", col = "red")
points(hpc_ds$Time, hpc_ds$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"), legend = names(hpc_ds)[7:9])

# Copy the plot into png format with the specified width and height
dev.copy(png, file = "plot3.png", width=480, height=480)

# Set the device off
dev.off()
