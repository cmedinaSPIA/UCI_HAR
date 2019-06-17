UCI_HAR Project

Description of run_analysis.R

Based on this files

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training activities.

- 'train/subject_train.txt: Subject who did the training

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test activities.

- 'test/subject_test.txt: Subject who did the test


The script run_analysis.R consists of:

1. Merges the training and the test sets to create one data set.
It is using read.table function to read txt data files for training and test.
The column names for variables were loaded in the same order as data.
The data sets for training and test were binded to get the first data set required

2. Extract only Subject, Activity, Mean and Standard Deviation 
Using grep function to identify the column names
Taking only the columns required

3. Use descriptive Activity Name
Loading the data in activity_labels text file.
Using merge function to add the description for each activity 

4.  Appropriately labels the data set.
Using the string function gsub to replace abbreviated data to descriptive data
 
5. Second data set with the average of each variable for each activity and each subject
Using group_by and summarise functions it was easy to have this information.


Libraries used
library("data.table")
library(stringr)
library(dplyr)

For detailed description of the project.  See README.txt file in "getdata_projectfiles_UCI HAR Dataset.zip"
