co2_NOAA <- read_delim("ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_weekly_mlo.txt", 
                  delim=" ", 
                  skip=49, 
                  col_names = c("yr","mon","day","year","co2","nbdays","1yr","10yr","since_1800"), 
                  trim_ws = TRUE)

co2_NOAA <- subset(co2_NOAA, select=c("year","co2"))
co2_NOAA <- subset(co2_NOAA, co2!=-999.99)

co2_ice_captured <- read_delim("ftp://ftp.ncdc.noaa.gov/pub/data/paleo/icecore/antarctica/epica_domec/edc-co2-2008.txt", 
                  delim=" ", 
                  skip=774, 
                  col_names = c("age", "co2"),
                  trim_ws = TRUE)

Present_Year = 2008

co2_ice_captured$year = Present_Year - co2_ice_captured$age

co2_ice_captured <- subset(co2_ice_captured, select=c("year","co2"))

co2_combined <- rbind(co2_NOAA, co2_ice_captured)


ggplot(co2_combined, aes(x = year, y = co2)) +
  geom_line() +
  geom_point() +
  geom_smooth(method="lm", se=FALSE, color="red") + 
  scale_x_continuous(labels = function(x) format(x, scientific = FALSE))
