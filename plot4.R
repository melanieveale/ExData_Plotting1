# Read in the data
data_path = "/domino/datasets/local/R-learning-sandbox/ExData_Plotting1/household_power_consumption.txt"
hpc = read.csv(data_path, sep = ";", na.strings = "?")
print("Raw HPC data has dim:")
print(dim(hpc))

# Subset it to the two dates we care about
library("dplyr") 
hpc_reduced = subset(
  hpc,
  between(as.Date(hpc$Date, format = "%d/%m/%Y"), as.Date("2007-02-01"), as.Date("2007-02-02"))
  )
print("Reduced HPC data has dim:")
print(dim(hpc_reduced))

# Get a proper datetime column
hpc_reduced$datetime = as.POSIXct(
  paste(hpc_reduced$Date, hpc_reduced$Time), 
  format="%d/%m/%Y %H:%M:%S"
  )

# Defaults for png are already as specified:
# width = 480, height = 480, units = "px"
png("plot4.png")

# Initialize panels
par(
  mfrow = c(2,2)
)

# Plot 2 again
plot(
  hpc_reduced$datetime,
  hpc_reduced$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

# Now voltage instead
plot(
  hpc_reduced$datetime,
  hpc_reduced$Voltage,
  type = "l",
  xlab = "",
  ylab = "Voltage"
)

# Plot 3 again
sm_columns = paste("Sub_metering", c(1,2,3), sep = "_")
sm_colors = c("black", "red", "blue")
# Initializing with Sub_metering_1 works because it has the largest y range
plot(
  hpc_reduced$datetime,
  hpc_reduced$Sub_metering_1,
  type="n",
  xlab = "",
  ylab = "Energy sub metering"
  )
for (x in 1:3) {
  lines(
    hpc_reduced$datetime,
    hpc_reduced[[sm_columns[[x]]]],
    col=sm_colors[[x]],
    type="l"
    )
}
legend(
  "topright",
  legend=sm_columns,
  col=sm_colors,
  lty=1
  )

# Now reactive power
plot(
  hpc_reduced$datetime,
  hpc_reduced$Global_reactive_power,
  type = "l",
  xlab = "",
  ylab = "Global Reactive Power"
)


dev.off()

