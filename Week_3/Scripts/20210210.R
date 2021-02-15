### Today we are going to plot penguin data ###
### Created by: Jasmin Abdulla ###
### Updated on: 2021-02-09 ###


#### Load Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)



### Load data ###
# The data is part of the package and is called penguins
# How else besides glimpse can we inspect the data?
glimpse(penguins)

ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) +
  geom_point()+
  geom_smooth(method="lm")+
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)"
       ) +
  scale_color_manual(values = c("#1F262EFF","#353831FF","#833437FF")) +
  theme_bw() +
  theme(axis.title=element_text(size = 20,
                                color = "purple"),
        panel.background = element_rect(fill="white")) +
  ggsave(here("Week_3", "Output", "penguin.png"),
         width = 7, height = 5)
  #scale_color_viridis_d() +
  #scale_x_continuous(breaks = c(14,17,21),
                     #labels = c("low", "medium", "high"))
library(ghibli)


