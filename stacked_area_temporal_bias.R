library(ggplot2)
library(dplyr)
library(noaastormevents)
library(forcats)


all_years <- 1950:2019
year_events <- vector("list", length(all_years))

for( i in 1:length(all_years)) {
  year_to_run <- all_years[i]
  print(year_to_run)
  events <- create_storm_data(date_range = c(paste(year_to_run, "01-01", sep = "-"), 
                                             paste(year_to_run, "12-31", sep = "-")))
  
  
  event_count<- events %>%
    group_by(EVENT_TYPE) %>%
    count() %>% 
    mutate(year = year_to_run)
  year_events[[i]] <- event_count
  
  # Remove data after each year (otherwise, this is lots of data)
  rm(noaastormevents_package_env)
}

year_events_df <- bind_rows(year_events)

write.csv(year_events_df, 'year_events_data.csv', row.names = TRUE)

year_events_df <- read.csv("year_events_data.csv")


stacked_graph_data <- year_events_edit %>% 
  filter(EVENT_TYPE == c("Tornado", "Hail", "Heat", "Dense Fog")) 

ggplot(stacked_graph_data, aes(x = year, y = n, fill= EVENT_TYPE)) + 
  geom_area()



# all event types 
ggplot(year_events_edit, aes(x = year, y = n, fill= EVENT_TYPE)) + 
  geom_area()+ 
  geom_vline(xintercept = 1996)

fct_lump_min(f, 40000, w = NULL, other_level = "Other")


# source types (using for loop from temporal_bias_source)
ggplot(source_type_all_df, aes(x = year, y = n, fill = SOURCE)) +
  geom_area() +
  geom_vline(xintercept = 1996)



