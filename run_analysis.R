## 0. read data
    # set up path parameters
library(dplyr)
RootPath  <- "../UCI HAR Dataset"
TrainPath <- paste0(RootPath,"/train")
TestPath  <- paste0(RootPath,"/test")

    # read features.txt and activity_labels.txt
FeatureFile <- paste0(RootPath,"/features.txt")
ActivityLabelFile <- paste0(RootPath,"/activity_labels.txt")
Features <- read.table(FeatureFile, header = FALSE, stringsAsFactors = FALSE)
ActivityLabel <- read.table(ActivityLabelFile,header=FALSE,stringsAsFactors=FALSE)

    # read x_train, y_train, subject_train
TrainFiles <- dir(TrainPath, pattern = "txt") %>%
              sapply(function(x){paste0(TrainPath,"/",x)})
TrainData <-  lapply(TrainFiles,
              function(x){read.table(x,header=FALSE,stringsAsFactors=FALSE)})

    # read x_test, y_test, subject_test
TestFiles <- dir(TestPath, pattern = "txt") %>%
             sapply(function(x){paste0(TestPath,"/",x)})
TestData <-  lapply(TestFiles,
             function(x){read.table(x,header=FALSE,stringsAsFactors=FALSE)})

## 1. Merges the training and the test sets to create one data set
XY_train <- mutate(TrainData$X_train.txt, label=TrainData$y_train.txt$V1)
IdXY_train <- cbind(TrainData$subject_train.txt$V1, XY_train)
names(IdXY_train)[1] <- "Id"

XY_test <- mutate(TestData$X_test.txt, label=TestData$y_test.txt$V1)
IdXY_test <- cbind(TestData$subject_test.txt$V1, XY_test)
names(IdXY_test)[1] <- "Id"

IdXY_All <- rbind(IdXY_train, IdXY_test)

## 2. Get only the measurements on the mean and standard deviation for each measurement
