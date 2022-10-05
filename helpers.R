# This function handles the downloading of the zip dataset
#   - file_name: The name to be given to the downloaded file

download_dataset <- function(file_name) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  # For some reason, downloading through R takes a long time
  # Here I set the timeout option to 600 seconds to allow for the whole download
  
  old_timeout = getOption("timeout")
  new_timeout = 600
  
  print(paste0("Previous timeout option set to: ", old_timeout, "s"))
  
  options(timeout = new_timeout)
  print(paste0("Changing it to: ", new_timeout, "s"))
  
  
  print("Downloading file...")
  
  download.file(url , file_name)
  
  print("File downloaded!")
  
  # Reversing to previous setting
  
  options(timeout = old_timeout)
  print(paste0("Reversing timeout option to: ", old_timeout, "s"))
}