# Getting and Cleaning Data Project

require(data.table) 
require(reshape2) 
require(plyr) 
require(dplyr)

# Load the various files 
ytrain <- read.table("y_train.txt", sep="") 
xtrain <- read.table("X_train.txt", sep="") 
subjecttrain <- read.table("subject_train.txt", sep="") 

xtest <- read.table("X_test.txt", sep="") 
ytest <- read.table("y_test.txt", sep="") 
subjecttest <- read.table("subject_test.txt", sep="") 

features <- read.table("features.txt", sep="", col.names=c("index","feature")) 
activities <- read.table("activity_labels.txt", sep="", col.names=c("activity_code","activity")) 

# Part 1: Start merging data 
traindata <- cbind(ytrain, subjecttrain, xtrain) 
testdata <- cbind(ytest, subjecttest, xtest) 
finaldata <- rbind(traindata, testdata) 
 
# Removing/deleting data 
rm(ytrain, subjecttrain, xtrain, ytest, subjecttest, xtest, traindata, testdata) 

# Part 2: Find the mean and standard deviation using grepl 
features <- features[grepl("mean()|std()",features$feature),] 
finaldata <- finaldata[,c(1,2,features$index+2)] 

# Part 3: Give meaningful activity names 
feature_names <- as.character(features$feature) 
names(finaldata) <- c("subject","activity_code",feature_names) 

# Part 4: Merge to substitute meaningful names for activity labels 
finaldata <- merge(finaldata, activities, by.x="activity_code",  
                by.y="activity_code", all=TRUE)[, c("subject","activity", feature_names)] 
 
# Part 5: Summarize & create tidydata 
finaldata <- melt(finaldata,id=c("subject","activity"),measure.vars=feature_names) 
finaldata <- ddply(finaldata,.(subject,activity,variable), summarize, avg=mean(value), sd=sd(value)) 

# Write to file
write.table(finaldata, "tidydata.txt", row.names=FALSE) 
