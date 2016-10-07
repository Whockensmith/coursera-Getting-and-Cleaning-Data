# Getting and Cleaning Data Course Project
Describes how the run_analysis.R script works.

* Save the “run_analysis.R” file to your computer.
* Open Rstudio.
* Select File: Open file…. And navigate to where you saved the “run_analysis.R” file.
* Select file.
    * This will bring it to your source console.
* Highlight code and select run.
      * If you run the code using the "Source" option you will not get any dialog from the script telling you what is happening.
* The code will: 
    * Check for a directory and file to see if the data already exists in your working directory.
    * Download file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip [1] if needed to directory.
    * Unzip the file into working directory and create all sub directories.
    * Clean and merge data sets into one file.
    * Creates a tidy data set with the average of each variable for each activity and each subject.
* This tidy data set will be saved as tidydata.txt in your working directory.

* The "run_analysis.R" script can be pasted into R and ran.  
    * Only R version 3.3.1 (2016-06-21) has been tested with this script.
    * Cannot guarantee the script will run in earlier version of R.
   
Reference:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
