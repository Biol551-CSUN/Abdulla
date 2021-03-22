### Tidy Tuesday: Gaming ###
### Date: 2021-03-22 ###
### By: Jasmin Abdulla ###


### Load Libraries ###
library(tidyverse)
library(here)
library(tidytuesdayR)


### Load Data ###
tuesdata <- tt_load('2021-03-16')

games <- tuesdata$games

### Graphing ###
games$month <- as.factor(games$month) #change month from character to factor so we can rename levels
games$month <- recode_factor(games$month, #rename month levels to numbers
                             January = "1",
                             February = "2",
                             March = "3",
                             April = "4",
                             May = "5",
                             June = "6",
                             July = "7",
                             August = "8",
                             September = "9",
                             October = "10",
                             November = "11",
                             December = "12")

games$month <- as.numeric(games$month) #change month to numeric so that we can make a line graph

games %>%
  select("gamename", "year", "month", "peak") %>%
  filter(complete.cases(.),
         year > "2017" & year < "2021",
         gamename == "PLAYERUNKNOWN'S BATTLEGROUNDS" | gamename == "Counter-Strike: Global Offensive" | gamename == "Dota 2") %>%
  ggplot(aes(x = month,
             y = peak,
             color = gamename)) +
  geom_line(size = 2) +
  facet_wrap(~year) +
  theme_classic() +
  scale_x_continuous(breaks = seq(1, 12, 1),  #specify x-axis spacing
                     labels = c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D")) + #rename months
  scale_y_continuous(expand = c(0, 0)) +
  labs(x = "Month",
       y = "Peak",
       title = "Peak of Players in Top Three Games",
       caption = "Source: SteamCharts")