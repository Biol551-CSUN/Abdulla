library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)


# plot 1
p1<-penguins %>%
  ggplot(aes(x = body_mass_g,
             y = bill_length_mm,
             color = species)) +
  geom_point()

p1

#plot 2
p2<-penguins %>%
  ggplot(aes(x = sex,
             y = body_mass_g,
             color = species)) +
  geom_jitter(width = 0.2)

p2
            
p1+p2 + 
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')


#if you want the plots on top of each other then 
p1/p2 +
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')

View(mtcars)

ggplot(mtcars, aes(x = wt, 
          y = mpg,
          label = rownames(mtcars))) +
  geom_text_repel() + #REPEL AWAY there is also geom_label_repel()
  geom_point(color = 'red')

penguins %>%
  ggplot(aes(x = body_mass_g,
             y = bill_depth_mm,
             color = species)) +
  geom_point() +
  transition_states(
    year, #what are we animating by
    transition_length = 2, #the relative length of the transition
    state_length = 1, #the length of the 
  )+
  ease_aes("sine-in-out") + #linear is the default
  ggtitle('Year: {closest_state}') +
  anim_save(here("Week_9", "Output", "mypengus.gif"))

penguin<-image_read("URL HERE")
penguin

