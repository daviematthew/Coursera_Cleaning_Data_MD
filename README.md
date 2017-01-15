# Coursera_Cleaning_Data_MD
Week 4 Assignment for Cleaning Data in R

This repository includes files to do the following:

1. Combine the original test/train datasets given to students
2. Select only mean() or std() values from the combined dataset
3. Calculate the average of these mean() and std() values for each Subject and Activity

There is only one script which performs these activities, run_analysis.R

This script makes use of the dplyr package.

The following steps are taken in the analysis:

1. The following datasets are loaded
  i. X_test
  ii. Y_test
  iii. X_train
  iv. Y_train
  v. subject_test
  vi. subject_train
  vii. activity_labels
  viii. features
2. The features file is used to add header names to the X_test and X_train datasets
3. The activity names are added to the Y_test and Y_train files by left joining to the activity_labels file
4. This activity data, along with the subject data (subject_test and subject_train files) is bound to the X_test and X_train files
5. Headers are added for the Subject and Activty Columns in the new datasets
6. The two datasets are bound together
7. Only rows including mean() or std() are kept (along with Subject and Activity)
8. The data is aggregated on Subject and Activity and for each Subject/Activity pair the average of the remaining values is calculated
9. The new dataset is written to a text file, tidy_data.TXT (saved in repository)
