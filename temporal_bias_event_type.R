events_2019 %>%
  group_by(EVENT_TYPE) %>%
  summarize(N = n()) %>%
  arrange(desc(N)) %>%
  mutate(N = prettyNum(N, big.mark = ",")) %>%
  knitr::kable(col.names = c("Event type", "Number of events in 2019"))


events_2019 %>%
  group_by(EVENT_TYPE) %>%
  count() %>%
  knitr::kable(col.names = c("Event type", "Number of events in 2019"))

library(noaastormevents)
library(dplyr)

data(package = "noaastormevents")
storms <- unique(hurr_tracks$storm_id)
storm_years <- gsub(".+-", "", storm_id_table$storm_id)

storm_events <- vector("list", length(storms))
names(storm_events) <- storms

for(storm_year in unique(storm_years)){
  print(storm_year)
  yearly_storms <- storms[storm_years == storm_year]
  for(storm in yearly_storms){
    print(storm)
    i <- which(storms == storm)
    this_storm_events <- find_events(storm = storm, dist_limit = 500) %>%
      dplyr::rename(type = event_type) %>%
      dplyr::mutate(fips = stringr::str_pad(fips, width = 5, side = "left", pad = "0")) %>%
      dplyr::select(fips, type) %>%
      dplyr::group_by(fips) %>%
      dplyr::summarize(events = list(type))
    storm_events[[i]] <- this_storm_events
  }
  # Remove data after each year (otherwise, this is lots of data)
  rm(noaastormevents_package_env)
}
