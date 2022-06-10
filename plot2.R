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
png("plot2.png")

# Plot power vs time
plot(
  hpc_reduced$datetime,
  hpc_reduced$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
  )
dev.off()
