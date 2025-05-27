#Loading required packages

library(dplyr)

#Download the dataset

filename <- "Coursera_DS3_Final.zip"

# Checking if archive already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

# Checking if folder exists and unzipping data
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Reading all files

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

#Merge training and test sets to create one data set.

x_fulldata <- rbind(x_train,x_test)
y_fulldata <- rbind(y_train,y_test)
subject_fulldata <- rbind(subject_train,subject_test)
fulldata <-cbind(subject_fulldata,y_fulldata,x_fulldata)

#Extract only the measurements on the mean and standard deviation for each measurement. 
fulldata <- fulldata %>% select(subject, code, contains("mean"), contains("std"))

#Use descriptive activity names to name the activities in the data set
fulldata$code <- activities[fulldata$code, 2]

#Appropriately label the data set with descriptive variable names. 
names(fulldata)[2] = "activity"
names(fulldata)<-gsub("Acc", "Accelerometer", names(fulldata))
names(fulldata)<-gsub("Gyro", "Gyroscope", names(fulldata))
names(fulldata)<-gsub("BodyBody", "Body", names(fulldata))
names(fulldata)<-gsub("Mag", "Magnitude", names(fulldata))
names(fulldata)<-gsub("^t", "Time", names(fulldata))
names(fulldata)<-gsub("^f|Freq", "Frequency", names(fulldata))
names(fulldata)<-gsub("tBody", "TimeBody", names(fulldata))
names(fulldata)<-gsub("mean", "Mean", names(fulldata), ignore.case = TRUE)
names(fulldata)<-gsub("std", "StandardDeviation", names(fulldata), ignore.case = TRUE)
names(fulldata)<-gsub("angle", "Angle", names(fulldata))
names(fulldata)<-gsub("gravity", "Gravity", names(fulldata))
names(fulldata)<-gsub("[.]", "", names(fulldata))

#Create a data set with the average of each variable for each activity and each subject.
finaldata <- fulldata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(finaldata, "FinalData.txt", row.name=FALSE)
