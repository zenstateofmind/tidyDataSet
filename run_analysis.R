# 1. Merges the training and the test sets to create one data set.
createDataSet <- function() {
     features <<- read.table("UCI HAR Dataset/features.txt")
     activityLabels <<- read.table("UCI HAR Dataset/activity_labels.txt")
     trainingDataSet <- createTrainingDataSet()
     testDataSet <- createTestDataSet()
     dataSet <- rbind(trainingDataSet, testDataSet)     
}

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
extractMeasurementsWithMeanAndStdDev <- function(dataSet) {
     validFeatureIndices <- which(sapply(features[,2], wordContainsMeanOrStdDev))
     extractedColumns <- c(validFeatureIndices,ncol(dataSet)-1, ncol(dataSet))
     extractedMeasurements <- dataSet[, extractedColumns]
     extractedMeasurements
}

# Training Set
createTrainingDataSet <- function() {
     XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
     #4. Appropriately labels the data set with descriptive variable names. 
     colnames(XTrain) <- features[,2]
     
     YTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
     # 3. Uses descriptive activity names to name the activities in the data set
     Activity <- sapply(YTrain[,], activity)
     ActivityDF <- data.frame(Activity)
     
     subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
     colnames(subjectTrain) <- "Subject"
     
     trainingDataSet <- cbind(XTrain, subjectTrain, ActivityDF)
     trainingDataSet
}

#Test set
createTestDataSet <- function() {
     XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
     #4. Appropriately labels the data set with descriptive variable names. 
     colnames(XTest) <- features[,2]
     
     YTest <- read.table("UCI HAR Dataset/test/y_test.txt")
     # 3. Uses descriptive activity names to name the activities in the data set
     Activity <- sapply(YTest[,], activity)
     ActivityDF <- data.frame(Activity)
     
     subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
     colnames(subjectTest) <- "Subject"
     
     testDataSet <- cbind(XTest, subjectTest, ActivityDF)
     testDataSet
}

activity <- function(num) {
   activityLabels[which(activityLabels[1] == num), 2]  
}

wordContainsMeanOrStdDev <- function(word) {
     grepl("mean\\(\\)", word) || grepl("std\\(\\)", word)
}

main <- function() {
     dataSet <- createDataSet()
     extractedMeasurements <- extractMeasurementsWithMeanAndStdDev(dataSet)
     influencingVariables <- c("Subject", "Activity")
     variables <- colnames(extractedMeasurements)[1:(length(extractedMeasurements)-2)]
     # 5. From the data set in step 4, creates a second, independent tidy data set with the 
     # average of each variable for each activity and each subject.
     tidyDataSet <- aggregate(extractedMeasurements[variables], by=extractedMeasurements[influencingVariables], FUN=mean)
     tidyDataSet
}

#Creates the tidy data set
tidyDataSet <- main()
#Exports the tidy data into tidyset.txt in the current folder
write.table(tidyDataSet, file = "tidyset.txt", row.name = FALSE, quote=FALSE)