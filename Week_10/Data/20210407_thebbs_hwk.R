### Shiny App - TWins
### Created by: The Pengus - Roland, Jamie, Jasmin, and Claudia
### Created on: 2021-04-07

# Load Libraries
library(tidyverse)
library(here)
library(lubridate)
library(shiny)
library(tvthemes)
library(RColorBrewer)
library(ggthemes)

# Load Data
BB <- read.csv(here("Week_10","Data","HatchBabyExport.csv"))

# Wrangle Data
Bubble_Buns <- BB %>%
  mutate(DateTime = mdy_hm(Start.Time)) %>% 
  mutate(DateTime = round_date(DateTime, "hour")) %>%
  separate(DateTime,
           into = c("Date","Time"), " ") %>%
  mutate(DayNight = recode(Time, "07:00:00" = "Day",  "08:00:00" = "Day", "09:00:00" = "Day",
                           "10:00:00" = "Day", "11:00:00" = "Day", "12:00:00" = "Day",
                           "13:00:00" = "Day", "14:00:00" = "Day", "15:00:00" = "Day",
                           "16:00:00" = "Day", "17:00:00" = "Day", "18:00:00" = "Day",
                           "19:00:00" = "Night", "20:00:00" = "Night", "21:00:00" = "Night",
                           "22:00:00" = "Night", "23:00:00" = "Night", "00:00:00" = "Night",
                           "01:00:00" = "Night", "02:00:00" = "Night", "03:00:00" = "Night",
                           "04:00:00" = "Night", "05:00:00" = "Night", "06:00:00" = "Day")) %>%
  select(Baby.Name,Date,Time,Activity,Amount, DayNight) %>% 
  filter(Activity %in% c("Feeding","Diaper")) %>% 
  group_by(Baby.Name, Date, DayNight) %>% 
  count(Activity)

Bubble_Buns2 <- BB %>%
  mutate(DateTime = mdy_hm(Start.Time)) %>% 
  mutate(DateTime = round_date(DateTime, "hour")) %>%
  separate(DateTime,
           into = c("Date","Time"), " ") %>%
  mutate(DayNight = recode(Time, "07:00:00" = "Day",  "08:00:00" = "Day", "09:00:00" = "Day",
                           "10:00:00" = "Day", "11:00:00" = "Day", "12:00:00" = "Day",
                           "13:00:00" = "Day", "14:00:00" = "Day", "15:00:00" = "Day",
                           "16:00:00" = "Day", "17:00:00" = "Day", "18:00:00" = "Day",
                           "19:00:00" = "Night", "20:00:00" = "Night", "21:00:00" = "Night",
                           "22:00:00" = "Night", "23:00:00" = "Night", "00:00:00" = "Night",
                           "01:00:00" = "Night", "02:00:00" = "Night", "03:00:00" = "Night",
                           "04:00:00" = "Night", "05:00:00" = "Night", "06:00:00" = "Day")) %>%
  select(Baby.Name,Date,Time,Activity,Amount, DayNight) %>% 
  filter(Activity %in% c("Diaper")) %>% 
  group_by(Baby.Name, Date, DayNight) %>% 
  count(Amount)

# Define UI
ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "united"),
  # Application title
  titlePanel("How much does each baby poop and eat?"),
  
  # Sidebar with a dropdown menu for breed
  sidebarLayout(
    sidebarPanel(
      dateInput(
        inputId = "Date",
        label = "Date",
        value = "2021-02-18",
        min = "2021-02-18", max = "2021-04-05"
      ), width = 3 
    ),
    
    # Show a plot of the city-wide distribution
    mainPanel(
      column(
        10, # column() modifies the layout (# is the column width)
        h4("Frequency of Feeding And Diaper Changes"),
        plotOutput("activity")
      ),
      p(), # a line break
      p(),
      column(
        10,
        h4("Types of Stool"),
        plotOutput("diaper")
      )
    ) # /mainPanel
  )
) # /fluidPage

server <- function(input, output){
  rBB <- reactive({
    Bubble_Buns %>% 
      filter(Date == input$Date)
  })
  rBB2 <- reactive({
    Bubble_Buns2 %>% 
      filter(Date == input$Date)
    
  })
  output$activity <- renderPlot({
    rBB() %>% 
      ggplot(aes(x = factor(DayNight),
                 y = factor(n), 
                 fill = Activity))+
      geom_bar(stat = "identity", position = "dodge", width = 0.75) +
      facet_wrap(~Baby.Name) +
      theme_avatar()+
      theme(plot.title=element_text(hjust=0.5, #centered figure title in bold
                                    size = 18, face= 2,
                                    family = "serif"),
            plot.subtitle = element_text (hjust = 0.5),
            strip.text = element_text(size = 20, face = 2, 
                                      family = "serif"))+
      labs(x = "Day or Night", y = "Number of Activities")+
      scale_fill_attackOnTitan()
  })
  output$diaper <- renderPlot({
    rBB2() %>% 
      ggplot(aes(x = factor(DayNight),
                 y = factor(n),
                 fill = Amount))+
      geom_bar(stat = "identity", position = "dodge", width = 0.75) +
      facet_wrap(~Baby.Name) +
      theme_avatar()+
      theme(plot.title=element_text(hjust=0.5, #centered figure title in bold
                                    size = 18, face= 2,
                                    family = "serif"),
            plot.subtitle = element_text (hjust = 0.5),
            strip.text = element_text(size = 20, face = 2, 
                                      family = "serif"))+
      labs(x = "Day or Night", y = "Number of Diaper Changes", fill = "Type")+
      scale_fill_attackOnTitan()
  })
}

shinyApp(ui = ui, server = server)



