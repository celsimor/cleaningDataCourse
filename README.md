Data cleaning programming assignment
=================================

## Assumptions

The script assumes that it is executed inside the  "UCI HAR DATASET" folder, and will create a new file inside that folder with the output

I also assume that we only want those variables that have a mean and std present in the data set. These variables are listed in the code book file. 
I realize that in the data there are some meanFreq variables, but i chose to ignore them since I don't consider them means. They are easily added by removing the FIXED=TRUE command

## Operation

The script runs a bit in a different order than strictly required, because i want to reduce the size of the data sets as soon as possible.

As such, the script first reads the features, and parses all mean and std features from the features list. This gives the names and column index of the required features.

Once the required features are established, the script reads in the data as follows:
*  read in X data set of train and test
* remove unwanted data
* merge X data
* add names
* read in the action data of train and test
* merge action data
* add names
* read in subject data of train and test
* merge subject data
* add names
* merge subject, Y, and X data in single data frame.

Note that during merging, the training set always comes first, the test set second.

Once all data is loaded, the script runs a loop over all subjects and actions. For each subject - action pair it takes the all the data, calculates the mean, and stores it in a new data set.

Next, once the final data is gathered, the script replaces all numeric indices of actions with human readable actions. I do this last, since i think the script operates faster when handling numeric data as opposed to character data.
Finally, the data is writted to a txt file. I did not write it to a csv file, because the file upload button in coursera only supports limited extensions, of which txt is one, and the data format is space delimited, instead of comma separated value.




 