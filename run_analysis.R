OUTPUT_FILE_NAME = "tidy_data"
REMOVE_UNNECESSARY_OBJECTS = TRUE

library(dplyr)

#################################
#         Reading files         #
#################################

if (!file.exists("UCI HAR Dataset/"))
  stop("The dataset appears to be missing. Please run get_dataset.R first.")

test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")[,2]
activities <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

#################################
#    Formating feature names    #
#################################

mean_pattern <- "mean\\(\\)"
std_pattern <- "std\\(\\)"

mean_indices <- grep(mean_pattern, features)
std_indices <- grep(std_pattern, features)

# Finds and changes feature names from type tBodyGyroJerk-mean()-X to type tBodyGyroJerkX_mean
features[mean_indices] <- sapply(gsub("-", "", sub(mean_pattern, "", features[mean_indices])), function(x) {paste0(x, "_mean")})

# Finds and changes feature names from type tBodyGyroJerk-std()-X to type tBodyGyroJerkX_std
features[std_indices] <-sapply(gsub("-", "", sub(std_pattern, "", features[std_indices])), function(x) {paste0(x, "_std")})

names(test_x) <- features
names(train_x) <- features


names(test_y) <- "Activity"
names(train_y) <- "Activity"

names(test_subject) <- "Subject"
names(train_subject) <- "Subject"


#################################
#     Merging the datasets      #
#################################

# Find the columns with mean() or std() in their name (notice the double escape character before the parenthesis)
column_indices <- grep("_mean$|_std$", features)

test_x <- test_x[,column_indices]
train_x <- train_x[,column_indices]

test <- cbind(test_subject, test_y, test_x)
train <- cbind(train_subject, train_y, train_x)

data <- rbind(test, train)

# Changes Activity from integer to descriptive factor
data$Activity <- sapply(data$Activity, function(x) {activities[x]})

# Convert to factor variable
data$Subject <- as.factor(data$Subject)
data$Activity <- as.factor(data$Activity)


#################################
#      Creating tidy_data       #
#################################

# Creates tidy_data by averaging the values of the columns for Activities and Subjects
tidy_data <- data %>% group_by(Activity, Subject) %>% summarise(across(.cols = everything(), mean, .names = "average_{col}"))

# Write the output file
write.table(tidy_data, paste0(OUTPUT_FILE_NAME, ".txt"))


if (REMOVE_UNNECESSARY_OBJECTS) {
rm(list=c("activities", "column_indices", "data", "features", "mean_indices", 
          "mean_pattern", "std_indices", "std_pattern", "test", "test_subject",
          "test_x", "test_y", "train", "train_subject", "train_x", "train_y", 
          "OUTPUT_FILE_NAME", "REMOVE_UNNECESSARY_OBJECTS"))
}          
