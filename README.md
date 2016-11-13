# Getting-and-Cleaning-Data-Course-Project
The run_analysis file does the following:
  1. Unzips and saves the UCI HAR Dataset (after which you will need to plce these files in your local documents)
  2. Sets your Working Directory to be your local documents, clears your workspace of any exisiting objects, and loads the dplyr and tidyr packages
    a. You will need to install the dplyr and tidyr packages prior to running this script
  3. Reads in the features, X_test, y_test, subject_test, X_train, y_train, subject_train, and activity_labels files, assigning column names where appropriate
  4. Creates one full data set by organizing these all in a manner that leaves each row containing a subject, activity, and all measurments.
  5. Cuts the created data set down to only include measurements that are means or standard deviations
  6. Finally, creates a new data set that contains the mean for each measurement for each unique pair of activity and subject in a tidy manner
  
This script ends by writing the final tidy data set into a text file and saving it in the working directory.
  
