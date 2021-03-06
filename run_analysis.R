## 0. read data
    # set up path parameters
library(dplyr)
library(reshape2)
RootPath  <- "../UCI HAR Dataset"
TrainPath <- paste0(RootPath,"/train")
TestPath  <- paste0(RootPath,"/test")

    # Define read function, making it easier for the later part
ReadData <- function(x){read.table(x,header=FALSE,stringsAsFactors=FALSE)}

    # read features.txt and activity_labels.txt
Features <- ReadData(paste0(RootPath,"/features.txt"))
ActivityLabel <- ReadData(paste0(RootPath,"/activity_labels.txt"))

    # read x_train, y_train, subject_train
TrainFiles <- dir(TrainPath, pattern = "txt")
TrainFiles <- sapply(TrainFiles, function(x){paste0(TrainPath,"/",x)})
TrainData <-  lapply(TrainFiles, ReadData)

    # read x_test, y_test, subject_test
TestFiles <- dir(TestPath, pattern = "txt")
TestFiles <- sapply(TestFiles, function(x){paste0(TestPath,"/",x)})
TestData <-  lapply(TestFiles, ReadData)

## 1. Merges the training and the test sets to create one data set
XY_train <- mutate(TrainData$X_train.txt, label=TrainData$y_train.txt$V1)
IdXY_train <- cbind(TrainData$subject_train.txt$V1, XY_train)
names(IdXY_train)[1] <- "Id"

XY_test <- mutate(TestData$X_test.txt, label=TestData$y_test.txt$V1)
IdXY_test <- cbind(TestData$subject_test.txt$V1, XY_test)
names(IdXY_test)[1] <- "Id"

IdXY_All <- rbind(IdXY_train, IdXY_test)

## 2. Get only the measurements on the mean and standard deviation for each measurement
IsMeanHere <- grepl("mean",Features$V2)
IsStdHere <- grepl("std",Features$V2)
MeanStdIndex <- Features$V1[IsMeanHere | IsStdHere]
MeanStdName <- c("Id","label",names(IdXY_All)[MeanStdIndex+1])
MeanStd <- IdXY_All[MeanStdName]

## 3. Uses descriptive activity names to name the activities in the data set
Label <- character(nrow(MeanStd))
for (i in 1:nrow(ActivityLabel)){
    Label[MeanStd$label==ActivityLabel$V1[[i]]]<-ActivityLabel$V2[[i]]
}
MeanStd$label <- Label

## 4.Appropriately labels the data set with descriptive variable names
Features$V1 <- paste0("V",as.character(Features$V1))


Features$V2 <- make.names(names = Features$V2, unique=TRUE, allow_=TRUE)
# assign an order to duplicated feature names
#  and turn feature names to syntactically valid names
# for example:
# temp <- c("fBodyAcc-bandsEnergy()-1,16",
#           "fBodyAcc-bandsEnergy()-1,16",
#           "fBodyAcc-bandsEnergy()-1,16");
# temp2 <- make.names(names = temp, unique=TRUE, allow_=TRUE)
# temp2 is as below:
#                   [1] "fBodyAcc.bandsEnergy...1.16"
#                   [2] "fBodyAcc.bandsEnergy...1.16.1"
#                   [3] "fBodyAcc.bandsEnergy...1.16.2"


VNameLoc <- grep("V",names(MeanStd))
VNames <- names(MeanStd)[VNameLoc]
names(MeanStd)[VNameLoc] <-sapply(VNames,function(x){Features$V2[Features$V1 %in% x]})

## 5. From the data set in step 4,
 # creates a second, independent tidy data set
 # with the average of each variable for each activity and each subject
MeanStd2 <- melt(MeanStd, id.vars = c("Id","label"))
MeanStd2 <- dcast(MeanStd2, Id + label ~ variable, fun.aggregate = mean)
names(MeanStd2)[c(-1,-2)] <- paste0("Mean.",names(MeanStd2)[c(-1,-2)])

## 6. Output the dataset IdXY_All2
write.table(MeanStd2, file = "TidyDataset.txt", row.name=FALSE)