# EDA of Iowa liquor

library(tidyverse)
library(magrittr)
library(plotly)
library(janitor)
library(skimr)
library(vroom)
#
# Import the data

iowa <- vroom('Data/iowa_liquor.csv')
iowa <- janitor::clean_names(iowa)
# this may take a while on 1.27M records and 24 columns!
skim(iowa)
#
head(iowa)
# Summarize the counties in the data set. How many?
unique(iowa$county)
#

#IA_counties <- tigris::list_counties("Iowa")
#write_csv(IA_counties,"Data/IA_counties.csv")
IA_counties <- read_csv("Data/IA_counties.csv")
head(IA_counties)
#
county2 <- iowa |> 
  mutate(county2 = str_to_title(county)) |>
  pull(county2)

# which values from county2 are in the master list of counties?
unique(county2)[unique(county2) %in% IA_counties$county]

# which values from county2 are NOT in the master list of counties?
unique(county2)[!unique(county2) %in% IA_counties$county]

IA_counties$county

iowa %<>% mutate(county2 = str_to_title(county),
                 county2 = ifelse(county2=="Pottawatta","Pottawattamie",county2),
                 county2 = ifelse(county2=="Buena Vist","Buena Vista",county2),
                 county2 = ifelse(county2=="Cerro Gord","Cerro Gordo",county2))
iowa |> pull(county2) |> unique(.data)

#
iowa %<>% mutate(date=lubridate::mdy(date))
summary(iowa$date)
#
iowa_2020 <- iowa |> 
  mutate(year=lubridate::year(date)) |> 
  filter(year==2020)
#
#saveRDS(iowa_2020,"Data/iowa_2020.RDS")
#iowa_2020 <- readRDS("Data/iowa_2020.RDS")
iowa_2020 |> pull(category_name) |> unique(.data)
#
iowa_2020 |> 
  summarize(total_volume_l = sum(volume_sold_liters,na.rm=T),
            total_sales_dollars = sum(sale_dollars,na.rm=T),
            num_counties = n_distinct(county2),
            num_vendors = n_distinct(vendor_number))

# sales by county, dollars (arranged by sales)
# sales by county, volume in liters

iowa_2020 |> 
  group_by(county2) |> 
  summarize(sales_dollars = sum(sale_dollars,na.rm=T),
            sales_volume = sum(volume_sold_liters,na.rm=T)) |> 
  arrange(desc(sales_dollars))
# sales in dollars by category name

iowa_2020 |> 
  group_by(category_name) |> 
  summarize(sales_dollars = sum(sale_dollars,na.rm=T),
            sales_volume = sum(volume_sold_liters,na.rm=T)) |> 
  arrange(desc(sales_dollars))
# most frequently sold by counts of category name
iowa_2020 |> janitor::tabyl(category_name) |> arrange(desc(n))
# 
iowa_2020 %<>% mutate(big_cat = "other",
                      big_cat = ifelse(str_detect(category_name,"Whisk"),"Whisky",big_cat),
                      big_cat = ifelse(str_detect(category_name,"Vodk"),"Vodka",big_cat),
                      big_cat = ifelse(str_detect(category_name,"Rum"),"Rum",big_cat),
                      big_cat = ifelse(str_detect(category_name,"Gin"),"Gin",big_cat),
                      big_cat = ifelse(str_detect(category_name,"Liqueur"),"Liqueur",big_cat))

# most frequently sold by counts of simplified category name
iowa_2020 |> janitor::tabyl(big_cat) |> arrange(desc(n)) |> ggplot(aes(x=big_cat,y=percent))+ geom_col()

head(iowa_2020)

iowa_2020 |> 
  group_by(lubridate::month(date)) |> 
  summarise(sales_dollars = sum(sale_dollars,na.rm=T)) |> 
  rename(month=`lubridate::month(date)`) |> 
  plot_ly(x = ~month, y = ~sales_dollars, type = 'scatter', mode = 'lines')
