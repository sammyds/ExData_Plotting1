# The following file has to be downloaded and unzipped into the working directory
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# After unzipping the downloaded file, make sure the file "household_power_consumption.txt"
#   exists in the working directory

# Since we required data from only 1-Feb-2007 and 2-Feb-2007, only 100000 rows are loaded
#   into memory. That dataset contains the required data. Loading the entire data takes
#   some time. 
tmp_df = read.table ("household_power_consumption.txt",
                     header=TRUE,sep=";"
                     ,nrows=100000
                     ,colClasses = "character"
)

# Subset the data to get the data for the required dates
power_df = subset (tmp_df,
                   tmp_df$Date == "1/2/2007" | tmp_df$Date == "2/2/2007")

# Add new varaibles with the data converted from character to the proper data type
power_df$NewDate = as.Date (power_df$Date, format = "%d/%m/%Y")
power_df$NewGlobal_active_power = as.numeric (power_df$Global_active_power)
power_df$NewDateTime = strptime(paste (
  power_df$Date,
  power_df$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

#plot2

# Set only one plot for the window and the size of the plot
par(mfrow = c(1,1))
windows.options (width = 480, height = 480)

# Open the device and plot
png (file = "plot2.png")
plot (power_df$NewDateTime, 
      power_df$NewGlobal_active_power, 
      xlab = "", ylab = "Global Active Power (kilowatts)", main = "", type="l", 
      cex = .01, lwd = .01, cex.lab = .85)

# Close the device
dev.off()