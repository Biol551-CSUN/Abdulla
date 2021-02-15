### Today we are going to plot penguin data ###
### Created by: Jasmin A ####
### Updated on: 2021-02-15 ####


### Load Libraries ###
library(palmerpenguins)
library(tidyverse)
library(here)


### Load data ###
# The data is part of the package and is called penguins #
glimpse(penguins)
filter(.data = penguins, sex == "female") #filter for female only

filter(.data = penguins, year == "2008" )   #filter for year 2008
filter(.data = penguins, body_mass_g >"5000") #filter for body mass over 5000

filter(.data = penguins, sex == "female", body_mass_g > 4000) #females over 4000

filter(.data = penguins, sex == "female" & body_mass_g > 4000) #& means and

filter(.data = penguins, year == "2008" | year == "2009") # 2008 or 2009
filter(.data = penguins, !island == "Dream") #not including Dream
filter(.data = penguins, species =="Adelie" & "Gentoo") #only Adelie and Gentoo species

filter(.data = penguins, body_mass_g < 5000, body_mass_g > 3000) #less than 5000 and greater than 3000

data2<-mutate(.data = penguins, body_mass_kg = body_mass_g/1000) #changing kg to g in body mass

data2<-mutate(.data = penguins, body_mass_kg = body_mass_g/1000,
              bill_length_depth = bill_length_mm/bill_depth_mm) #convert mass to kg, calc ratio of bill length to depth
View(data2) #view data sheet

data2<-mutate(.data = penguins,
              after_2008 = ifelse(year>2008, "After 2008", "Before 2008")) #looking outside year 2008 
View(data2) #view data sheet

data2<-mutate(penguins, 
              flipper_length_body_mass = flipper_length_mm + body_mass_g) #create a new column to add flipper length and body mass together

data2<-mutate(penguins,
              sex_cap = ifelse( sex == "male", "Male", "Female")) #new column for male and female capitalized
View(data2)


penguins %>% #use penguin dataframe #%>% is called  THE PIPE
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(Species = species, island, sex, log_mass) #specifically select these columns also Species = species capitalized the S in species

penguins %>%
  summarise(mean_flipper = mean (flipper_length_mm, na.rm=TRUE),#this removes all the na's
            min_flipper = min(flipper_length_mm, na.rm=TRUE))

penguins %>%
  group_by(island) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm=TRUE),
            max_bill_length = max(bill.length.mm, na.rm=TRUE))

penguins %>%
  drop_na(sex) %>% #drop all na's within sex
  ggplot(aes(x = sex, y=flipper_length_mm)) + #PLOTS HAVE A + NOT A PIPE
  geom_boxplot() #boxplot graph


library(devtools)
install_github("jhollist/dadjoke")
