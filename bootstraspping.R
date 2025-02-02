#Bootstrapping and others 
library(tidyverse)
library(mdsr)
library(nycflights13)



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


sf_2009_bs <- 1:num_trials |> 
  map_dfr(
    ~orig_sample |> 
      slice_sample( n = n, replace = TRUE) |> 
      summarise (mean_arr_delay = mean(arr_delay))
  ) |> 
  mutate(n = n)

sf_2009_bs |> 
  skim(mean_arr_delay)

sf_200_pop <- 1:num_trials |> 
  map_dfr(
    ~SF |> 
      slice_sample(n = n, replace = TRUE) |>
      summarise(mean_arr_delay = mean(arr_delay))
  ) |> 
  mutate(n = n )
 

sf_200_pop |>                      
  skim(mean_arr_delay)


orig_sample |> 
  summarise(q98 = quantile(arr_delay, p = 0.98))

n <- nrow(orig_sample)
sf_2009_bs <- 1:num_trials |> 
  map_dfr(
    ~orig_sample |> 
      slice_sample(n = n, replace =  TRUE) |> 
      summarise(q98 = quantile(arr_delay, p = 0.98))
  )


sf_2009_bs |>
  skim(q98)
 
set.seed(1001)
n_large <- 10000
sf_10000_bs <- SF |> 
  slice_sample(n = n_large, replace = FALSE)

sf_2009_bs <- 1:num_trials |>
  map_dfr(~sf_10000_bs |>
            slice_sample(n = n_large, replace = TRUE) |>
            summarize(q98 = quantile(arr_delay, p = 0.98))
  )

sf_2009_bs |>
  skim(q98)


set.seed(1001)
n_large <- 10000
sf_10000_bs <- SF |> 
  slice_sample(n = n_large, replace = FALSE)

sf_200_bs <- 1:num_trials |>
  map_dfr(~sf_10000_bs |>
            slice_sample(n = n_large, replace = TRUE) |>
            summarize(q98 = quantile(arr_delay, p = 0.98))
  )

sf_200_bs |>
  skim(q98)


SF |> 
  filter(arr_delay >= 420) |>
  select(month, day, dep_delay, arr_delay, carrier)
