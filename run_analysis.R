run_analysis <- function() {
    ## Initializing libraries
    library(plyr);
    library(dplyr);
    
    ## Gathering official feature names
    feature_names <- read.table("features.txt");
    feature_names <- feature_names[[2]];
    
    ## 4. Appropriately labels the data set with descriptive variable names
    x_test <- read.table("test/X_test.txt", col.names = feature_names);
    x_train <- read.table("train/X_train.txt", col.names = feature_names);
    y_test <- read.table("test/y_test.txt", col.names = c("activity"));
    y_train <- read.table("train/y_train.txt", col.names = c("activity"));
    subject_test <- read.table("test/subject_test.txt", col.names = c("subject"));
    subject_train <- read.table("train/subject_train.txt", col.names = c("subject"));
    
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
    groupedDf <- group_by(joinedDf, subject, activity);
    summarizedDf <- summarise_each(groupedDf, funs(mean));
    
    write.table(summarizedDf, file = "tidy_summarized_dataset.txt", row.names = FALSE);
}
