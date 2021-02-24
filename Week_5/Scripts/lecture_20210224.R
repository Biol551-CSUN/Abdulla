### Lecture on 2021-02-24 ###


install.packages("lubridate")
library(tidyverse)
library(here)
library(lubridate)

now()
now(tzone = "EST") #what time is it on the east coast
now(tzone = "GMT") #what time in GMT

today()
today(tzone = "GMT") #what the date is in the time zone

am(now()) #is it morning?
leap_year(now()) #is it a leap year?

ymd("2021-02-24") #year month date
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")

ymd_hms() #year month date _ hour min sec
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

#make a character string
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
#convert to datetimes
datetimes <- mdy_hms(datetimes)
month(datetimes) #gives month number, Feb =2 for ex
month(datetimes, label = TRUE) #spells month out
month(datetimes, label = TRUE, abbr = FALSE) #spells the month out


day(datetimes) #extract day
wday(datetimes, label = TRUE) #extra day of week
hour(datetimes) #extract hour
minute(datetimes) #extract minute
second(datetimes) #extract second

datetimes + hours(4) #this adds 4 hours
#hours with an S adds the time, hour without the S, takes off the time
datetimes + days(2) #this adds 2 days 
# similar to hours, if not plural it takes away the day 

round_date(datetimes, "minute") #round to nearest minute
round_date(datetimes, "5 mins") #round ot nearest 5 minute
