#read the features names
features <- read.table('UCI HAR Dataset/features.txt');
features <- features$V2;

#read the training and testing data
training <- read.table('UCI HAR Dataset/train/X_train.txt');
testing <- read.table('UCI HAR Dataset/test/X_test.txt');

#binding the two datasets
tidy_data <- rbind(training,testing);
names(tidy_data) <- features;

#get names of the column that contain mean and standerd deviation of the measurements
req_col_names <- c(grep('std',features,value=TRUE),grep('mean',features,value=TRUE));

#read the activites 
activites <- c(read.table('UCI HAR Dataset/train/y_train.txt')$V1,read.table('UCI HAR Dataset/test/y_test.txt')$V1)
act_label <- read.table('UCI HAR Dataset/activity_labels.txt');
activites <- factor(activites,labels=act_label$V2);

#binding the activites column
tidy_data$activity <- activites;
tidy_data_res <- tidy_data[c(req_col_names,'activity')];
tidy_data_res$subject <- seq.int(nrow(tidy_data_res));
tidy_data_res <- aggregate( . ~ subject + activity, data = tidy_data_res, FUN = mean )

#write the results
write.table( tidy_data_res, "averagedata.txt", row.names = FALSE )
