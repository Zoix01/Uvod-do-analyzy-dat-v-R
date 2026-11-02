
library(tidyverse)

evalRaw = read_rds("data/course_evals.rds")


#Vyzkumna otazka - genderove rozdily v kontextu vyuky 
  #Chceme zjistit jak studenti vnimaji ucitele muze a zeny, jestli se to lisi
  #Pocty muzu a zen 

#Cisteni 

evalClean = evalRaw |> 
  select(- c("semester", "lecturer", "enrolled", "total_responses", "url", "negative", "positive")) |> 
  filter(!is.na(lecturer_rating), !is.na(gender))
view(evalClean)

evalGrouped = evalClean |> 
  summarise(lecturer_rating = mean(lecturer_rating), .by = c(gender, course)) |> 
  view()
view(evalGrouped)
generalOverview = evalGrouped |> 
  summarise(lecturer_rating = mean(lecturer_rating), .by = gender) |> 
  view()
courseOverview = evalGrouped |> 
  summarise()
#To-do
#Udelat sumarizaci podle predmetu muzi vs zeny 
#Udelat porovnani kolik uci zen a muzu 
#Udelat porovnani ratingu podle titulu 
