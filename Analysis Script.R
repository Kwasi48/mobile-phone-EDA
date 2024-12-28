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

Most_Expensive <- Mobile_phone |>
  select (os, price, brand) |>
  group_by(price) |> 
  arrange(desc(price))
Most_Expensive
 



# Renaming IOS to iOS and Windows to Windows Phone.
Mobile_phone1$os <- ifelse(Mobile_phone1$os == "IOS", "iOS", 
         ifelse(Mobile_phone1$os == "Windows", "Windows Mobile",
                ifelse(Mobile_phone1$os == "", "Unknown", Mobile_phone1$os)))
 
ggplot(Mobile_phone1, aes(x = os, y = price)) + geom_point(aes(color = os))
  
