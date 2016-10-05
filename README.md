# Getting and Cleaning Data Course Project
Describes how the run_analysis.R script works.

* Save the “run_analysis.R” file to your computer.
* Open Rstudio.
* Select File: Open file…. And navigate to where you saved the “run_analysis.R” file.
* Select file.
    * This will bring it to your source console.
* Highlight code and select run.
* The code will: 
    * Check for a directory and file to see if the data already exists in your working directory.
    * Download file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip if needed to directory.
    * Unzip the file into working directory and create all sub directories.
    * Clean and merge data sets into one file.
    * Creates a tidy data set with the average of each variable for each activity and each subject.
* This tidy data set will be saved as tidydata.txt in your working directory.

* The "run_analysis.R" script can be pasted into R and ran.  
    * Only R version 3.3.1 (2016-06-21) has been tested with this code.
