library(noaastormevents)

events_2019 <- create_storm_data(date_range = c("2019-01-01", "2019-12-31"))

top_episodes <- events_2019 %>%
  group_by(EPISODE_ID) %>%
  summarize(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1:12)

episode_narratives <- events_2019 %>% 
  filter(EPISODE_ID %in% 
           top_episodes$EPISODE_ID) %>% 
  select(EPISODE_ID, EPISODE_NARRATIVE) %>% 
  distinct()

dendrogram_descriptions <- tribble(
  ~EPISODE_ID, ~description,
  133275, "Moderate to strong atmospheric river in California",
  133801, "An atmospheric river and cold front near Mount Saint Helena",
  133994,"An atmospheric river in the North Bay",
  136054,"Several severe storms along southern plains",
  135416, "Squall line of thunderstorms in South Carolina",
  138800,"Heat wave in eastern New York",
  135253,"971mb bomb cyclone moving out of the Rockies", 
  138645,"Frontal boundary over the mid-Atlantic creating a
  low pressure wave",
  135643,"Line of thunderstorms",
  141710,"Strong cold front and deep upper level trough in the Ozarks",
  137355, "Multiple storms over Missouri Ozarks",
  142499,"A powerful coastal storm along New Jersey to the Northeast"
)



episode_narratives %>% 
  left_join(dendrogram_descriptions) %>% 
  knitr::kable(col.names = c("EPISODE_ID", "EPISODE_NARRATIVE", "description"))

