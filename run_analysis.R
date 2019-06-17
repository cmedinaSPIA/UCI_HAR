# 1. Merges the training and the test sets to create one data set.
#
# 1.1 Load training data and adding column names to each data set
#

train_table_x<-read.table("./train/X_train.txt")
table_features<-read.table("features.txt")
names_x<-as.vector(table_features[,2])
colnames(train_table_x)<-names_x
colnames(train_table_x)

train_table_sub<-read.table("./train/subject_train.txt")
colnames(train_table_sub)[1]<-"Subject"
train_table_y<-read.table("./train/y_train.txt")
colnames(train_table_y)[1]<-"Activity"

#
# 1.2 Bind training data in an only data set
#
train_table<-cbind(train_table_sub,train_table_y,train_table_x)

#
# 1.3 Remove old data sets
#
rm(train_table_x,train_table_y,train_table_sub)


#
# 1.4 Load test data and adding column names to each data set
#
test_table_x<-read.table("./test/X_test.txt")
colnames(test_table_x)<-names_x
colnames(test_table_x)

test_table_sub<-read.table("./test/subject_test.txt")
colnames(test_table_sub)[1]<-"Subject"
test_table_y<-read.table("./test/y_test.txt")
colnames(test_table_y)[1]<-"Activity"

#
# 1.5 Bind test data in an only data set
#
test_table<-cbind(test_table_sub,test_table_y,test_table_x)

#
# 1.6 Remove old data sets
#
rm(test_table_sub,test_table_y,test_table_x)

# 
# Binding training and test data set in one 
#
HAR <- rbind(train_table,test_table) 
rm(train_table,test_table)

#
#  2. Extracts only the measurements on the mean and
#     standard deviation for each measurement.
#
col_sel<-grep("mean|std",colnames(HAR))
HAR<-cbind(HAR[,1:2],HAR[,col_sel])
rm(col_sel)

#
#  3. Uses descriptive activity names to name the activities 
#     in the data set
#
activities<-read.table("activity_labels.txt")
colnames(activities)<-c("Activity","Description")
HAR<-merge(HAR,activities,by="Activity")
HAR<-HAR[,-1]
colnames(HAR)[81]<-"Activity"

#
#  4. Appropriately labels the data set with descriptive variable 
#     names.
#
#
# 4.1 Get column names
#
HARCols <- colnames(HAR)

#
# 4.2 Remove special characters
#
HARCols <- gsub("[\\(\\)-]", "", HARCols )

#
# 4.3 Replace special patterns
#
HARCols <- gsub("^tBody", "timeBody", HARCols)
HARCols <- gsub("Acc", "Acceleration", HARCols)
HARCols <- gsub("^tGravity", "timeGravity", HARCols)
HARCols <- gsub("^fBody", "frequencyBody", HARCols)
HARCols <- gsub("mean", "Mean", HARCols)
HARCols <- gsub("std", "StandardDev", HARCols)
HARCols <- gsub("Freq", "Frequency", HARCols)
HARCols <- gsub("BodyBody", "Body", HARCols)

#
# 4.4 Replace the column names
#
colnames(HAR)<-HARCols

#
# 5. Second data set with the average of each variable for each 
#    activity and each subject
library(dplyr)
HAR_means<-summarise_all(group_by(HAR,Subject,Activity),mean)
HAR_means
