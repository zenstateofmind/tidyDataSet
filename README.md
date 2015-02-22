1) Where should the file be stored? 

The file should be stored in the same folder that contains the UCI HAR Dataset folder. So the folder where run_analysis.R is stored looks like this:

        / <Current Directory>   
            / run_analysis.R
            / UCI HAR Dataset folder

2) What does the script create?

The script creates "tidyset.txt". This file is a data set with the average of each variable for each activity and each subject.


3) How do you view the tidyset.txt?

Go to the folder that contains run_analysis.R as well as UCI HAR Dataset folder. Now do the following:

    source("run_analysis.R")
    tidyset <- read.table("tidyset.txt", header=TRUE)
    View(tidyset)

4) How does the script work?

I have modularized the script into separate functions.
These are all the functions and what they do:

    createTrainingDataSet : creates a data set of the training set
    createTestDataSet: creates a data set of the test set
    createDataSet: Merges the training data set and the test data set into a single data set
    extractMeasurementsWithMeanAndStdDev: takes the merged data set and returns a data set that contains
                                                                              variables that relate to mean and standard deviation
    activity: This is a helper function that is takes in a number between 1 to 6, and returns the activity
                  correlated to it activity_labels.txt
    wordContainsMeanOrStdDev: This is also a helper function that is used in extractMeasurementsWithMeanAndStdDev.
                                                       It takes in a word and checks whether it contains "mean()" or "std()".
    main: uses all the functions mentioned above and returns a tidy data set with the average of each variable for each activity
               and each subject.



