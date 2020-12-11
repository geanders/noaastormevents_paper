
library(dplyr)
library(noaastormevents)

events_2019 <- create_storm_data(date_range = c("2019-01-01", "2019-12-31"))

event_reporting_areas <- tribble(
  ~ event_type, ~ reporting_area,
  "Astronomical Low Tide", "Forecast Zone", 
  "Avalanche", "Forecast Zone", 
  "Blizzard", "Forecast Zone",
  "Coastal Flood", "Forecast Zone",
  "Cold/Wind Chill", "Forecast Zone", 
  "Debris Flow", "County",
  "Dense Fog", "Forecast Zone", 
  "Dense Smoke", "Forecast Zone",
  "Drought", "Forecast Zone",
  "Dust Devil", "County",
  "Dust Storm", "Forecast Zone",
  "Excessive Heat", "Forecast Zone",
  "Extreme Cold/Wind Chill", "Forecast Zone",
  "Flash Flood", "County",
  "Flood", "County",
  "Freezing Fog", "Forecast Zone",
  "Frost/Freeze", "Forecast Zone",
  "Funnel Cloud", "County",
  "Hail", "County",
  "Heat", "Forecast Zone",
  "Heavy Rain", "County",
  "Heavy Snow", "Forecast Zone",
  "High Surf", "Forecast Zone",
  "High Wind", "Forecast Zone",
  "Hurricane/Typhoon", "Forecast Zone",
  "Ice Storm", "Forecast Zone",
  "Lakeshore Flood", "Forecast Zone",
  "Lake-Effect Snow", "Forecast Zone",
  "Lightning", "County",
  "Marine Dense Fog", "Marine Zone",
  "Marine Hail", "Marine Zone",
  "Marine Heavy Freezing Spray", "Marine Zone",
  "Marine High Wind", "Marine Zone", 
  "Marine Hurricane/Typhoon", "Marine Zone", 
  "Marine Lightning", "Marine Zone", 
  "Marine Strong Wind", "Marine Zone", 
  "Marine Thunderstorm Wind", "Marine Zone", 
  "Marine Tropical Depression", "Marine Zone", 
  "Marine Tropical Storm", "Marine Zone", 
  "Rip Current", "Forecast Zone", 
  "Seiche", "Forecast Zone", 
  "Sleet", "Forecast Zone",
  "Sneaker Wave", "Forecast Zone", 
  "Storm Surge/Tide", "Forecast Zone", 
  "Strong Wind", "Forecast Zone", 
  "Thunderstorm Wind", "County", 
  "Tornado", "County", 
  "Tropical Depression", "Forecast Zone", 
  "Tropical Storm", "Forecast Zone", 
  "Tsunami", "Forecast Zone", 
  "Volcanic Ash", "Forecast Zone", 
  "Waterspout", "Marine Zone", 
  "Wildfire", "Forecast Zone", 
  "Winter Storm", "Forecast Zone", 
  "Winter Weather", "Forecast Zone"
)



event_type_2019 <-events_2019 %>%
  mutate(EVENT_TYPE = case_when(
    EVENT_TYPE == "Sneakerwave" ~ "Sneaker Wave", 
    EVENT_TYPE == "Hurricane" ~ "Hurricane/Typhoon",
    EVENT_TYPE == "Volcanic Ashfall" ~ "Volcanic Ash",
    TRUE ~ EVENT_TYPE
  )) %>% 
  rename(event_type = EVENT_TYPE) %>% 
  group_by(event_type) %>%
  summarize(N = n()) %>%
  arrange(desc(N))



reporting_categories <- tribble(
  ~ event_type, ~ reporting_standard, 
  "Astronomical low tide", "impact, noteworthiness, public interest", 
  "Avalanche" , "impact, noteworthiness, public interest",  
  "Coastal Flood ", "impact, noteworthiness, public interest" ,
  "  Dense Fog ", "impact, noteworthiness, public interest" ,
  "Dense Smoke ", "impact, noteworthiness, public interest" ,
  "Dust Devil ", "impact, noteworthiness, public interest" ,
  "Dust Storm ","impact, noteworthiness, public interest",
  "Flash Flood", "impact, noteworthiness, public interest",
  "Flood", "impact, noteworthiness, public interest" ,
  "Freezing Fog", "impact, noteworthiness, public interest" , 
  "Funnel Cloud" , "impact, noteworthiness, public interest" ,
  "Freezing Fog" , "impact, noteworthiness, public interest" ,
  "Funnel Cloud" , "impact, noteworthiness, public interest" ,
  "Heavy Rain" , "impact, noteworthiness, public interest" ,
  "High Surf" , "impact, noteworthiness, public interest" , 
  "Lakeshore Flood" , "impact, noteworthiness, public interest" ,
  "Lightning" , "impact, noteworthiness, public interest" ,
  "Marine Dense Fog" , "impact, noteworthiness, public interest" ,
  "Marine Hail" , "impact, noteworthiness, public interest" ,
  "Marine Heavy Freezing Spray" , "impact, noteworthiness, public interest" ,
  "Marine High Wind" , "impact, noteworthiness, public interest" ,
  "Marine Hurricane/Typhoon","impact, noteworthiness, public interest" , 
  "Marine Lightning" , "impact, noteworthiness, public interest" ,
  "Marine Strong Wind" , "impact, noteworthiness, public interest" ,
  "Marine Thunderstorm Wind" , "impact, noteworthiness, public interest" ,
  "Marine Tropical Depression" , "impact, noteworthiness, public interest" ,
  "Marine Tropical Storm" , "impact, noteworthiness, public interest" ,
  "Rip Currents" , "impact, noteworthiness, public interest" ,
  "Seiche" , "impact, noteworthiness, public interest" ,
  "Sneaker Wave" , "impact, noteworthiness, public interest" ,
  "Storm Surge/Time" , "impact, noteworthiness, public interest", 
  "Strong Wind ", "impact, noteworthiness, public interest" , 
  "Thunderstorm Wind" , "impact, noteworthiness, public interest" ,
  "Tsunami" , "impact, noteworthiness, public interest" ,
  "Volcanic Ash" , "impact, noteworthiness, public interest" ,
  "Wildfire" , "impact, noteworthiness, public interest" ,
  "Winter Weather" , "impact, noteworthiness, public interest",
  "Blizzard", "intensity",
  "Cold/Wind Chill ", "intensity",
  "Debris Flow", "intensity",
  "Excessive Heat", "intensity",
  "Extreme Cold/Wind Chill", "intensity",
  "Frost", "intensity",
  "Hail", "intensity",
  "Heat", "intensity",
  "Heavy Snow", "intensity",
  "High Wind ", "intensity",
  "Hurricnae/Typhoon", "intensity",
  "Ice Storm", "intensity",
  "Lake Effect Snow", "intensity",
  "Sleet", "intensity",
  "Tornado", "intensity",
  "Tropical Depression", "intensity",
  "Tropical Storm", "intensity",
  "Waterspout", "intensity",
  "Winter Storm", "intensity"
)

final_table <- event_type_2019 %>%
  full_join(event_reporting_areas) %>% 
  full_join(reporting_categories) %>% 
  mutate(N = case_when(
    is.na(N) ~ as.integer(0), 
    TRUE ~ N 
  )) %>% 
  mutate(N = prettyNum(N, big.mark = ",")) %>%
  knitr::kable(col.names = c("Event type", "Number of events in 2019", "Reporting Area", 
                             "Reporting Standard"))



