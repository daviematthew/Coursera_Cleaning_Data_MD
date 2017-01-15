## Load necessary packages
library(dplyr)

## Load necessary datasets (note: change path reference to wherever you have files saved)
test_x <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
test_y <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\test\\Y_test.txt", header = FALSE)
train_y <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\train\\Y_train.txt", header = FALSE)
train_x <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\train\\X_train.txt", header = FALSE)
subject_test <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)
subject_train <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)
activity_labels <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\activity_labels.txt", header = FALSE)
features <- read.table("C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\UCI HAR Dataset\\features.txt", header = FALSE)

## Add proper names to the variables in the test and train datasets
names(test_x) <- features[,2]
names(train_x) <- features[,2]

## Join the numbered activity list to the names for the activities
test_activity <- left_join(test_y, activity_labels, by = "V1")
train_activity <- left_join(train_y, activity_labels, by = "V1")

## Bind the Subject and Activity lists to their respective test/train datasets
test_data <- cbind(subject_test[,1],test_activity[,2], test_x)
train_data <- cbind(subject_train[,1],train_activity[,2], train_x)

## Add header names for the Subject and Activity columns
names(test_data)[1] <- "Subject"
names(test_data)[2] <- "Activity"
names(train_data)[1] <- "Subject"
names(train_data)[2] <- "Activity"

## Combine the test and train datasets
full_data <- rbind(test_data, train_data)

## Use regex to pull the Subject, Activity; and mean and std columns from the complete dataset
filtered_data <- full_data[,grepl("Subject|Activity|mean\\(\\)|std\\(\\)", colnames(full_data))]

## Group the filtered dataset by Subject and Activity and calculate the mean for each remaining feature
mean_data <- aggregate(filtered_data[,3:ncol(filtered_data)], list(filtered_data$Subject, filtered_data$Activity), mean)
names(mean_data)[1] <- "Subject"
names(mean_data)[2] <- "Activity"

## Write the tidy dataset to its own TXT file
write.table(mean_data, "C:\\Users\\mdavie\\Desktop\\Coursera\\Cleaning Data Week 4 Project\\Code\\tidy_data.txt", sep = "\t", row.names = FALSE)
