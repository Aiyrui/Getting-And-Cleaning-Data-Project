## Code Book for Getting And Cleaning Data Project
### Data
Raw data being used for this project are the accelerometer and gyroscope data collected from the Samsung Galaxy S II smartphone. The datasets are obtained by:

* Data Information: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* Data file used for project:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For the purpose of this project, I will not look into the raw sampled data (UCI HAR Dataset/.../Inertial Signals). I will look into the data based on the feature measurements.

File Information:

* X_: Observations of feature measurement
* y_: Activity observed corresponding to each row in the X file. Labeled by numbers.
* subject_: The subjects doing the corresponding activity in the y file and measured by the corresponding row in the X file. Labeled by numbers.

Descriptive names for the activity ids are given by:

* activity_labels.txt

Descriptive variable names can be found in:

* features.txt

All files used for this project in the text file format.

### Transformations:
1. Files of interest are loaded from both the test and train group datasets.
2. Variables are determined by the features.txt file and tidied by removing the numeric aspect of each variable name. 
3. Renamed columns for each dataset (X_, y_, subject_) accordingly using the colnames() function. X_ datasets are renamed using the variables from the features.txt file.
4. Descriptive activity names replaced the activity ids in labels (y_) data tables through the chain use of gsub() function.
5. The corresponding test and train datasets are binded by columns in the order before both groups are merged by row bind.
6. We are interested in the mean() and std() columns. Therefore, we subset by selecting only column variables that contain the pattern "mean()" or "std()".
8. Result is output as *meanStd.csv* and saved to resultOutput folder.
9. Data is further reduced by transforming all variables minus subject and activity into one column called "measurement" and their corresponding values in the "values" column through pivot_longer().
10.Data is then grouped in the order of: subject, activity, measurement. 11. Data is summarized by average of each variable for each activity and each subject.
12. Final result is output as *sum_Average.csv* and saved to resultOutput folder.

