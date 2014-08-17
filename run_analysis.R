# download and unpack files if we don't have them yet
if (!file.exists("UCI HAR Dataset")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip", "curl")
    unzip("data.zip")
}
# load all necessary data
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
# attach activities
test_activity <- merge(test_activity, activities, by.x = "V1", by.y = "V1", sort = FALSE)[, 2]
train_activity <- merge(train_activity, activities, by.x = "V1", by.y = "V1", sort = FALSE)[, 2]
test_data[, dim(test_data)[2] + 1] <- test_activity
train_data[, dim(train_data)[2] + 1] <- train_activity
# set column names
colnames(test_data) <- features$V2
colnames(train_data) <- features$V2
colnames(test_data)[length(colnames(test_data))] = "activity"
colnames(train_data)[length(colnames(train_data))] = "activity"
# union two data sets to one by extracting only mean, standard deviation and activity columns
cnames <- grep("(^.+(mean\\(\\)|std\\(\\)).+$|activity)", colnames(test_data), value = TRUE)
data <- test_data[, cnames]
observations <- dim(data)[1]
# i know, it's super slow, but couldn't easily find google help on this matter and rbind looked dodgy. at least for loop works for sure. shame on me :/
for (i in 1:dim(train_data)[1]) {
    data[observations + i, ] <- train_data[i, cnames]
}
# aaand let's write the final data
write.table(data, "data-with-mean-and-std.txt", row.names = FALSE)
# calculate means of each feature grouped by activity and write results to different file
data_means <- aggregate(data[, 1:(dim(data)[2] - 1)], list(data$activity), mean)
write.table(data_means, "feature-means-by-activity.txt", row.names = FALSE)
