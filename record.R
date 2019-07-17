library(openxlsx)
library(lubridate)
library(magrittr)
library(dplyr)
library(ggplot2)

data = read.xlsx("C:\\Users\\kulu8001\\Desktop\\R\\Sports app record\\record.xlsx", sheet=1, colNames=T)
data$Date = as.POSIXct(data$Date, format="%Y-%m-%d %M:%S")

data$duration = as.numeric(substr(data$Duration,1,2)) + as.numeric(substr(data$Duration,4,5))/60
data$start_time = minute(data$Date) + second(data$Date)/60
data$end_time = data$start_time + data$duration

Sys.setlocale("LC_TIME", "English")
data$DOW = weekdays(data$Date)
data$DOW = as.factor(data$DOW)
data$DOW = factor(data$DOW, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
data$month = month(data$Date)


ggplot(data) +
  geom_segment(aes(x=start_time, xend=end_time, y=DOW, yend=DOW, color=Activity), size=10) +
  scale_color_manual(values = c("Bike"="lightblue2", "Walk"="lightpink", "Yoga"="darkseagreen1")) +
  labs(x="Time (minutes)", y="Day of Week", title="Workout Activity Timeline") 

ggplot(data) +
  geom_segment(aes(x=start_time, xend=end_time, y=DOW, yend=DOW, color=Activity), size=10) +
  scale_color_manual(values = c("Bike"="lightblue2", "Walk"="lightpink", "Yoga"="darkseagreen1")) +
  labs(x="Time (minutes)", y="Day of Week", title="Workout Activity Timeline") +
  facet_grid(Activity~.)


ggplot(data, aes(DOW, month)) + 
  geom_tile(aes(fill = duration)) + 
  scale_fill_gradient(low = "aliceblue", high = "lightskyblue") +
  labs(x="Day of Week", y="Month", title="Workout Duration between Weekdays and Months", fill="Duration") +
  facet_grid(Activity~.) +
  theme_bw() +
  theme(strip.background = element_rect("lightsteelblue2")) 

