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

#copy[,1]<-wday(as.Date(select[,1]),label=TRUE)

#plot
png(filename="plot3.png",width=480,height=480,units="px")
with(combine,plot(Date,measure,type="l",ylab="Energy sub metering",col="white"))
with(subset(combine,meter==1),points(Date,measure,col="black",type="l"))
with(subset(combine,meter==2),points(Date,measure,col="red",type="l"))
with(subset(combine,meter==3),points(Date,measure,col="blue",type="l"))
legend("topright",lty=c(1,1),c("Sub_metering1","Sub_metering2","Sub_metering3"),col=c("black","red","blue"))

dev.off()