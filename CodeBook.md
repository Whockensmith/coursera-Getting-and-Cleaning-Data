#                                   Code Book for the Tidy Dataset
ptm <- proc.time()
## Just a timer to test the speed.  This is started for the timer.

## A few statements used with in this code to tell the user what’s going on.
crtngdir <- "Creating Directory"
dircreated <- "Directory Created"
dirnotcreated <- "Directory already exists, no new directory created"
filecreated <- "File Downloaded"
unzpngfl <- "Unzipping files"
filesunzp <- "Files Unzipped"
filenotcreated <- "File already exists, no file downloaded"
downloadingfile <- "Downloading File, this may take some time.  Approximately 4 to 7 minutes."
Addlbry <- "Loading a few libraries to ensure proper operation."
Clnup <- "Cleaning up un needed objects."
## A few statements used with in this code to tell the user what’s going on.

Addlbry
library(dplyr)
library(downloader)
library(reshape2)
## Library Loads that are needed to download and manipulate the data.

DataFiles <- "Smart_Phone_Data"
## Declares the Directory the data will be downloaded into.


if (!file.exists(DataFiles)) {
     crtngdir 
     dir.create(DataFiles)
     dircreated
 } else { dirnotcreated}

## Checks to see if the Directory 'Smart_Phone_Data' exsist, if not it will create it; if it does it continues to next command. This is the directory the zip file will be down loaded to then unzipped.

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
 file <- paste(DataFiles,basename(url),sep='/')
 if (!file.exists(file)) { 
     downloadingfile
     download.file(url, file)
     filecreated
     unzpngfl  
     unzip(file,exdir=DataFiles)
     filesunzp 
 } else {filenotcreated}
## Checks to see if the zip file exists, if not it will download it, if it does it continues to the next command.

X_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/X_train.txt")
## Reads X_train into a data frame (memory)

Y_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/Y_train.txt")
## Reads Y_train.txt into a data frame (memory)

subject_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/subject_train.txt")
## Reads subject _train.txt into a data frame (memory)

X_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/X_test.txt")
## Reads X_test into a data frame (memory)

Y_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/Y_test.txt")
## Reads Y_test.txt into a data frame (memory)

subject_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/subject_test.txt")
## Reads subject _test.txt  into a data frame (memory)

merged_train<- cbind(Y_train,subject_train, X_train) 
## merges Y_train data frame, subject_train, and X_train data frame into one a data frame (memory) by columns

merged_test <- cbind(Y_test,subject_test,X_test)
## merges Y_test data frame, subject_test, and X_test data frame into one a data frame (memory) by columns

combined <- rbind(merged_train, merged_test) 
##merges  merged_train and merged_test data frames into on data frame (memory)

feature <- read.table("Smart_Phone_Data/UCI HAR Dataset/features.txt") 
## Reads features.txt into a data frame (memory)

feature <- as.character(feature$V2) 
## Changes column two to character so it can be used later

colnames(combined)[1:2] <- c("Activity","Subject") 
## Names columns 1 and two

colnames(combined)[3:563] <- feature 
##Names columns 3 through 563 using the names from feature

meanstd <- grep("std|mean", names(combined)) 
meanstd2 <- combined[ ,c(1,2, meanstd)]
## Selects all columns with headers that include mean or std(standard deviation)

activity <- read.table("Smart_Phone_Data/UCI HAR Dataset/activity_labels.txt") 
activity <- rename(activity, Activitycode = V1, Activity = V2)
 ## Reads the labels from activity_labels.txt.

merged <- merge(activity, meanstd2, by.x = "Activitycode", by.y = "Activity") 
merged2 <- select(merged, -Activitycode) 
## Replaces the Activitycode with a descriptive name in column 2.

names(merged2) <- sub("^t", "Time", names(merged2)) 
names(merged2) <- sub("^f", "Frequency", names(merged2))
## Replaces (substitutes)  “^t”  with “Time” and “^f” with “Frequency”

MeltActSub <- melt(merged2, id=c("Activity", "Subject"))
means <- dcast(MeltActSub, Subject + Activity ~ variable, mean)
write.table(means, "tidydata.txt", row.names = FALSE)
## writes the text file “tidydata.txt” to the working directory
Clnup 
rm(X_train)
rm(Y_train)
rm(subject_train)
rm(X_test)
rm(Y_test)
rm(subject_test)
rm(combined)
rm(feature)
rm(activity)
rm(crtngdir)
rm(dircreated)
rm(dirnotcreated)
rm(filecreated)
rm(unzpngfl)
rm(filesunzp)
rm(filenotcreated)
rm(downloadingfile)
## Clean up.  Removes un-needed variables to free up memory.

proc.time() – ptm
## Timer stop.  This calculates the time it took to run the code.