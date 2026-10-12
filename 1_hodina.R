#Atomove vektory
  "Franta" # character vector (string)
  67 # integer
  6.7 # double
  FALSE # logicke hodnoty (boolean)
  NA # null 
#Skladane vektory
  c("Six", "Seven")
  c(TRUE, FALSE, FALSE, TRUE, FALSE)
#Faktory
  factor(
    x = c("Six", "Seven", "Eight"),
    levels = c("Six", "Seven")
    )
#Tabulky
  table(
    c("Auto", "MHD", "Auto", "Kolo")
  )
#Listy
  list(
      c("Six", "Seven"),
      FALSE,
      67,
      c(6, 7, 8)
    )
#Dataframe
  data.frame(
      c("Six", "Seven"),
      c(FALSE, TRUE),
      c(6, 7)
    )
#Pojmenovavani objektu
  x = 67
  y = "Six Seven"
  sixSeven <- FALSE #to nebudu pouzivat wtf 
  skupinka = data.frame(
      name = c("Six", "Seven", "Eight"),
      number = c(6, 7, 8),
      isTrue = c(TRUE, TRUE, FALSE),
      skibidi = c(FALSE, TRUE, TRUE)
  )
skupinka$name
skupinka [1,]
skupinka [,1]
skupinka [3,4]

#Funkce
  length(skupinka)
  length(skupinka$name)
  
  math_scores = c(67, 89, 66)
  mean(math_scores, na.rm = TRUE)
  ?mean()
  
#Retezeni funkci
 funkce =  me |> wakeUp() |> 
    wash() |> 
    eatBreakfast() |> 
    goToWork()
 
 averageScore = mean(math_scores, na.rm = TRUE) |> round()
averageScore

#Balicky
library(tidyverse)

#Procvicovani
  menHeights = c(192, 186, 172)
  womenHeights = c(168, 174, 181)
  meanMen = mean(menHeights)
  meanWomen = mean(womenHeights)
  paste(meanMen, meanWomen)
  paste(abs(meanMen - meanWomen))
    
    