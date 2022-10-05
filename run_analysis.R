test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")[,2]


names(test_x) <- features
names(train_x) <- features

column_indices <- grep("(mean\\(|std\\()", features)

test_x <- test_x[,column_indices]
train_x <- train_x[,column_indices]


names(test_y) <- "Activity"
names(train_y) <- "Activity"

names(test_subject) <- "Subject"
names(train_subject) <- "Subject"

test <- cbind(test_subject, test_y, test_x)
train <- cbind(train_subject, train_y, train_x)

data <- rbind(test, train)

activities <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
data$Activity <- sapply(data$Activity, function(x) {activities[x]})


data$Subject <- as.factor(data$Subject)
data$Activity <- as.factor(data$Activity)

tidy_data <- data %>% group_by(Activity, Subject) %>% summarise(across(.cols = everything(), mean, .names = "mean_{col}"))


# Remove unnecessary objects
rm(list=ls()[grep("test|train|full|features|activities", ls())])

write.table(tidy_data, "tidy_data.txt")
          
