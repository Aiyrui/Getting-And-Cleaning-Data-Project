### Raw Data 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value

* std(): Standard deviation

### Transformation:

Variables are determined by the features.txt file and tidied by removing the numeric aspect of each variable name. Renamed columns for each dataset (X_, y_, subject_) accordingly using the colnames() function. X_ datasets are renamed using the variable names from the features.txt file. Descriptive activity names replaced the activity ids in labels (y_) data tables through the chain use of gsub() function. The corresponding test and train datasets are binded by columns in the order before both groups are merged by row bind.Data is then subset by selecting only column variables that contain the pattern "mean()" or "std()". Data is further reduced by transforming all variables, minus subject and activity, into one column called "measurement" and their corresponding values in the "values" column. Data is then grouped in the order of: subject, activity, measurement. Data is summarized by average of each variable for each activity and each subject. Final result is saved *sum_Average.txt*.

### Processed Data:

summary_Average: tibble [11,880 x 4] (S3: grouped_df/tbl_df/tbl/data.frame)

Variables:

* activity: Each row identifies the activity observed for each feature and variable. Their identifiers or labels were transformed into descriptive names. There are 6 activities being observed: Walking, Walking_Upstairs, Walking_Downstairs, Standing, Sitting, Laying. Class: character.

* avg: Summarized average of mean or standard deviation value across each feature vector for each subject and activity. They are grouped by *subject, activity, and measurement*. Class: numeric

* measurement: List of feature vectors and their estimated mean or standard deviation after they were subset to contain only the mean or standard deviation variable. Each row identifies the mean or standard deviation of the corresponding feature vector. Class: character.

* subject: Each row identifies the volunteer who performed the corresponding activity for each sampled data. There are 30 unique subjects, encoded in numbers. Class: integer
