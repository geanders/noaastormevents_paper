set.seed(23235)
ss <- sample(1:150, 10)
hc <- iris[ss, -5] %>%
  dist() %>%
  hclust()
dend2 <- hc %>% as.dendrogram()

plot(dend2)
rect.dendrogram(dend2, 2, border = 2)
rect.dendrogram(dend2, 3, border = 4)
Vectorize(rect.dendrogram, "k")(dend, 4:5, border = 6)

plot(dend2)
rect.dendrogram(dend, 3,
                border = 1:3,
                density = 2, text = c("1", "b", "miao"), text_cex = 3
)

dend15 <- c(1:5) %>%
  dist() %>%
  hclust(method = "average") %>%
  as.dendrogram()
# dend15 <- c(1:25) %>% dist %>% hclust(method = "average") %>% as.dendrogram
dend15 %>%
  set("branches_k_color") %>%
  plot()
dend15 %>% rect.dendrogram(
  k = 3,
  border = 8, lty = 5, lwd = 2
)
