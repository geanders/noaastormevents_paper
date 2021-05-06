
                                                  
ggplot(source_type_all_df, aes(y=SOURCE, x=year, fill=n)) + 
  geom_tile(colour="white", linewidth=2, 
            width=.9, height=.9) + theme_minimal() +
  scale_fill_gradientn(colors= terrain.colors(10), limits=c(0, 4000),
                       breaks=seq(0, 4e3, by=1e3), 
                       na.value=rgb(246, 246, 246, max=255),
                       labels=c("0k", "1k", "2k", "3k", "4k"),
                       guide=guide_colourbar(ticks=T, nbin=50,
                                             barheight=.5, label=T, 
                                             barwidth=10)) +
  scale_x_continuous(expand=c(0,0), 
                     breaks=seq(1930, 2010, by=10)) +
  geom_segment(x=1996, xend=1996, y=0, yend=51.5, size=.9) +
  labs(x="", y="", fill="") +
  ggtitle("Measles") +
  theme(legend.position=c(.5, -.13),
        legend.direction="horizontal",
        legend.text=element_text(colour="grey20"),
        plot.margin=grid::unit(c(.5,.5,1.5,.5), "cm"),
        axis.text.y=element_text(size=6, family="Helvetica", 
                                 hjust=1),
        axis.text.x=element_text(size=8),
        axis.ticks.y=element_blank(),
        panel.grid=element_blank(),
        title=element_text(hjust=-.07, face="bold", vjust=1, 
                           family="Helvetica"),
        text=element_text(family="URWHelvetica")) +
  annotate("text", label="Vaccine introduced", x=1963, y=53, 
           vjust=1, hjust=0, size=I(3), family="Helvetica")
