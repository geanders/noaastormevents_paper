library(noaastormevents)
library(dplyr)

all_years <- 1990:2019
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



