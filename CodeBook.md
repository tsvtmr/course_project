# Code Book

This document describes the code inside `run_analysis.R`.

The code is splitted (by comments) in some sections:

* Helper functions
* Constants
* Downloading and loading data
* Manipulating data
* Writing final data to CSV

## Helper functions and constants

Some functions and constants to avoid code repetition and make the rest of code more clean.

### fileUrl

Used to save the link to the file


### filepath

Keeps the path to the folder

### ActivityTestData, ActivityTrainData, SubjectTestData, etc.

Read dataset files from UCI HAR to given name and prefix. Know names are "train" and "test". Known prefixes are "X", "y" and "subject".

Examples:

* `UCI HAR Dataset/train/X_train.txt`
* `UCI HAR Dataset/train/y_train.txt`
* `UCI HAR Dataset/train/subject_train.txt`

### ActivityLabels

Reading the descriptive activity names from "activity_labels"

## Downloading and loading data

* Creates 'project_data' folder if it doesnt exist
* Downloads the UCI HAR zip file
* Unzips the file
* Reads the activity, subject and features train and test data

## Manipulating data

* Merging the train and test data sets to create 1 data set for Activity, Subject and Features;
* Setting names to variables - "subject", "activity", "features"
* Merging all columnts to get the dataframe "Data" with all the data
* Extracting only the measurements on the mean and standard deviation for each measurement, by taking names of Features with "mean()" and "std()"
* Subseting the data frame "Data" by seleted names of Features
* Reading the descriptive activity names from "activity_labels"
* Using the activity labels to add descriptive names to the activites in "Data"
* Labeling the data set with descriptive var names

-- prefix t is replaced by time

-- Acc is replaced by Accelerometer

-- Gyro is replaced by Gyroscope

-- prefix f is replaced by frequency

-- Mag is replaced by Magnitude

-- BodyBody is replaced by Body


## Writing final data to txt

Creating a second, independent tidy data set and creating output of it ("tidydata.txt")
