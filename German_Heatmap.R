library(sp)
library(latticeExtra)
### load the German federal state polygons
my.data <- readRDS("DEU_adm1.rds")
sample <- read.csv(file.choose())
final <- merge(x =my.data@data, y = sample, by = "ID_1", all.y = TRUE)
my.data@data <- data.frame(my.data@data, final[match(my.data@data[,"ID_1"], final[,"ID_1"]),])
### German language hick-ups need to be resolved
enamessp <- gsub("?", "ue", my.data@data$NAME_1)
my.data@data$NAME_1 <- enamessp
final$clickpercent <- round(prop.table(final$Tweets)*100,2)
### insert the newly created Conversion variable into the spatial data frame
my.data$Tweets <- final$Tweets
clrs <- c('#F4F1A2',
          '#E6EAA2',
          '#E6EAA2',
          '#9AD0A3',
          '#9AD0A3',
          '#7FC9A4',
          '#7FC9A4',
          '#32B9A3',
          '#32B9A3',
          '#00A7A2',
          '#00A7A2',
          '#00667E',
          '#00667E',
          '#1D4F73',
          '#1D4F73',
          '#1D4F73'
)
spplot(my.data, zcol = "Tweets", main = "Region Distribution(in %)", 
       col.regions = clrs)
