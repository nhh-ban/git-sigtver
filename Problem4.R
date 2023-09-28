#Load packages
library(tidyverse)

#####Data wrangling#####
#Load data
raw_data <- readLines("UCNG_Table4.txt")

#Find line number to split raw data on
Line_num <- 
  (substr(raw_data, start = 1, stop = 3) == "---") %>% #Check if the first three characters is "---", returns a vector og T/F
  which(. == TRUE) #Retun linenumber of the TRUE line


## Save column names to vector
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
  cat(., sep = "\n", file = "UCNG_Table4.csv")



####Taks 1#####
##Load data
velocity <- read_csv("UCNG_Table4.csv")
distance <- read_csv("suites_dw_Table1_cleaned.csv")

#Join tables
galaxies <- 
  full_join(velocity, distance) %>% 
  select(name, cz, D)

#Plot findings
ggplot(galaxies, aes(x = D, y = cz))+
  geom_point() +
  geom_smooth(method = "lm") +
  xlab("Distance")+
  ylab("Velocit")

#### TAsk 2####
reg <- lm(galaxies$cz~galaxies$D, data = galaxies)
print(reg$coefficients[2])






