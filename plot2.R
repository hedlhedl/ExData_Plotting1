library(lubridate)

#read data
data<-read.csv("household_power_consumption.txt", sep=";", na.strings="?")

#convert data and time
date<-as.character(data[,1])
#select relevant date
data[,1]<-date
select<-data[(data[,1]=="1/2/2007")|(data[,1]=="2/2/2007"),]
date<-as.character(select[,1])
time<-as.character(select[,2])
dt<-paste(date,time)
timeconvert<-dmy_hms(dt) #strptime(dt,format="%d/%m/%Y %H:%M:%S")
copy<-select 
copy[,1]<-timeconvert 



#copy[,1]<-wday(as.Date(select[,1]),label=TRUE)

#plot
png(filename="plot2.png",width=480,height=480,units="px")
with(copy,plot(Date,Global_active_power,ylab="Global Active Power (kilowatts)", type="l"))
dev.off()