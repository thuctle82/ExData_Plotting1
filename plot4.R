# Note:  in order to execute this script, you should download 
# and unzip the source data into your working directory.  
# Also the script use the r package sqldif so that package must also be installed prior
# to running the script.

library(sqldf)
#read data for only the 2 days in February
data1 <- read.csv.sql("./household_power_consumption.txt", sep=";", sql="select * from file where Date in ('1/2/2007','2/2/2007')")

#transform Date from string to date
data1 <- transform(data1,Date=as.Date(Date,"%d/%m/%Y"))

#transform Time from string to datetime
data1 <- transform(data1,Time=strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S"))

#plot4
png(file="./plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))
with(data1, {
  plot(Time, Global_active_power, type="l",xlab="", ylab="Global Active Power")
  plot(Time, Voltage, type="l",xlab="datetime", ylab="Voltage")
  plot(Time,Sub_metering_1,type="l",col="black", xlab="",ylab="Energy sub merting")
  points(Time,Sub_metering_2,type='l',col="red")
  points(Time,Sub_metering_3,type='l',col="blue")
  legend("topright", pch = "_", bty="n", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(Time, Global_reactive_power, type="l",xlab="datetime", ylab="Global_reactive_power")
})
dev.off()