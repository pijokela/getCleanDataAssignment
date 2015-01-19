# run_analysis.R

library(dplyr)

DATA_DIR <- "./UCI HAR Dataset"
# A function for loading the UCI HAR Dataset datafiles in to
# data frames.
loadCsv <- function(fileName) {
  fileName <- paste(DATA_DIR, "/", fileName, sep = "")
  read.csv(fileName, header = FALSE, sep = "")
}

# Is the given feature name a mean or std factor?
isMeanOrStd <- function(featureName) {
  length(grep("std()",featureName, fixed=TRUE))>0 || 
  length(grep("mean()",featureName, fixed=TRUE))>0
}

isMeanOrStdVect <- Vectorize(isMeanOrStd)

# Remove - and () characters from factor name to
# make it more readable
cleanUpName <- function(dirtyName) {
  dirtyName <- tolower(dirtyName)
  gsub("[\\(\\)-]", "", dirtyName)
}

cleanUpNameVect <- Vectorize(cleanUpName)

# Load data headings to a dataframe:

dataHeadingsDF <- loadCsv("/features.txt")
dataHeadings <- dataHeadingsDF$V2

# Load activity names:

activityLabels <- loadCsv("/activity_labels.txt")
actNumberToLabel <- setNames(activityLabels$V2, activityLabels$V1)

# This function cleans up one directory of data
# after the cleanup we call merge to combine them
tidyDataset <- function(df) {
  # Filter factors so only mean and std factors remain:
  names(df) <- dataHeadings

  n <- names(df)
  n <- n[isMeanOrStdVect(n)]
  df2 <- df[, n]

  # Clean up special characters from data headings:
  n <- names(df2)
  n <- cleanUpNameVect(n)
  names(df2) <- n
  df2
}

# Load X data files and merge them:

trainData <- tidyDataset(loadCsv("/train/X_train.txt"))
trainActivity <- loadCsv("/train/y_train.txt")
# Create column ActivityLabel with names instead of numbers:
trainActivity <- mutate(trainActivity, ActivityLabel = as.character(actNumberToLabel[V1]))
trainData$activity <- trainActivity$ActivityLabel

# Load subject numbers:
trainSubjects <- loadCsv("/train/subject_train.txt")
trainData$subject <- trainSubjects$V1


testData <- tidyDataset(loadCsv("/test/X_test.txt"))
testActivity <- loadCsv("/test/y_test.txt")
# Create column ActivityLabel with names instead of numbers:
testActivity <- mutate(testActivity, ActivityLabel = as.character(actNumberToLabel[V1]))
testData$activity <- testActivity$ActivityLabel

# Load subject numbers:
testSubjects <- loadCsv("/test/subject_test.txt")
testData$subject <- testSubjects$V1

allData <- merge(trainData, testData, all = TRUE)

# Write tidy dataset to file:
# write.csv(allData, file="tidyData.csv", row.names=FALSE)

# Calculate average of all factors:

library(plyr)
# Group data by columns activity and subject. For all the numeric columns
# calculate the mean of the values:
summaryData <- ddply(allData, .(activity, subject), numcolwise(mean))

# Write the end result in to summary.csv:

write.csv(summaryData, file="summary.csv", row.names=FALSE)
