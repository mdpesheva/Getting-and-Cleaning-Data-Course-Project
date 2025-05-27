---
editor_options: 
  markdown: 
    wrap: 72
---

# Getting-and-Cleaning-Data-Course-Project

The run_analysis.R script downloads the needed data, performs data
preparation and following the provided instructions, performs 5 steps as
described in the course project’s definition.

1.  Download the dataset

    -   Dataset downloaded and extracted under the folder called UCI HAR

2.  Read in data and assign column names:

    -   `features` \<- `features.txt` : 561 rows, 2 columns

        -   The features selected for this database come from the
            accelerometer and gyroscope 3-axial raw signals. From data
            table features.txt, get feature names and assign them to
            train and test sets for X

    -   `activities` \<- `activity_labels.txt` : 6 rows, 2 columns

        -   List of activities performed when the corresponding
            measurements were taken and its codes (labels). Links the
            class labels with their activity name

    -   `subject_train` \<- `train/subject_train.txt` : 7352 rows, 1
        column

        -   contains train data for 21 out of 30 volunteer subjects
            being observed.Each row identifies the subject who performed
            the activity

    -   `subject_test` \<- `test/subject_test.txt` : 2947 rows, 1 column

        -   contains test data for 9 out of 30 volunteer subjects being
            observed. Each row identifies the subject who performed the
            activity

    -   `y_train` \<- `train/y_train.txt` : 7352 rows, 1 columns

        -   contains train data of activities’ labels

    -   `y_test` \<- test/y_test.txt : 2947 rows, 1 columns

        -   contains test data for the activities’ labels

    -   `x_train` \<- `train/X_train.txt` : 7352 rows, 561 columns

        -   contains recorded features train data

    -   `x_test` \<- `test/X_test.txt` : 2947 rows, 561 columns

        -   contains recorded features test data

3.  Merge the training and the test sets to create one data set

    -   x_fulldata (10299 rows, 561 columns) is created by merging
        x_train and x_test using rbind() function

    -   y_fulldata (10299 rows, 1 column) is created by merging y_train
        and y_test using rbind() function

    -   subject_fulldata (10299 rows, 1 column) is created by merging
        subject_train and subject_test using rbind() function

    -   fulldata (10299 rows, 563 column) is created by merging
        subject_fulldata , y_fulldata and x_fulldata using cbind()
        function

4.  Extract only the measurements on the mean and standard deviation for
    each measurement:

    -   fulldata (10299 rows, 88 columns) is subsetted, selecting only
        columns: subject, code and the measurements on the mean and
        standard deviation (std) for each measurement

5.  Use descriptive activity names to name the activities in the data
    set:

    -   Values from code column of the fulldata dataset are replaced
        with corresponding activity taken from second column of the
        activities variable

6.  Appropriately label the data set with descriptive variable names:

    -   Column "code" in fulldata is renamed to "activity"

    -   Wherever "Acc" is found in column’s name, we replace it with
        "Accelerometer"

    -   Wherever "Gyro" is found in column’s name, we replace it with
        "Gyroscope"

    -   Wherever "BodyBody " is found in column’s name, we replace it
        with "Body "

    -   Wherever "Mag" is found in column’s name, we replace it with
        "Magnitude "

    -   Wherever column’s name starts with "t", we replace it with
        "Time"

    -   Wherever column’s name starts with "f" or "Freq", we replace it
        with "Frequency"

    -   Wherever "mean" is found in column’s name, we replace it with
        "Mean"

    -   Wherever "std" is found in column’s name, we replace it with
        "StandardDeviation"

    -   Wherever "angle" is found in column’s name, we replace it with
        "Angle"

    -   Wherever "gravity" is found in column’s name, we replace it with
        "Gravity"

    -   Wherever "." is found in column’s name, we replace it with
        "Angle"

7.  Create a data set with the average of each variable for each
    activity and each subject:

    -   finaldata (180 rows, 88 columns) is created by sumarizing
        fulldata, taking the means of each variable for each activity
        and each subject, by grouping by subject and activity.

    -   Export finaldata into FinalData.txt file.
