
library(tidyverse)

countries = read_rds("data/countries.rds")

#Transformace faktoru - prejmenovavani 

countries$maj_belief_recode = fct_recode(countries$maj_belief, "protestant" = "protestantism")

countries |> 
  mutate(maj_belief_recode = fct_recode(maj_belief, "protestant" = "protestantism")) |> 
  view()

#Transformace pomoci funkci 

countries$maj_belief_relabel = fct_relabel(countries$maj_belief, str_to_title)
levels(countries$maj_belief_relabel)

#Kolapsovani faktoru 

countries$maj_belief_collapse = fct_collapse(countries$maj_belief, 
                                             "Christianity" = c("catholic",
                                                                "orthodox",
                                                                "protestantism"))
levels(countries$maj_belief_collapse)
view(countries)

#Kolapsovani podle podminky

countries |> 
  mutate(maj_belief_lump = fct_lump(maj_belief, 
                             prop = 0.2, 
                             other_level = "Other"))

countries$maj_belief_lump = fct_lump(countries$maj_belief, 
                                     prop = 0.2,
                                     other_level = "Other")
view(countries)

#Prace se stringy 

countries |> 
  filter(str_detect(hd_title_name, pattern = "King")) |> 
  select(country, hd_title_name)

countries |> 
  filter(str_detect(hd_title_name, pattern = "King|Queen")) |> 
  select(country, hd_title_name)

#Separace stringu 

countries |> 
  select(hd_title_name) |> 
  separate(hd_title_name,
           into = c("title", "name"),
           sep = "-",
           extra = "merge")

#Transformace stringu

countries |> 
  select(hd_title_name) |> 
  mutate(hd_title_name = str_to_upper(hd_title_name),              #Naopak je to str_to_lower()
         hd_title_name_sentence = str_to_sentence(hd_title_name),
         hd_title_name_sentence = str_to_title(hd_title_name))  















