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

# Defaults for png are already as specified:
# width = 480, height = 480, units = "px"
png("plot1.png")

# Plot histogram
hist(
  hpc_reduced$Global_active_power,
  xlab = "Global Active Power (kilowatts)",
  main = "Global Active Power",
  col = "red"
  )
dev.off()
