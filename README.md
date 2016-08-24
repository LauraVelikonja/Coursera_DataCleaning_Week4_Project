# Coursera_DataCleaning_Week4_Project

This project contains an R script, that reads in, cleans and gives out a tidy data sets and a codebook, which explains all relevant variables and summaries made.

## The R Script
First of all the text file features.txt and activity_lables.txt are read in, because they are independet from the test and training set. Then a loop is created to go through the relevant training and test textfiles and concatenates them in the end.
For the training data, the following files are read into:
- X_train
- y_train
- subject_train
- 
A data frame is created by cbind. Then the activity names are merged to the table, mapping the activity codes to a descriptive name.
The same is done for the test sets. Both are concatenated by the rbind function.

In the next step, only measurement columns containing "mean" or "sd" are extracted by using the function grepl.

In a last step the new data set is grouped by the volunteer and his/her activity and the mean calculated for all remaining variables.

## The Codebook
