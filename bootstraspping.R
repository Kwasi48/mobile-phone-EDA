#Bootstrapping and others 

three_flights <- SF |> 
  slice_sample(n = 3, replace = FALSE) |>
  select(year, month, day, dep_time) 
three_flights

three_flights |> slice_sample(n = 3, replace = TRUE)

n <- 200
orig_sample <- SF |> 
  slice_sample(n = n, replace = FALSE)

orig_sample |> 
  slice_sample(n = n, replace = TRUE) |> 
  summarise(mean_arr_delay = mean(arr_delay))
