#	plot3.R written by Jakub Warszawski for Exploratory Data Analysis course at Coursera.
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
png(filename = "plot3.png")
# plot the graph with lines: labels and colors and legend
plot(df$DateTime,df$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(df$DateTime,df$Sub_metering_1,type="s")
lines(df$DateTime,df$Sub_metering_2,type="s",col="red")
lines(df$DateTime,df$Sub_metering_3,type="s",col="blue")
lableNames<-names(df)[7:9]
legend("topright",pch="____",col=c("black","red","blue"),legend=lableNames)
# close the device which saves the png-file
dev.off()

