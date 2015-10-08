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

#plot2 
png(file="./plot2.png",width = 480, height = 480)
with(data1,plot(Time,Global_active_power,type="n",ylab="Global Active Power (kilowatts)", xlab=""))
lines(data1$Time,data1$Global_active_power)
dev.off()