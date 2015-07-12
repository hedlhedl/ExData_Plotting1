library(lubridate)

#read data
data<-read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses = c(rep("character",2),rep("numeric",7)))

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

transform1<-data.frame(Date<-copy[,1],meter<-1,measure<-copy[,7])
names(transform1)<-c("Date","meter","measure")
transform2<-data.frame(Date<-copy[,1],meter<-2,measure<-copy[,8])
names(transform2)<-c("Date","meter","measure")
transform3<-data.frame(Date<-copy[,1],meter<-3,measure<-copy[,9])
names(transform3)<-c("Date","meter","measure")
combine<-rbind(transform1,transform2,transform3)

#set canvas
png(filename="plot4.png",width=480,height=480,units="px")

#plot
par(mfrow=c(2,2))
with(copy,{
    plot(Date,Global_active_power,type="l")
    plot(Date,Voltage,type="l")
    plot(Date,Sub_metering_3,type="l",ylab="Energy Sub metering",col="blue")
      lines(Date,Sub_metering_2,col="red")
      lines(Date,Sub_metering_1,col="black")
      legend("topright",lty=c(1,1),c("Sub_metering1","Sub_metering2","Sub_metering3"),col=c("black","red","blue"))
    plot(Date,Global_reactive_power,type="l")
})



dev.off()