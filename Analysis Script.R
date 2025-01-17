# Analysis Script for Mobile Market Data

library(tidyverse)

Mobile_phone <- read.csv("../mobile phone EDA/Mobile-Phones.csv")
head(Mobile_phone)
Mobile_phone1 <- Mobile_phone |> 
  rename(price = price...)
view(Mobile_phone1)





#Find the most expensive phones 

Most_Expensive <- Mobile_phone1 |>
  select (os,  brand,model, price, resolution, battery.mAh. ) |>
  group_by(price) |> 
  arrange(desc(price)) |> 
  head(10)
Most_Expensive
 



# Renaming IOS to iOS and Windows to Windows Phone.
Mobile_phone1$os <- ifelse(Mobile_phone1$os == "IOS", "iOS", 
         ifelse(Mobile_phone1$os == "Windows", "Windows Mobile",
                ifelse(Mobile_phone1$os == "", "Unknown", Mobile_phone1$os)))

#Checking  
ggplot(Mobile_phone1, aes(x = os, y = price)) + geom_point(aes(color = os))

# Renaming all empty rows in the data set to Unknown.
Mobile_phone1 <- Mobile_phone1 |>
  mutate(across(everything(), ~ifelse(.=="", "Unknown",.)))

glimpse(Mobile_phone1)

#Inserting Battery.mAh. for Galaxy Z fold 4
Mobile_phone1 <- Mobile_phone1 |>
  mutate(battery.mAh. = ifelse(model == "Galaxy Z Fold4",4400, battery.mAh. ) )

#group mobile phones by Region 
Region_data <- Mobile_phone1 |> 
  select(region, location) |> 
  group_by(region) 

Region_data

Region_data <- Mobile_phone1 |> 
  select(region, location) |> 
  group_by(region, location) |>
  count()
 Region_data
#graphics of phone by region
ggplot(Region_data, aes(x = region )) + geom_bar(aes( fill = region)) + 
  ylab("Total number of phones ")+  labs(title = "Phones by Region")

#faceting  brand by region 
ggplot(Mobile_phone1, aes( x= brand)) + geom_bar(aes(fill = brand, )) + facet_grid(~ region) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

#Highest battery capacity  phones
Mobile_phone1 |>
  select(brand, model, battery.mAh., resolution) |>
  arrange(desc(battery.mAh.)) |>
  head(5) 
 

#Phones with the lowest Battery capacity
Mobile_phone1 |>
  select(brand, model, battery.mAh., resolution ) |>
  arrange(desc(battery.mAh.)) |>
  na.omit(battery.mAh.) |>
  tail(5) 

#Average Price of the Phones 
android_avg <- Mobile_phone1 |>
  select(os,price)|>
  filter(os == 'Android') |>
   mutate( mean(price)) |>
  head(1)

iOS_avg <- Mobile_phone1 |>
  select(os,price)|>
  filter(os == 'iOS') |>
  mutate( mean(price)) |>
  head(1)

Mobile_phone1 |>
  summarise(
  average_price_android = android_avg,
  )


Mobile_phone1 |>
  summarise(
    average_price_iOS = iOS_avg
  )

   



#Share Market of various OS by color (Android going to dominate Obviously 😁) 
Mobile_phone1 |>
  select(os, color) |> 
  group_by(os, color) |>
  count() 
 

ggplot(Mobile_phone1, aes(x = os)) + geom_bar(aes(fill=color)) + 
  labs( y = "Number of phones", x = "Operating System", title = "Number of Phones by Operating System")

