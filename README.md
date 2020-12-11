# Getting And Cleaning Data Project

This project is for the purpose of getting and cleaning data using the data provided at: 

* Site: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

* Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Only Version 1.0 of the data will be used.

The project uses, but not limited to, knowledge learned from the *Getting and Cleaning Data* course offered in Coursera. See project analysis requirement below:

Create an R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Contents of Repository:
* codeBook.md: describes the variables, the data, and any transformations or work performed to clean up the data.
* README.md: Introduces and explains the project.
* run_analysis.R: Contains the codes to download and perform analysis for the project.

### Methodology:

The script for this project can be founded in run_analysis.R (which was mentioned in the above content). It is created for the purpose of downloading the raw data file :https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and turn it into processed data through tidying. 
The script saves the url in an object named urlZip due to the fact that the file is in .zip format. The zipPath object creates the path to the directory, which will be the designated path that urlZip will be downloaded to before it is unzipped to gain access to the raw data.

The packages that will be used are dplyr, tidyr, readr, and tibble.

features.txt file contains the list of all variables associated with the raw data, which will be read and saved to the object featuresVar through readLines(). This will created a character vector that is then split and subset to remove the numeric aspect of each variable name. The character vector is then put into the colNames object to be set as column names later.

For the purpose of this project, the raw sampled data (UCI HAR Dataset/.../Inertial Signals) will not be analyzed. We will look into data based on the feature measurements and focus on the mean and standard deviation variables. Therefore, only the x, y, and subject files from the test and train folders (6 in total) will be read. The x datasets contains the estimated values of each variable, the y datasets contain the list of activities measured in each same window, and the subject datasets contains the list of volunteers performing the corresponding activity. Objects are named appropriately to reflect the content each file. 

The objects are then renamed accordingly. Values from colNames objects can be used as column names for test_Data and train_Data, columns for test_Labels and train_Labels are renamed "activity" (they only have 1 column each), columns for subject_test and subject_train are renamed "subject" (have only 1 column each).

Values in the activity column of the files ending _Labels will be replaced with descriptive names instead of numbers. This is done through a change of gsub() looking for each numeric value in a range of 1-6 and subsituting for the corresponding activity name.

Datasets for activities, subjects, and numeric data are column binded to create two final datasets for each test and train, named testF and trainF. They are then merged with rowbind() to created the final complete dataset named test_Train.

Because the focus is on mean and standard deviation values, test_Train object is subset to extract columns containing only the pattern "mean()" or "std()". The subset data is placed into the meanStd object. to reflect the data only containing values for mean and standard deviations for the corresponding feature vector.

The data is further trimmed by using the pivot_longer() function from the tibble package to gather all variables, minus subject and activity, into one column called "measurement" and their corresponding values in the "values" column. The data is then grouped by subject, activity, and measurement, and summarize by average value (or mean) of each measurement variable for each activity and subject. Data is saved in summary_Average data.

Final processed data table is written into a text file named "summary_Average.txt".