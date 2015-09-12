#	plot4.R written by Jakub Warszawski for Exploratory Data Analysis course at Coursera.
#	date: 12.09.2015

# Making sure we have the correct data at hand
if (!file.exists("exdata-data-household_power_consumption.zip")){
	print("Data file not found! Starting download...")
	url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	destfile <- "exdata-data-household_power_consumption.zip"
	download.file(url, destfile)
	unzip(destfile)
	print("Data downloaded and unzipped, progressing with analysis...")
}else{
	print("File exists, continue with analysis...")
	}

# read only the lines with date 1/2/2007 and 2/2/2007.
# the usage of 'pipe' and 'grep' commands assume either NIX environment or installed GitBAsh on windows.
df<-read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),sep=";")
# setting the column names correctly by extracting them from the header
l <- read.csv("household_power_consumption.txt",nrows=1,sep=c(";","."))
names(df)<-names(l)
rm(l)
# Converting Date and Time to Posix Standard
df$DateTime<-strptime(paste(df$Date, df$Time),"%d/%m/%Y %H:%M:%S")
Sys.setlocale("LC_TIME", "English")

# Begin the plotting
# open the png-device
png(filename = "plot4.png")
# setting number of plots and correct margins
par(mfrow=c(2,2),mar=c(4,4,4,2),oma=c(0,0,2,0))
# graph 1,1
plot(df$DateTime,df$Global_active_power,type="n",ylab="Global Active Power",xlab="")
lines(df$DateTime,df$Global_active_power,type="s")
# graph 1,2
plot(df$DateTime,df$Voltage,type="s",xlab="datetime",ylab="Voltage")
# graph 2,1
plot(df$DateTime,df$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(df$DateTime,df$Sub_metering_1,type="s")
lines(df$DateTime,df$Sub_metering_2,type="s",col="red")
lines(df$DateTime,df$Sub_metering_3,type="s",col="blue")
lableNames<-names(df)[7:9]
legend("topright",pch="____",col=c("black","red","blue"),legend=lableNames)
# graph 2,2
plot(df$DateTime,df$Global_reactive_power,type="s",xlab="datetime",ylab="Global_reactive_power")
# close the device which saves the png-file
dev.off()

