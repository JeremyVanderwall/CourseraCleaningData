#download the data
FileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileURL, destfile = "courseraTemp.zip", mode = "wb")
unzip("courseraTemp.zip")

#load data into dataframes
testData <- read.csv(".\\UCI HAR Dataset\\test\\X_test.txt",sep = "", header = FALSE)
testLabels <- read.csv(".\\UCI HAR Dataset\\test\\y_test.txt",sep = "", header = FALSE)
subjectTestData <- read.csv(".\\UCI HAR Dataset\\test\\subject_test.txt",sep = "", header = FALSE)
testData <- cbind(testLabels, testData)
testData <- cbind(subjectTestData, testData)

trainData <- read.csv(".\\UCI HAR Dataset\\train\\X_train.txt",sep = "", header = FALSE)
trainLabels <- read.csv(".\\UCI HAR Dataset\\train\\y_train.txt",sep = "", header = FALSE)
subjectTrainData <- read.csv(".\\UCI HAR Dataset\\train\\subject_train.txt",sep = "", header = FALSE)
trainData <- cbind(trainLabels, trainData)
trainData <- cbind(subjectTrainData, trainData)

Header <- read.csv(".\\UCI HAR Dataset\\features.txt",sep = " ", header = FALSE)
Header$V2 <- as.character(Header$V2)
Header <- rbind(c(1,"Activity"), Header)
Header <- rbind(c(1,"Subject"), Header)
names(trainData) <- Header$V2
names(testData) <- Header$V2
fullData <- rbind(testData, trainData)

myData <- fullData[ , grep(".*mean.*", names(fullData))]
myData <- cbind(myData, fullData[, grep(".*std().*", names(fullData))])

myData <- cbind(fullData$Activity, myData)
myData <-cbind(fullData$Subject, myData)

myData$`fullData$Subject` <- as.factor(myData$`fullData$Subject`)
myData$`fullData$Activity` <- as.factor((myData$`fullData$Activity`))


test <- rowMeans(myData[,3:81])
newData <- cbind(fullData$Subject, fullData$Activity, test)
newData <- data.frame(newData)
newData$V1 <- as.factor(newData$V1)
newData$V2 <- as.factor(newData$V2)

avgData <- data.frame(subject = integer(), activity = integer(), avg = numeric())

for (subject in levels(newData$V1)){
  for (activity in levels(newData$V2)){
    tmp <- mean(newData[newData$V1 == subject & newData$V2 == activity, 3])
    
    avgData <- rbind (avgData, c(subject, activity, tmp))
  }
}
