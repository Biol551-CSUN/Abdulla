library(tidyverse)

df <- tibble::tibble(
  a = rnorm(10), #draws 10 ranodm vlaues from normal distribution
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10),
  )

head(df)

df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(a, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(a, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(a, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))
#this is for rescaling column individually

rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/max(x, na.rm = TRUE)-min(x, na.rm = TRUE)
  return(value)
}

df %>%
  mutate(a = rescale01(a),
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))
# There are 3 key steps to creating a new function
 #1 you need to pick a name for the function, rescale01 was used because it rescales a vector to lie between 0 and 1
 #2 you list the inputs or arguments to the function inside finction. 
  #3 you place the code you have developed in body of function a {block that immediately follow function (...)}
  #4 return tells us what vlaues we want returned when you run the function
# note it is way easier to create a function wjhen you aleady wrote code instrerad from scratch

#change F to C 

fahrenheit_to_celsius <- function(temp_F) {
  temp_C <- (temp_F - 32) * 5/9
  return(temp_C)
}

fahrenheit_to_celsius(32)


celsius_to_kelvin <- function(temp_C) {
  temp_K <- (temp_C + 273.15)
  return(temp_K)
}

celsius_to_kelvin(0)

library(palmerpenguins)
library(PNWColors)

myplot<-function(data = penguins, x, y, lines=TRUE) #add new argument
  labs(x = "Body mass (g)", 
       y = "Flipper length (mm)")
  
{
if(lines==TRUE){
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette

ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
  geom_point() +
  geom_smooth(method = "lm")+ #add a linear model
  scale_color_manual("Island", values=pal)+ #use colors and change
  theme_bw()

}
  
  else{
    
  }

a <- 4
b <- 5
#suppose that if a > b then f should be = to 20, else f should be equal to 10. using if/else we:

if (a > b) 

