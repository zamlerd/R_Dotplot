install.packages("ggplot2")
library(ggplot2)

###Read in the datasets###
chart1 <- read.csv("~/Documents/Giulio_Jian/chart_A2E97138271E1641077445013.csv")
chart2 <- read.csv("~/Documents/Giulio_Jian/chart_A2E97138271E1641078659632.csv")

###Assign Sample Name###
chart1$sample <- "NSC"
chart2$sample <- "PM-NSC"

###Combine Samples and Strip MMU******###
chart3 <- rbind(chart1, chart2)
chart3$Term <- gsub("^.{0,9}", "", chart3$Term)


###Plot###
ggplot(data = chart3, aes(x = sample , y = Term, color = `PValue`, size = Fold.Enrichment)) + 
  scale_y_discrete(limits = rev(unique(sort(chart3$Term)))) +
  geom_point() +
  scale_color_gradient(low = "red", high = "blue") +
  theme_bw() + 
  ylab("") + 
  xlab("") + 
  ggtitle("KEGG Enrichment Analysis")

