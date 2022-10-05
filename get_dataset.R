source("helpers.R")

DATASET_FILENAME <- "dataset.zip"

# Downloads dataset only if not already present
if (!file.exists(DATASET_FILENAME)) {
  download_dataset(DATASET_FILENAME)
} else {
  print("Zip file already exists")
}

# Extracts dataset only if not already extracted
if (!file.exists("UCI HAR Dataset")){
  unzip(DATASET_FILENAME)
  print("Zip file successfully extracted")
} else {
  print("Zip file already extracted")
}


