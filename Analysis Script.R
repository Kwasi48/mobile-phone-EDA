# Analysis Script for Mobile Market Data

library(tidyverse)

Mobile_phone <- read.csv("../mobile phone EDA/Mobile-Phones.csv")
head(Mobile_phone)
Mobile_phone1 <- Mobile_phone |> 
  rename(price = price...)
view(Mobile_phone1)



Mobile_phone1 |>
  select(brand, model) |> 
  filter( brand == "Samsung") |> 
  count()

#Find the phones with the most expensive OS 

Most_Expensive <- Mobile_phone1 |>
  select (os, price, brand) |>
  group_by(price) |> 
  arrange(desc(price))
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

ggplot(Region_data, aes(x = region )) + geom_bar(aes( fill = region)) + 
  ylab("Total number of phones ")+  labs(title = "Phones by Region")

#faceting  brand by region 
ggplot(Mobile_phone1, aes( x= brand)) + geom_bar(aes(fill = brand, )) + facet_grid(~ region) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
