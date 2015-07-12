#read data
data<-read.csv("household_power_consumption.txt", sep=";", na.strings="?")

#convert data and time
date<-as.character(data[,1])
#select relevant date
data[,1]<-date
select<-data[(data[,1]=="1/2/2007")|(data[,1]=="2/2/2007"),]

#plot
png(filename="plot1.png",width=480,height=480,units="px")
with(select,hist(Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red"))
dev.off()