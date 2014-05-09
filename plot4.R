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

power_df$NewSub_metering_1 = as.numeric (power_df$Sub_metering_1)
power_df$NewSub_metering_2 = as.numeric (power_df$Sub_metering_2)
power_df$NewSub_metering_3 = as.numeric (power_df$Sub_metering_3)
power_df$NewVoltage = as.numeric (power_df$Voltage)
power_df$NewGlobal_reactive_power = as.numeric (power_df$Global_reactive_power)


#plot4

# Set 4 plots for the window and the margins
par(mfcol = c(2,2), mar=c(4.1,4.1,2.1,2.1)
    )

# Plot to the defaults device
# 1st plot
plot (power_df$NewDateTime, 
      power_df$NewGlobal_active_power, 
      xlab = "", ylab = "Global Active Power", main = "", type="l", 
      cex = .01, lwd = .01, cex.lab = .85)

# 2nd plot
plot (power_df$NewDateTime, 
      power_df$NewSub_metering_1, 
      xlab = "", ylab = "Energy sub metering", 
      main = "", type="l", cex = .01, lwd = .01, cex.lab = .85, col = "Black")

lines (power_df$NewDateTime, 
       power_df$NewSub_metering_2, 
       type="l", cex = .01, lwd = .01, cex.lab = .85, col = "Red")

lines (power_df$NewDateTime, 
       power_df$NewSub_metering_3, 
       type="l", cex = .01, lwd = .01, cex.lab = .85, col = "Blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, cex = .6, col = c("Black", "Red", "Blue"), bty = "n")

# 3rd plot
plot (power_df$NewDateTime, 
      power_df$NewVoltage, 
      xlab = "datetime", ylab = "Voltage", main = "", type="l", 
      cex = .01, lwd = .01, cex.lab = .85)

# 4th plot
plot (power_df$NewDateTime, 
      power_df$NewGlobal_reactive_power, 
      xlab = "datetime", ylab = "Global_reactive_power", main = "", type="l", 
      cex = .01, lwd = .01, cex.lab = .85)

# Copy the plot to a png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)

# Close the device
dev.off()