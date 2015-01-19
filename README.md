# getCleanDataAssignment
Assignment for the Getting and Cleaning Data course

# How to run analysis?

To run the analysis, you need R installed with these libraries:
- dplyr
- plyr

If required, you can install them with the install.packages(...) command in R.

Please note that you need to have the UCI HAR Dataset package unzipped in the directory that contains the run_analysis.R file. Use this command to run the analysis:

R -f run_analysis.R

# Result of analysis

The run_analysis.R script will create a CSV file:
- summary.csv

# Contents of summary.csv

The summary file contains the data from UCI HAR Dataset modified to better suit further analysis:
- All data in one file.
- File is grouped by activity and subject.
- The numerical data is an average value of the measurements for that activity and subject.
- Only mean and std columns of the numerical data remain.

The file code_book.txt contains a description of all the columns in the dataset.

# Description of the run_analysis.R script

