##  Quiz 1

library(data.table)
housing <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
# VAL attribute says how much property is worth, .N is the number of rows
# VAL == 24 means more than $1,000,000
housing[VAL == 24, .N]


## Question 3
##  Download the Excel spreadsheet on Natural Gas Aquisition Program here:
##https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
##Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
dateDownloaded <- date()
dateDownloaded

## Install the xlsx package before running the library.
## install.packages("xlsx")
library(xlsx)

rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx(file="getdata_data_DATA.gov_NGAP.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex, header=TRUE)
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)


## Question 4
# install.packages("XML")
library("XML")
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- XML::xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
rootNode <- XML::xmlRoot(doc)

zipcodes <- XML::xpathSApply(rootNode, "//zipcode", XML::xmlValue)
xmlZipcodeDT <- data.table::data.table(zipcode = zipcodes)
xmlZipcodeDT[zipcode == "21231", .N]

# Answer: 
# 127

## Question 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile="quiz1data4.csv")
library(data.table)
DT <- fread(input="quiz1data4.csv", sep=",")

mean(DT$pwgtp15,by=DT$SEX)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

tapply(DT$pwgtp15,DT$SEX,mean)
sapply(split(DT$pwgtp15,DT$SEX),mean)
DT[,mean(pwgtp15),by=SEX]  ## correct


system.time(mean(DT$pwgtp15,by=DT$SEX), gcFirst = TRUE)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))

