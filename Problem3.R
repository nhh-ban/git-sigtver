library(tidyverse)
library(ggplot2)

##Read data
galaxies <- read_csv("suites_dw_Table1_cleaned.csv")

#Split into 20 categiries, by magnitude (m_b), and count number of galaxies
breaks <- hist(galaxies$m_b, breaks = 20, plot = F)

#Find average frequency
average_freq <- breaks$counts/sum(breaks$counts)
average_freq <- 
  as.data.frame(x = average_freq) %>% 
  mutate(breaks = breaks$mids)

###find theoretical distribution
x = seq(from = -25, to = 0, by =.1)
norm_fun <- 
  data.frame(
    x = x,
    y = dnorm(x,mean = mean(average_freq$breaks), sd = sd(average_freq$breaks))
  )

#Plot the findings
ggplot()+
  geom_col(data = average_freq, aes(x = breaks, y = average_freq))+
  geom_line(data = norm_fun, aes(x = x, y = y), colour = "red") +
  labs(x = "Absolute Magnitude (m_b)", y = "Relative frequency")

##We can see that we would expect that there were fewer larger objects,
#and more smaller objects. A possible explenation is that is is harder to 
#observe smaller objects.
