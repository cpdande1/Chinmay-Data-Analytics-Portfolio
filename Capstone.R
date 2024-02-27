install.packages("ggplot2")
library(ggplot2)

View(apr2020)


ggplot(data=cyclistic_data) + geom_bar(mapping = aes(x=day_of_week, fill=member_casual)) + facet_wrap(~member_casual) + labs(title = "Days with highest usage of Bike Share", subtitle = "Based on Member Preference" )

ggplot(data=cyclistic_data) + geom_point(mapping = aes(x=member_casual, y= rider_length)) + facet_wrap(~day_of_week)+labs(title = "Casual and Annual Members favourite Day of Week", subtitle = "Based on Rider Length")

cyclistic_data <- rbind(apr2020, June2020, may2020)
View(cyclistic_data)

install.packages("dplyr")
library(dplyr)
cyclistic_data 