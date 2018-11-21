## 0. read data
TrainPath <- "./train"
TestPath <- "./test"

Features <- read.table("features.txt", header = FALSE, stringsAsFactors = FALSE)
ActivityLabel <- read.table("activity_labels.txt",header=FALSE,stringsAsFactors=FALSE)

TrainFiles <- dir(TrainPath, pattern = "txt")
TrainFiles <- sapply(TrainFiles,function(x){paste(TrainPath,"/",x,sep="")})
TrainData <- lapply(TrainFiles,
                    function(x){read.table(x,header=FALSE,stringsAsFactors=FALSE)})

TestFiles <- dir(TestPath, pattern = "txt")
TestFiles <- sapply(TestFiles,function(x){paste(TestPath,"/",x,sep="")})
TestData <- lapply(TestFiles,
                    function(x){read.table(x,header=FALSE,stringsAsFactors=FALSE)})
