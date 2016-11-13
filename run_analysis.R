# downloading and unzipping the zip file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip(temp)


# Setting the working directory and clearing workspace and load correct libraries
setwd("~/")
rm(list=ls())
library(dplyr)
library(tidyr)



# Bringing in all tables needed and assigning column names
features <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/features.txt")
test_data <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
test_labels <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt", col.names = "ActivityID")
test_subject <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt", col.names = "SubjectID")
train_data <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
train_labels <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt", col.names = "ActivityID")
train_subject <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt", col.names = "SubjectID")
activity_labels <- read.table("./Coursera Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt", col.names = c('ActivityID','ActivityDescription'))


#creates entire test and training data sets with labels and subjects included
test_data <- cbind(test_labels, test_subject, test_data)
train_data <- cbind(train_labels, train_subject, train_data)


# Merging Test Data and Training Data into one data set
all_data <- rbind(test_data, train_data)


#Creating a vector with the column names to check for mean and std
measures <- names(all_data)


#Creating a Logical Vector for columns to keep in all_data based on mean and std dev
keepers <- grepl("ID|mean|std",measures, ignore.case = TRUE)


#Cutting out columns that are not mean, std or IDs
all_data <- all_data[,keepers]


#replacing ActivityIDs with Activity Descriptions
activity_vector <- sapply(all_data$ActivityID, function(x) activity_labels[match(x,activity_labels[,1]),2])
all_data$ActivityID <- activity_vector
names(all_data)[1] <- "ActivityDescription"

#Creating new dataset with average of each variable by person, by activity and writing it into a text file
new_set <- aggregate(. ~SubjectID + ActivityDescription, all_data, mean)
new_set <- gather(new_set, measurement, mean, -(SubjectID:ActivityDescription))

write.table(new_set, file = "./Coursera Getting and Cleaning Data/UCI HAR Dataset/newtidydataset.txt", row.name = FALSE)



