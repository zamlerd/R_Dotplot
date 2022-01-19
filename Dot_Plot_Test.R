install.packages("readr")
library(ggplot2)
chart1 <- read.csv("~/Documents/Giulio_Jian/chart_A2E97138271E1641077445013.csv")
chart2 <- read.csv("~/Documents/Giulio_Jian/chart_A2E97138271E1641078659632.csv")
dotplot(chart1, x = "GeneRatio", color = "p.adjust")
ggdotplot(chart1, chart1$Fold.Enrichment , chart1$PValue, label = chart1$Term )
dotplot(chart1, groups = TRUE)
ggplot(data = chart3, aes(x = sample , y = Term, color = `PValue`, size = Fold.Enrichment)) + 
  geom_point() +
  scale_color_gradient(low = "red", high = "blue") +
  theme_bw() + 
  ylab("") + 
  xlab("") + 
  ggtitle("GO enrichment analysis")

dotplot(chart1, showCategory=20) +ggtitle("Significantly Enriched Pathways")
dotplot(chart1, x = "Fold.Enrichment", color = "p.adjust")

chart1$sample <- "NSC"
chart2$sample <- "GSC"

chart3 <- rbind(chart1, chart2)
library(ggplot2)
library(dplyr)
library(stringr)
library(DOSE)

## count the gene number
gene_count<- x@result %>% group_by(ID) %>% summarise(count = sum(str_count(core_enrichment, "/")) + 1)

## merge with the original dataframe
dot_df<- left_join(x@result, gene_count, by = "ID") %>% mutate(GeneRatio = count/setSize)

## plot
library(forcats) ## for reordering the factor
ggplot(dot_df, aes(x = GeneRatio, y = fct_reorder(Description, GeneRatio))) + 
  geom_point(aes(size = GeneRatio, color = p.adjust)) +
  theme_bw(base_size = 14) +
  scale_colour_gradient(limits=c(0, 0.10), low="red") +
  ylab(NULL) +
  ggtitle("GO pathway enrichment")