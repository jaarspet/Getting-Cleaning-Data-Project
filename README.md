# Getting-Cleaning-Data-Project ReadMe

Pre-work: Load the data and useful packages 

The first step is to read the data into R and load packages. 

Part 1: Merge the data

cbind() used to merge the subject, X, and y variables and rbind() to merge the training and test datasets. 
All data sets that are not useful anymore can be removed/deleted

Part 2: Subset the data to find mean and standard deviation
Only the mean and std variation used. grep() used to find column names that contain "mean" or "std" and  subsetted the data, taking only those columns as well as the subject_id and activity columns. 

Part 3: Give labels to the data
The "subject" and "y" variables are the subject_id and activity, therefore renamed their column. For the "X" variable, the column names are in the "features" variable.
"y" changed to a factor variable and replaced the numbers with the activity names, found in the "activity_labels" variable. 

Part 4: Merge to substitute meaningful names for activity labels
The mean taken of each variable, for each subject and activity and stored in finaldata

Part 5: Summarize & create tidydata
The last step creates the final tidy data set which is written and stored to the disk as "tidydata.txt"
