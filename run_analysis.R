ptm <- proc.time()
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
Fnshd <- "Complete.  Your tidy data is located in your working directory as tidydata.txt."
Addlbry
library(dplyr)
library(downloader)
library(reshape2)
DataFiles <- "Smart_Phone_Data"
if (!file.exists(DataFiles)) {
     crtngdir 
     dir.create(DataFiles)
     dircreated
 } else { dirnotcreated}
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
X_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/subject_test.txt")
merged_train<- cbind(Y_train,subject_train, X_train) 
merged_test <- cbind(Y_test,subject_test,X_test)
combined <- rbind(merged_train, merged_test) 
feature <- read.table("Smart_Phone_Data/UCI HAR Dataset/features.txt") 
feature <- as.character(feature$V2) 
colnames(combined)[1:2] <- c("Activity","Subject") 
colnames(combined)[3:563] <- feature 
meanstd <- grep("std|mean", names(combined)) 
meanstd2 <- combined[ ,c(1,2, meanstd)]
activity <- read.table("Smart_Phone_Data/UCI HAR Dataset/activity_labels.txt") 
activity <- rename(activity, Activitycode = V1, Activity = V2)
merged <- merge(activity, meanstd2, by.x = "Activitycode", by.y = "Activity") 
merged2 <- select(merged, -Activitycode) 
names(merged2) <- sub("^t", "Time", names(merged2)) 
names(merged2) <- sub("^f", "Frequency", names(merged2))
MeltActSub <- melt(merged2, id=c("Activity", "Subject"))
means <- dcast(MeltActSub, Subject + Activity ~ variable, mean)
write.table(means, "tidydata.txt", row.names = FALSE)
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
Fnshd
proc.time()-ptm


