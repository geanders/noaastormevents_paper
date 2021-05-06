library(noaastormevents)
library(dplyr)

all_years <- 1950:2019
source_type_all <- vector("list", length(all_years))


for( i in 1:length(all_years)) {
  year_to_run <- all_years[i]
  print(year_to_run)
  events <- create_storm_data(date_range = c(paste(year_to_run, "01-01", sep = "-"), 
                                             paste(year_to_run, "12-31", sep = "-")))
  
  
  source_count<- events %>%
    group_by(SOURCE, EVENT_TYPE) %>%
    count() %>% 
    mutate(year = year_to_run)
  source_type_all[[i]] <- source_count
  
  # Remove data after each year (otherwise, this is lots of data)
  rm(noaastormevents_package_env)
}

source_type_all_df <- bind_rows(source_type_all)
