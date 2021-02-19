library(ggplot2)
library(dplyr)

# create data
# using csv file created in temporal_bias_event_type 

stacked_graph_data <- year_events_edit %>% 
  filter(EVENT_TYPE == c("Tornado", "Hail", "Heat", "Dense Fog")) 

ggplot(stacked_graph_data, aes(x = year, y = n, fill= EVENT_TYPE)) + 
  geom_area()

# all event types 
ggplot(year_events_edit, aes(x = year, y = n, fill= EVENT_TYPE)) + 
  geom_area()
