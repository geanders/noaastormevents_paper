library(noaastormevents)
library(dplyr)

all_years <- 1950:2020
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

# Renaming event types to current NWS documentation according to @nwsinstruction

year_events_df %>% 
  mutate(EVENT_TYPE = case_when(
    EVENT_TYPE == "THUNDERSTORM WIND/ TREE" ~ "Thunderstorm Wind", 
    EVENT_TYPE == "THUNDERSTORM WIND/ TREES" ~ "Thunderstorm Wind",
    EVENT_TYPE == "Hurricane" ~ "Hurricane/Typhoon",
    EVENT_TYPE == "Hurricane (Typhoon)" ~ "Hurricane/Typhoon",
    TRUE ~ EVENT_TYPE
  ))




library(ggplot2)

year_events_df %>% 
  filter(EVENT_TYPE == c("Tornado", "Thunderstorm Wind", "Heavy Rain", "Hail")) %>% 
  filter(year!= 2020) %>% 
  ggplot(aes(x = year, y = n)) + 
  geom_point() + 
  geom_line() + 
  facet_wrap(~ EVENT_TYPE, scales = "free_y") 







