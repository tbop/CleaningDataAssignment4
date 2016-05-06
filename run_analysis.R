run_analysis <- function() {
    ## Initializing libraries
    library(plyr);
    library(dplyr);
    
    if (!file.exists("dataset.zip")) 
    {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="dataset.zip", mode="wb")
        unzip ("dataset.zip")
    }
    
    ## Gathering official feature names
    feature_names <- read.table("UCI HAR Dataset/features.txt");
    feature_names <- feature_names[[2]];
    
    ## 4. Appropriately labels the data set with descriptive variable names
    x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feature_names);
    x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature_names);
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activity"));
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity"));
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"));
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"));
    
    ## 1. Merges the training and the test sets to create one data set.
    x <- bind_rows(x_test, x_train);
    y <- bind_rows(y_test, y_train);
    subject <- bind_rows(subject_test, subject_train);
    
    ## 2. Extracts only the measurements on the mean and standard deviation for each measurement
    x <- x[, grep("mean\\(\\)|std\\(\\)", feature_names)];
    
    ## 3. Uses descriptive activity names to name the activities in the data set
    y <- lapply(y, gsub, pattern = "1", replacement = "WALKING", fixed = TRUE);
    y <- lapply(y, gsub, pattern = "2", replacement = "WALKING_UPSTAIRS", fixed = TRUE);
    y <- lapply(y, gsub, pattern = "3", replacement = "WALKING_DOWNSTAIRS", fixed = TRUE);
    y <- lapply(y, gsub, pattern = "4", replacement = "SITTING", fixed = TRUE);
    y <- lapply(y, gsub, pattern = "5", replacement = "STANDING", fixed = TRUE);
    y <- lapply(y, gsub, pattern = "6", replacement = "LAYING", fixed = TRUE);
    
    ## 5. From the data set in step 4, creates a second, independent tidy data set
    ## with the average of each variable for each activity and each subject.
    joinedDf <- bind_cols(subject, x, y);
    groupedDf <- group_by(joinedDf, activity, subject);
    summarizedDf <- summarise_each(groupedDf, funs(mean));
    
    write.table(summarizedDf, file = "tidy_summarized_dataset.txt", row.name = FALSE);
}
