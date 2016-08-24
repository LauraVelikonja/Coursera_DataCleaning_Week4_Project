# Set working directory
setwd(".../Data Mining/Coursera/03_DataCleaning/Week4")

#******* Load in test & training set and concatenate them *********#

# Feature list
features <- read.table("Data/UCI HAR Dataset/features.txt")
# Mapping table for activities
act_level <- read.table("Data/UCI HAR Dataset/activity_labels.txt")
colnames(act_level)<-c("act_code","activity")

dim(features)
table(features[,2])

# Create placeholder for data.frame
data <- data.frame()

# Loop through test and training sets and concatenate
for (set in c("train","test")){
        X <- read.table(paste0("Data/UCI HAR Dataset/",set,"/X_",set,".txt"))
        colnames(X)<-features[,2]
        
        Y_pre <- read.table(paste0("Data/UCI HAR Dataset/",set,"/y_",set,".txt"))
        colnames(Y_pre)<-"outcome_activity"
        
        subject <-  read.table(paste0("Data/UCI HAR Dataset/",set,"/subject_",set,".txt"))#tells which to which individuals features belong
        colnames(subject)[1]<-"volunteer"
        
        total_pre <- cbind(subject,X,Y_pre)
        
        # Uses descriptive activity names to name the activities in the data set by joining with act_level
        # Note that merging is only done after cbind, because merging rearranges the rows
        total<- merge(total_pre, act_level, by.x = "outcome_activity", by.y = "act_code")
        
        
        data <- rbind(data, total)

}



#******** Extracts mean and standard deviation for each measurement.*********#

data.mean_std <- data[,grepl(".mean.|.std.",names(data))]

data.activity <- data["activity"]
data.volunteer <- data["volunteer"]

# Adds columns volunteer and activity again to the data set
data.new <- cbind(data.volunteer, data.mean_std, data.activity)


#******** Creates a second, independent tidy data set with the **************#
#******** average of each variable for each activity and each subject. ******#
library(dplyr)
data_byact_byvol <- group_by(data.new,  volunteer, activity)

data.tidy <- summarise_each(data_byact_byvol,funs(mean))


write.table(data.tidy, "data_tidy.csv")


