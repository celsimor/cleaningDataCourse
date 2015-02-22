####
## Decide which variables should be gathered, by looking at the features list
####

## read in features
features = read.table("features.txt")

## only get interesting features => mean and standard deviation
## note that there are also freq mean variables, but i did not think they should have been added. 
## 
meanIndex = grep("mean()",features[,2],fixed=TRUE)
stdIndex = grep("std",features[,2],fixed=TRUE)
## create index of mean and the names
totalIndex = c(meanIndex,stdIndex)
## order totalIndex
totalIndex = totalIndex[order(totalIndex)]
## get variable names, remove default factor variable
totalNames = as.character(features[totalIndex,2])

####
## Read in data, merge data sets, merge with subject and action
####

## read in test data
testData = read.table("test//X_test.txt")
testData = testData[,totalIndex]
## read in train data
trainData = read.table("train//X_train.txt")
trainData = trainData[,totalIndex]
#merge data
totalData = rbind(trainData,testData)
names(totalData) = totalNames
## clear large unneded vars
remove(testData,trainData)

testAction = read.table("test//y_test.txt")
trainAction = read.table("train/y_train.txt")

totalAction = rbind(trainAction,testAction)


testSubject = read.table("test//subject_test.txt")
trainSubject = read.table("train//subject_train.txt")

totalSubject = rbind(trainSubject,testSubject)

remove(testSubject,trainSubject,testAction,trainAction)

names(totalAction) = c("action")
names(totalSubject) = c("subject")

totalData = cbind(totalSubject,totalAction,totalData)


####
## For each subject and action that we have, go through data and calculate mean.
## Bind into new data frame
## This can likely be done in a single exotic R command, but this to me is more clear
####

newData = data.frame()
for( subject in 1:max(totalSubject)){
    for( action in 1:max(totalAction)){
        val = totalData[totalData$subject==subject & totalData$action==action,]
        
        newData = rbind(newData,sapply(val,mean))
    }
}
names(newData) = names(totalData)

## add human readable activity labels
labels = read.table("activity_labels.txt")

for(index in 1:nrow(newData)){
    newData$action[index] = as.character(labels[labels$V1==newData$action[index],2])
}

## write to table
write.table(newData,"dataCleaningAssignment.txt"66)
