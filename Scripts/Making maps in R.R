#Making maps
library(ggplot2)
library(maps)
library(mapdata)
usa<-map_data("usa")
#plotting the map
ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)
gg1 <- ggplot() + 
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = "violet", color = "blue") + 
  coord_fixed(1.3)
#adding points
sites <- data.frame(
  long = c(-101.4078, -101.306417),
  lat = c(36.951968, 47.644855),
  names = c("P1", "P2"),
  stringsAsFactors = FALSE
)  

gg1 + 
  geom_point(data = sites, aes(x = long, y = lat), color = "black", size = 5) +
  geom_point(data = sites, aes(x = long, y = lat), color = "yellow", size = 4)
## plotting statess
states<-map_data("state")
ggplot(data = states) + 
  geom_polygon(aes(x = long, y = lat, fill = region, group = group), color = "white") + 
  coord_fixed(1.3) +
  guides(fill=FALSE)  # do this to leave off the color legend
new_england <- subset(states, region %in% c("massachusetts", "maine", "new hampshire","connecticut","vermont","rhode island"))

ggplot(data=new_england)+geom_polygon(aes(x=long,y=lat),fill="blue",color="white")+coord_fixed(1.3)

#plotting MA
MA_df<-subset(states,region=="massachusetts")
head(MA_df)
counties <- map_data("county")
MA_county <- subset(counties, region == "massachusetts")
#plot base map
MA_base <- ggplot(data = MA_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")

#https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html

#world map
install.packages("cowplot", "googleway", "ggplot2", "ggrepel", 
                   "ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata")
library("ggplot2")
theme_set(theme_bw())
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
install.packages("rgeos")
library("rgeos")
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)
ggplot(data = world) +
  geom_sf(aes(fill = pop_est)) +
  scale_fill_viridis_c(option = "plasma", trans = "sqrt")
#https://www.r-spatial.org/r/2018/10/25/ggplot2-sf.html
#https://www.molecularecologist.com/2012/09/making-maps-with-r/

install.packages("patchwork")
install.packages ("gisr")
install.packages ("glitr")
# install.packages("devtools")
devtools::install_github("thomasp85/patchwork")
