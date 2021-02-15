#Class 5 Assignment
library(palmerpenguins)
library(tidyverse)
glimpse(penguins)
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
                     size = body_mass_g,
                     alpha = flipper_length_mm)) +
  geom_point(size = 2, alpha = 0.5)+
  facet_grid(species~sex) +
  guides(color= FALSE)
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length(mm)",
       color = "Species",
       caption = "Source: Palmer Station LTER / palmer penguin package") +
scale_color_viridis_d()
