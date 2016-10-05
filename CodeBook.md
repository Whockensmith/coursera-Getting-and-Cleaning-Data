#                                   Code Book for the Tidy Dataset
The first part of this code book shows how the code was used and a quick discription of what it did.  At the end of this document are the codes and their discriptions.

## Just a timer to test the speed.  

* ptm <- proc.time()

This is the first part of the timer; the second part is at the end of the script.
I initially used this to test how quickly the script was running and if I could improve its performance.  I left it here for a reference so the user as an idea of how long it really took.  Also if someone wanted to modify the code to improve it a timer was already here.

## A few statements used with in this code to tell the user what’s going on.
The following code allows the user to know if the script found the download file already in the working directory or not.  Then will inform the user weather or not it was unzipped.  I did this because it can be frustrating after code runs and you’re not sure if anything actually happened.
* crtngdir <- "Creating Directory"
* dircreated <- "Directory Created"
* dirnotcreated <- "Directory already exists, no new directory created"
* filecreated <- "File Downloaded"
* unzpngfl <- "Unzipping files"
* filesunzp <- "Files Unzipped"
* filenotcreated <- "File already exists, no file downloaded"
* downloadingfile <- "Downloading File, this may take some time.  Approximately 4 to 7 minutes."
* Addlbry <- "Loading a few libraries to ensure proper operation."
* Clnup <- "Cleaning up un needed objects."


## Library Loads that are needed to download and manipulate the data.
First line prints "Loading a few libraries to ensure proper operation."  to the screen.  These libraries are necessary  for downloading and manipulating the files.

* Addlbry

The next three lines load the appropriate libraries

* library(dplyr)
* library(downloader)
* library(reshape2)


## Declares the Directory the data will be downloaded into.
DataFiles <- "Smart_Phone_Data"


## Checks to see if the Directory 'Smart_Phone_Data' exists.

If the directory ‘Smart_Phone_Data’ does not exist  it will create it; if it does it continues to next command. This is the directory the zip file will be down loaded to then unzipped.  Also included in here are the call outs to the user letting the user know if the file/directory exists and whether or not it will be created.

if (!file.exists(DataFiles)) {
     crtngdir 
     dir.create(DataFiles)
     dircreated
 } else { dirnotcreated}


## Checks to see if the zip file exists.

If the zip file does not exist it will download it, if it does it continues to the next command.  Also included in here are the call outs to the user to let the user know if the zip file is already exists then down loads it or not depending on the results. 

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


## Reads X_train.txt file into a data frame (memory)
X_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/X_train.txt")


## Reads Y_train.txt into a data frame (memory)
Y_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/Y_train.txt")


## Reads subject _train.txt into a data frame (memory)
subject_train <- read.table("Smart_Phone_Data/UCI HAR Dataset/train/subject_train.txt")


## Reads X_test into a data frame (memory)
X_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/X_test.txt")


## Reads Y_test.txt into a data frame (memory)
Y_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/Y_test.txt")


## Reads subject _test.txt  into a data frame (memory)
subject_test <- read.table("Smart_Phone_Data/UCI HAR Dataset/test/subject_test.txt")


## merges Y_train data frame, subject_train, and X_train data frame into one a data frame (memory) by columns
merged_train<- cbind(Y_train,subject_train, X_train) 


## merges Y_test data frame, subject_test, and X_test data frame into one a data frame (memory) by columns
merged_test <- cbind(Y_test,subject_test,X_test)


##merges  merged_train and merged_test data frames into on data frame (memory)
combined <- rbind(merged_train, merged_test) 


## Reads features.txt into a data frame (memory)
feature <- read.table("Smart_Phone_Data/UCI HAR Dataset/features.txt") 


## Changes column two to character so it can be used later
feature <- as.character(feature$V2) 


## Names columns 1 and two
colnames(combined)[1:2] <- c("Activity","Subject") 


##Names columns 3 through 563 using the names from feature
colnames(combined)[3:563] <- feature 


## Selects all columns with headers that include mean or std(standard deviation)
* meanstd <- grep("std|mean", names(combined)) 
* meanstd2 <- combined[ ,c(1,2, meanstd)]


## Reads the labels from activity_labels.txt.
* activity <- read.table("Smart_Phone_Data/UCI HAR Dataset/activity_labels.txt") 
* activity <- rename(activity, Activitycode = V1, Activity = V2)


## Replaces the Activitycode with a descriptive name in column 2.
* merged <- merge(activity, meanstd2, by.x = "Activitycode", by.y = "Activity") 
* merged2 <- select(merged, -Activitycode) 


## Replaces (substitutes)  “^t”  with “Time” and “^f” with “Frequency”
* names(merged2) <- sub("^t", "Time", names(merged2)) 
* names(merged2) <- sub("^f", "Frequency", names(merged2))


## writes the text file “tidydata.txt” to the working directory
* MeltActSub <- melt(merged2, id=c("Activity", "Subject"))
* means <- dcast(MeltActSub, Subject + Activity ~ variable, mean)
* write.table(means, "tidydata.txt", row.names = FALSE)


## Clean up.  Removes un-needed variables to free up memory.
The first prints "Cleaning up un needed objects."
* Clnup 

The following cleans up the objects stored in memory.
* rm(X_train)
* rm(Y_train)
* rm(subject_train)
* rm(X_test)
* rm(Y_test)
* rm(subject_test)
* rm(combined)
* rm(feature)
* rm(activity)
* rm(crtngdir)
* rm(dircreated)
* rm(dirnotcreated)
* rm(filecreated)
* rm(unzpngfl)
* rm(filesunzp)
* rm(filenotcreated)
* rm(downloadingfile)


## Timer stop.  This calculates the time it took to run the code.
proc.time() – ptm


# Definitions of Codes Used in run_analysis.R script
* proc.time():   Returns five elements for backwards compatibility, but its print method prints a named vector of length 3. The first two entries are the total user and system CPU times of the current R process and any child processes on which it has waited, and the third entry is the ‘real’ elapsed time since the process was started.

* if():  The if/else statement conditionally evaluates two statements. There is a condition which is evaluated and if the value is TRUE then the first statement is evaluated; otherwise the second statement will be evaluated. The if/else statement returns, as its value, the value of the statement that was selected.

* else():  The if/else statement conditionally evaluates two statements. There is a condition which is evaluated and if the value is TRUE then the first statement is evaluated; otherwise the second statement will be evaluated. The if/else statement returns, as its value, the value of the statement that was selected.

* file.exists ():   Rreturns a logical vector indicating whether the files named by its argument exist. (Here ‘exists’ is in the sense of the system's stat call: a file will be reported as existing only if you have the permissions needed by stat. Existence can also be checked by file.access, which might use different permissions and so obtain a different result. Note that the existence of a file does not imply that it is readable: for that usefile.access.) What constitutes a ‘file’ is system-dependent, but should include directories. (However, directory names must not include a trailing backslash or slash on Windows.) Note that if the file is a symbolic link on a Unix-alike, the result indicates if the link points to an actual file, not just if the link exists. Lastly, note the different function exists which checks for existence of R objects.

* dir.create():    Creates the last element of the path, unless recursive = TRUE. Trailing path separators are discarded. On Windows drives are allowed in the path specification and unless the path is rooted, it will be interpreted relative to the current directory on that drive. mode is ignored on Windows.	

* paste():   Paste converts its arguments (via as.character) to character strings, and concatenates them (separating them by the string given by sep). If the arguments are vectors, they are concatenated term-by-term to give a character vector result. Vector arguments are recycled as needed, with zero-length arguments being recycled to "".

* download.file():  The function download.file can be used to download a single file as described by url from the internet and store it in destfile. The url must start with a scheme such as http://, https://, ftp:// orfile://.

* unzip():  Extract files from or list a zip archive.

* read.table():  Reads a file in table format and creates a data frame from it, with cases corresponding to lines and variables to fields in the file.

* cbind():   Take a sequence of vector, matrix or data-frame arguments and combine by columns, respectively. These are generic functions with methods for other R classes.

* rbind():  Take a sequence of vector, matrix or data-frame arguments and combine by rows, respectively. These are generic functions with methods for other R classes.

* as.character():  Create or test for objects of type "character".  as.character represents real and complex numbers to 15 significant digits (technically the compiler's setting of the ISO C constant DBL_DIG, which will be 15 on machines supporting IEC60559 arithmetic according to the C99 standard). This ensures that all the digits in the result will be reliable (and not the result of representation error), but does mean that conversion to character and back to numeric may change the number. If you want to convert numbers to character with the maximum possible precision, use format.

* combine():  This is an efficient implementation of the common pattern of do.call(rbind, dfs) or do.call(cbind, dfs) for binding many data frames into one. combine() acts like c() or unlist() but uses consistent dplyr coercion rules.

* grep():  Search for matches to argument pattern within each element of a character vector: they differ in the format of and amount of detail in the results.

* c():  his is a generic function which combines its arguments.

* rename():  The rename function provides an easy way to rename the columns of a data.frame or the items in a list.

* merge():  Merge two data frames by common columns or row names, or do other versions of database join operations.

* select():  keeps only the variables you mention.

* sub():  Replace the first occurrence of a pattern.

* melt():  You need to tell melt which of your variables are id variables, and which are measured variables. If you only supply one of id.vars and measure.vars, melt will assume the remainder of the variables in the data set belong to the other. If you supply neither, melt will assume factor and character variables are id variables, and all others are measured.

* dcast():  Use acast or dcast depending on whether you want vector/matrix/array output or data frame output. Data frames can have at most two dimensions.

* write.table():  write.table prints its required argument x (after converting it to a data frame if it is not one nor a matrix) to a file or connection.

* mean():  Generic function for the (trimmed) arithmetic mean.

## References
From Rstudio via help view

* Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.
* Chambers, J. M. (1992) Data for models. Chapter 3 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.
* Hadley Wickham (20Feb2015) Flexibly reshape data



