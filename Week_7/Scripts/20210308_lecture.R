# Lecture 2021-03-08 ###

# Load libraries
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)

# Data

#Read in data on population in California by county
popdata<-read_csv(here("Week_7", "Data", "CApopdata.csv"))
popdata

#read in data on number of seasstarts at different field sites
stars<-read_csv(here("Week_7", "Data", "stars.csv"))
stars

# Maps
#get data for the entire world 
world<-map_data("world")

head(world)

# get data for the USA
usa<-map_data("usa")

usa

#get data for italy
italy<-map_data("italy")

head(italy)

# get data for states
states<-map_data("state")

head(states)

#get data for counties
counties<-map_data("county")

head(counties)

# long is longitude 
# lat is latitutde
# Order shows in which order ggplot should "connec the dots"
# region and subregion tell what region or subregion a set of points surrounds
# group:  this is very important! ggplot2s functions can take a group arguments
# .. which controls (amongst other things) etc - what stays together as an individual polyglon, when you go to plot it you have to say taht, the group is the column name
# .. this is individual polyglons that stay together

ggplot() + 
  geom_polygon(data = world, aes(x = long, y=lat, group = group, fill = region), 
               color = "black") +
  guides(fill = FALSE) +
  theme_minimal() + 
  theme(panel.background = element_rect(fill = "lightblue")) +
  coord_map(projection = "sinusoidal",
         xlim = c(-180,180))

#mercator instead of sinusoidal for a flat one that exemplifies the USA

head(states) #use the states data set
CA_data<-states %>%
  filter(region == "california")

ggplot() + 
  geom_polygon(data = CA_data, aes(x = long, y=lat, group = group, fill = region), 
               color = "light green", fill = "cyan") +
  guides(fill = FALSE) +
  theme_minimal() + 
  theme(panel.background = element_rect(fill = "orange")) +
    coord_map()+
  theme_void()

# look at the county data
head(counties)[1:3,] #only showing the first 3 rows for spaces

#look at the county data
head(popdata)

CApop_county<-popdata %>%
  select("subregion" = County, Population) %>% #rename the county col
  inner_join(counties) %>%
  filter(region == "california") #some counties have same names in others states 
ggplot() +
  geom_polygon(data = CApop_county,
               aes(x = long, 
                   y = lat, 
                   group = group,
                   fill = Population),
               color = "black") +
  geom_point(data = stars, # add a points
             aes(x = long,
                 y = lat,
                 size = star_no)) + #size changes to how many stars
  coord_map() +
  theme_void() +
  scale_fill_gradient(trans = "log10") +  #transform to log10 scale
  labs(size = "# stars/m2") + 
  ggsave(here("Week_7", "Output", "CApop.png"))

head(stars)

library(spongebob)
