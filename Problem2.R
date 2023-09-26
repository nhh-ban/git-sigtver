####Problem 2####
#Load packages
library(tidyverse)

#Load data
raw_data <- readLines("suites_dw_Table1.txt")

#Find line number to split raw data on
Line_num <- 
  (substr(raw_data, start = 1, stop = 3) == "---") %>% #Check if the first three characters is "---", returns a vector og T/F
  which(. == TRUE) #Retun linenumber of the TRUE line

## Save file description to text file
description <-
  cat(raw_data[1:(Line_num-2)], sep = "\n", file = "Desctiption.txt")

## Save columnames to vector
col_names <- 
  str_split(string = raw_data[(Line_num-1)], pattern = "\\|") %>% 
  unlist() %>% 
  str_trim()

# Create comma seperated file
data_csv <- 
  raw_data[(Line_num+1):length(raw_data)] %>% 
  gsub("\\|", ",", .) %>% 
  gsub(" ", "", .) %>% 
  append(
    c(paste(col_names, collapse =",")),#Append headers
    after = 0
  ) %>% 
  cat(., sep = "\n", file = "suites_dw_Table1_cleaned.csv")

galaxies <- read_csv("suites_dw_Table1_cleaned.csv")
