
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
  mutate(numCourse = n(), .by = course) |> 
  filter(numCourse > 1) |> 
  pivot_wider(names_from = gender, values_from = lecturer_rating) |> 
  select(-numCourse) |> 
  mutate(courseDiff = male - female) |> 
  mutate(meanCourseDiff = mean(courseDiff)) |> 
  view()

hist(courseOverview$courseDiff)

view(evalRaw)
maleFemaleHelper = evalRaw |> 
  select(c("gender")) |> 
  filter(!is.na(gender)) |> 
  count(gender) |> 
  view()
barplot(maleFemaleHelper$n)
  
#novy

evalClean2 = evalRaw |> 
  select(- c("semester", "lecturer", "url", "negative", "positive")) |> 
  filter(!is.na(lecturer_rating), !is.na(gender), !is.na(enrolled), !is.na(total_responses)) |> 
  mutate(enrolled = as.numeric(enrolled), 
         total_responses = as.numeric(total_responses),
         responseRate = total_responses / enrolled) |> 
  filter(responseRate > 0.5) |> 
  summarise(lecturer_rating = mean(lecturer_rating), .by = c(gender, course)) |> 
  mutate(numCourse = n(), .by = course) |> 
  filter(numCourse > 1) |> 
  pivot_wider(names_from = gender, values_from = lecturer_rating) |> 
  select(-numCourse) |> 
  mutate(courseDiff = male - female) |> 
  mutate(meanCourseDiff = mean(courseDiff)) |> 
  view()
hist(evalClean2$courseDiff)




#To-do
#Udelat sumarizaci podle predmetu muzi vs zeny 
#Udelat porovnani kolik uci zen a muzu 
#Udelat porovnani ratingu podle titulu 
