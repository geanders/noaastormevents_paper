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






