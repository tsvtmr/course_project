#downloading the file
if(!file.exists("./project_data")){dir.create("./project_data")}
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./project_data/dataset.zip", method = "curl")

#unzip file
unzip(zipfile="./project_data/dataset.zip",exdir="./project_data")
filepath <- file.path("./project_data/UCI HAR Dataset")
files<-list.files(filepath, recursive=TRUE)

#activity data files
ActivityTestData <- read.table(file.path(filepath, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrainData <- read.table(file.path(filepath, "train" , "Y_train.txt" ),header = FALSE)

#subject data files
SubjectTestData <-read.table(file.path(filepath, "test" , "subject_test.txt"),header = FALSE)
SubjectTrainData <- read.table(file.path(filepath, "train", "subject_train.txt"),header = FALSE)

#features data files
FeaturesTestData <-read.table(file.path(filepath, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrainData <- read.table(file.path(filepath, "train" , "X_train.txt" ),header = FALSE)


# #exploring data
# head(ActivityTestData)
# head(ActivityTrainData)
# head(SubjectTestData)
# head(SubjectTrainData)
# head(FeaturesTestData)
# head(FeaturesTrainData)

#merging
SubjectData <-rbind(SubjectTestData, SubjectTrainData)
ActivityData <- rbind(ActivityTestData, ActivityTrainData)
FeaturesData <- rbind(FeaturesTestData, FeaturesTrainData)

#naming
names(SubjectData)<-c("subject")
names(ActivityData)<-c("activity")
DataFeaturesNames <- read.table(file.path(filepath, "features.txt"),head=FALSE)
names(FeaturesData)<- DataFeaturesNames$V2

MergedData <- cbind(SubjectData, ActivityData)
Data <- cbind(FeaturesData, MergedData)

SubDataFeaturesNames<-DataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", DataFeaturesNames$V2)]
SelectedNames<-c(as.character(SubDataFeaturesNames), "subject", "activity")
Data<-subset(Data,select=SelectedNames)


#naming the activities in the data set
ActivityLabels <- read.table(file.path(filepath, "activity_labels.txt"),header = FALSE)
Data$activity <-  ActivityLabels[match(Data$activity, ActivityLabels$V1),'V2']

#label dataset with descr var names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


#create a second, independent tidy data set with the average of each variable for each activity and each subject
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
View(Data2)
