
## Project: Getting And Cleaning Data

This is the repository for my submission to the Week 4 project of the
Coursera course Getting And Cleaning Data from the Johns Hopkins
University.

### Downloading the dataset

In order to download the dataset, the get_dataset.R script must be run
first. It will handle both the download and the extraction of the
dataset. The name of the dataset file can be changed at the start of the
script. The default name is "dataset.zip".

### Tidying the data

The cleaning and tidying of the data is done by the script
run_analysis.R. 
It first merges all the original data, before calculating the average of each 
variable for a given activity and subject.
This script outputs a .txt file with the clean data. 
The default name for this output file is "tidy_data.txt" but it can be
changed at the start of the script.

### Tidy dataset

The tidy dataset created by run_analysis.R gathers the averages of each variable for a given activity and subject.

The variables within are described in codebook.md.
