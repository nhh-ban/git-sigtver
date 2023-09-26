library(tidyverse)
library(ggplot2)

galaxies <-   read_csv("suites_dw_Table1_cleaned.csv")

ggplot(data = galaxies, aes(x = a_26))+
  geom_histogram()
