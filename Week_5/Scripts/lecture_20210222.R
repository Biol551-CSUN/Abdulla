### Lecture : 2021-02-22 ###
### NEW Dataset ###


### Libraries ####
library(tidyverse)
library(here)


### Data Sets ###
#Thermal performance data
TPCData<-read_csv(here("Week_5", "Data", "Topt_data.csv"))
view(TPCData)
Data_dict<-read_csv(here("Week_5", "Data", "data_dictionary.csv"))
view(Data_dict)
#Enviromental data from each site
EnviroData<-read_csv(here("Week_5", "Data", "site.characteristics.data.csv"))
view(EnviroData)

glimpse(EnviroData)
glimpse(TPCData) #also use View


### Coding ###

EnviroData_wide <- EnviroData %>%
  pivot_wider(names_from=parameter.measured, 
              values_from = values) %>%
  arrange(site.letter) #arrange the dataframe by site

View(EnviroData_wide)

FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) #relocate all the number data after the character data
## Joining, by = "site.letter"

### Class Assignment ###
fulldata_summary <- FullData_left %>%
  pivot_longer(cols= E:substrate.cover,
               values_to="values",
               names_to = "measurements") %>%
  group_by(site.letter, measurements) %>%
  summarise(meanVal=mean(values), var(values))


head(FullData_left)

### Lab Classwork ###

#Make 1 tibble
T1 <- tibble(Site.ID = c("A", "B", "C", "D"),
             temperature = c(14.1, 16.7, 15.3, 12.8))

T1

#Make another tibble
T2 <- tibble(Site.ID = c("A", "B", "D", "E"),
             pH = c(7.3, 7.8, 8.1, 7.9))

T2

left_join(T1, T2)  
##joining, by = "Site.ID"

right_join(T1, T2)
##joining, by = "Site.ID"

inner_join(T1, T2) #keeps columns from both data sets, keeps only complete

full_join(T1, T2) #keeps all data incl missing

semi_join(T1, T2) #keeps one column (temp kept in this case), shows everything that is consistent

anti_join(T1, T2) #saves all rows in the first data set but do not match anything in the second data set, this can help you find missing data across data sheets

install.packages("cowsay")
library(cowsay)
say("feed me", by = "poop")
