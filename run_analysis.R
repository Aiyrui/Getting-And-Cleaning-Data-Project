## Define url to be used.
urlZip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Create file and path to working directory.
zipPath <- as.character(paste(getwd(), "data.zip", sep = "/"))

## Download url/dataset to designated directory.
download.file(urlZip, zipPath)

## Unzip folder.
unzip(zipPath)

## Load packages that will be used from library.
packages = c("dplyr", "tidyr", "readr", "tibble")
invisible(lapply(packages, library, character.only = TRUE))

## Read variables/column names.
featuresVar <- readLines("UCI HAR Dataset/features.txt")

## Split and subset for descriptive measurement names.
colNames <- featuresVar %>% strsplit(" ") %>% sapply(function(x) {x[2]})

## Read test & train data files.
test_Data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_Labels <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_Data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_Labels <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

## Rename columns accordingly.
colnames(test_Data) <- colNames
colnames(train_Data) <- colNames
colnames(test_Labels) <- "activity"
colnames(train_Labels) <- "activity"
colnames(subject_test) <- "subject"
colnames(subject_train) <- "subject"

## Substitute activity labels with descriptive names for test & train files.
train_Labels$activity <- train_Labels$activity %>% gsub("[1]", "Walking", .) %>%
  gsub("[2]", "Walking_Upstairs", .) %>% 
  gsub("[3]", "Walking_Downstairs", .) %>% 
  gsub("[4]", "Sitting", .) %>% 
  gsub("[5]", "Standing", .) %>% 
  gsub("[6]", "Laying", .)
test_Labels$activity <- test_Labels$activity %>% gsub("[1]", "Walking", .) %>%
  gsub("[2]", "Walking_Upstairs", .) %>% 
  gsub("[3]", "Walking_Downstairs", .) %>% 
  gsub("[4]", "Sitting", .) %>% 
  gsub("[5]", "Standing", .) %>% 
  gsub("[6]", "Laying", .)

## Bind the corresponding dataset, then combine both test and train data set.
testF <- cbind(test_Labels, subject_test, test_Data)
trainF <- cbind(train_Labels, subject_train,train_Data)
test_Train <- rbind(testF, trainF)

## Extracts columns containing the pattern "mean()" or "std()".
meanStd <- test_Train %>% 
  select(subject, activity, contains("mean()") | contains("std()"))

## Check for NA's
sum(is.na(meanStd))

## Write output to csv file in working directory.
write_csv(meanStd, "resultOutput/meanStd.csv")

## Gather feature measurement variables into one column with corresponding values
## into a new column call "value", 
## group by subject and activity, and summarize by mean. "subject" and "activity"
## columns are left unchanged.
sum_Average <- meanStd %>% 
  pivot_longer(!subject:activity, 
               names_to = "measurement", 
               values_to = "value") %>% 
  group_by(subject, activity, measurement) %>% 
  summarise(avg = mean(value))

## Write output to csv file in working directory.
write_csv(sum_Average, "resultOutput/sum_Average.csv")