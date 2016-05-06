# Code Book

## Variables

* feature_names: gathers the feature names based on features.txt so that they can be directly injected whiled loading X_test.txt and X_train.txt
* x_test: features of the test set
* x_train: features of the train set
* y_test: activities of the test set
* y_train: activities of the train set
* subject_test: subjects of the test set
* subject_train: subjects of the train set
* x: merged data frame of both test and train sets' features
* y: merged data frame of both test and train sets' activities
* subject: merged data frame of both test and train sets' subjects
* joinedDf: column binding of respectively subject, x and y
* groupedDf: joinedDf grouped by activities and subjects
* summarizedDf: groupedDf's columns summarized by their respective average (per activity and per subject)

## Data

* features.txt: File that contains every feature's name
* X_test.txt: File that contains the features of the test set
* X_train.txt: File that contains the features of the train set
* y_test.txt: File that contains the activity of the test set
* y_train.txt: File that contains the activity of the train set
* subject_test.txt: File that contains the subject of the test set
* subject_train.txt: File that contains the subject of the train set

## Transformations

* x_test and x_train's columns are renamed with the feature names written in features.txt
* y_test and y_train's column is renamed with "activity"
* subject_test and subject_train's column with renamed to "activity"
* x, y and subject are joined to their respective test and train dataset
* x is filtered out from any feature that is not a mean or a standard deviation
* y's activity are re-labelled with the official labels
* subject, y and y are joined
* the joined data frame is grouped by activity and subject
* the grouped joined data frame's columns are all summarized by their average
