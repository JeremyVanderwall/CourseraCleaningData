#download the data
FileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileURL, destfile = "courseraTemp.zip", mode = "wb")
unzip("courseraTemp.zip")

#load data into dataframes
testData <- read.csv(".\\UCI HAR Dataset\\test\\X_test.txt",sep = " ", header = FALSE)
testLabels <- read.csv(".\\UCI HAR Dataset\\test\\y_test.txt",sep = " ", header = FALSE)
subjectTestData <- read.csv(".\\UCI HAR Dataset\\test\\subject_test.txt",sep = " ", header = FALSE)
testData <- cbind(subjectTestData, testData)

trainData <- read.csv(".\\UCI HAR Dataset\\train\\X_train.txt",sep = " ", header = FALSE)
subjectTrainData <- read.csv(".\\UCI HAR Dataset\\train\\subject_train.txt",sep = " ", header = FALSE)
trainData <- cbind(subjectTrainData, trainData)

Header <- read.csv(".\\UCI HAR Dataset\\features.txt",sep = " ", header = FALSE)
names(trainData) <- Header$V2
fullData <- rbind(testData, trainData)
