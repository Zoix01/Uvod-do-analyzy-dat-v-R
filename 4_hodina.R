#4. hodina Rrrrr

library(tidyverse)

countries = read_rds("data/countries.rds")

#Summarise u promennych

countries |> 
  summarise(
    avg_life_exp = mean(life_exp, na.rm = TRUE),
    sd_life_exp = sd(life_exp, na.rm = TRUE)     #Funkce pro standard deviation 
  )                                             

#splitne podle .by
countries |> 
  summarise(
    avg_life_exp = mean(life_exp, na.rm = TRUE),
    sd_life_exp = sd(life_exp, na.rm = TRUE),
    .by = postsoviet
  )  |> 
  view()
#Kdy pouzit mutate a kdy summarise
  #Mutate se pouziva ke transformaci promennych => zachova se pocet radku 
  #Summarise je opravdu jen sumarizace => vrati mensi pocet radku 

#Procvicovani
  #V datasetu countries vytvorit novou promennou christian, ktera bude mit hodnotu "Christian" pro zeme, ktere
  # v promenne maj_belief maji catholic, orthodox nebo protestantism. Ostatni zeme budou mit hodnotu "Other" 
  #Prevedte promennou uni_prc z desetinnych mist na cela procenta. 
  #Spocitejte prumerny podil uni_prc pro krestany a nekrestany 

countries |> 
  mutate(christian = if_else(maj_belief %in% c("catholic", "orthodox", "protestantism"), 
                             true = "Christian",
                             false = "other"
                             )
         ) |> 
  mutate(uni_prc = round(uni_prc * 100)) |> 
  summarise(avgVzdelani = 
            mean(uni_prc, na.rm = TRUE),
            .by = christian) |> 
  view()

#Transformace vice promennych

countries |> 
  mutate(across(.cols = where(is.numeric),      #Vyber sloupecku, ktere transformuju (muze byt vycet)
                .fns = round)                   #Vyber funkce, kterou pouziju
         ) |> 
  view()

countries |> 
  mutate(across(.cols = where(is.numeric),
                .fns = ~round(., digits = 2))) |>   #Za tecku vzdycky dosadi promennou
  view()

#Prace s faktory a grafy

countries$maj_belief = as.factor(countries$maj_belief)
  #alternativa
  #countries = countries |> 
    #mutate(maj_belief = as.factor(maj_belief))
class(countries$maj_belief)

qplot(data = countries, x = maj_belief) #Tohle se ucime, ale tahle funkce uz se nepouziva, meli bychom pouzivat ggplot()

countries$maj_belief_relevel = fct_relevel(countries$maj_belief, #fct_relevel seradi v presnem poradi 
                                           "catholic",
                                           "orthodox",
                                           "protestantism",
                                           "nonbelief",
                                           "islam")
qplot(data = countries, x = maj_belief_relevel)

countries$maj_belief_infreq = fct_infreq(countries$maj_belief)   #fct_infreq seradi podle cetnosti 
qplot(data = countries, x = maj_belief_infreq)

countries$maj_belief_rev = fct_rev(countries$maj_belief_infreq)  #fct_rev obrati poradi 
qplot(data = countries, x = maj_belief_rev)

countries$maj_belief_reorder = fct_reorder(countries$maj_belief, countries$life_exp, .na_rm = TRUE) #Seradi podle medianu life_exp
qplot(data = countries, x = maj_belief_reorder, y = life_exp)





