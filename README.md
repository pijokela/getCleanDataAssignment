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

Lines 1-30 contain functions that are used to make the rest of the analysis cleaner. They have descriptive comments in the analysis file.

Line 32 load the data headings file to the data frame.

Line 37 load the descriptive activity labels to a data frame.

Line 42 tidyDataset function: The complete dataset contains several files with data. This function is used to clean up each file individually: 
	1. Columns not containing mean or standard deviation data are removed from the dataset. The factornames in the original data contain "mean()" or "std()" if they contain mean or standard deviation data.
	2. Special characters "(", ")", "-" are removed from column names.
	3. Column names are changed to all-lowercase letters to make them easier to type correctly.

Line 59 load and tidy training data X dataset. The X dataset is the main numberdatafile.

Line 60 load the training activity data.

Line 62 add activity descriptions to the activity dataset.

Line 63 add activity descriptions column to the training number data data frame. 

Line 67 add subject id numbers to the training number data frame.

Lines 70-78 repeat the clean-up and merge process for the test dataset.

Line 80 combine the test data and the training data to a single data frame called allData.

Line 90 Group data by columns activity and subject. For all the numeric columns calculate the mean of the values.

Line 94 Write the output CSV file "summary.csv" that contains the result of the analysis.

# Column descriptions

Please see the code book in the file column_descriptions.md for a description of the columns in the summary.cvs file.
