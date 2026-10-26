library(tidyverse)

countries = read_csv("data/countries.txt")

#Siroky a dlouhy format (wider, longer) 
  #Siroky = vic sloupcu - cte lip clovek
  #Dlouhy = vic radku - cte lip PC
countries |> 
  select(country, where(is.numeric)) |> 
  pivot_longer(cols = -country,           
               names_to = "variable",
               values_to = "value") |> 
  slice_max(value, by = variable)

#Naopak 
  countries |> 
    select(maj_belief, eu_member, poverty_risk) |> 
    slice_min(poverty_risk, by = c(maj_belief, eu_member)) |> 
    pivot_wider(names_from = maj_belief, 
                values_from = poverty_risk)
  
#Spojovani dataframu
  
breedRanks = read_csv("data/breed_ranks_smol.csv") 
breedTraits = read_csv("data/breed_traits_smol.csv")   

#Spojovani data framu - join
  #left_join(), righ_join(), inner_join(), full_join()
breedLeft = left_join(breedRanks, breedTraits)

breedRight = right_join(breedRanks, breedTraits, by = "Breed")

view(breedRight)  

breedInner = inner_join(breedRanks, breedTraits, by = "Breed")
view(breedInner)  
breedFull = full_join(breedRanks, breedTraits, by = "Breed")
view(breedFull)

#Transformace dat

round(countries$life_exp)

countries |> 
  mutate(gdpPc = gdp / population,
         lifeExp = round(life_exp)) |> 
  select(country, gdpPc, lifeExp) |> 
  view()

countriesZscore = countries |> 
  mutate(lifeExpZ = scale(life_exp)) |> 
  select(country, lifeExpZ, life_exp)

view(countriesZscore)

countries |> 
  mutate(lifeExpZ = scale(life_exp),
         .by = postsoviet) |> 
  select (country, lifeExpZ, life_exp, postsoviet) |> 
  arrange(postsoviet) |> 
  view()

#Pocitani po radcich
  #rowwise() - zapne pocitani po radcich, ungroup() - vypne pocitani po radcich                 
countries |> 
  rowwise() |>  
  mutate(povertyOrDep = sum(poverty_risk, material_dep, na.rm = TRUE)) |> 
  select(country, poverty_risk, material_dep, povertyOrDep) |> 
  view()  

#Podminene transformace 

countries |> 
  mutate(lifeExpZ = as.numeric(scale(life_exp)),
         lifeExpCat = if_else(lifeExpZ > 0, true = "Above average", false = "below average")) |> 
  select (country, lifeExpZ, lifeExpCat)

x = 6
y = 8

if(x == 6 && y == 7) paste(67) else(
    paste(":(")
  )

countries |> 
  mutate(lifeExpZ = as.numeric(scale(life_exp)),
         lifeExpCat = case_when(lifeExpZ < -1 ~ "Below average", 
                                lifeExpZ < 0 ~ "Slightly below average",
                                lifeExpZ <= 1 ~ "Slightly above average", 
                                lifeExpZ > 1 ~ "Above average",
                                .default = "Unknown"
                                )) |> 
          select(country, lifeExpZ, lifeExpCat) |> 
           view()
         

