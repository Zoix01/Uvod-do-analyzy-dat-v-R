#Nejdriv si stahni ten data set, kterej Ales posilal do mailu a uloz ho do slozky data v te slozce, kde mas Rproject na tenhle predmet

#Pracovni adresar

getwd()  # Jen ti rekne working directory

#Import a export

library(tidyverse)  #Nacte Tidyverse balicky

read_csv()
read_rds()  #read_... funkce na cteni souboru daneho formatu
countries = read_csv("data/countries.txt") # V tech uvozovkach staci dat tab a zobrazi se ti soubory v tvojem working directory
countriesRDS = read_rds("data/countries.rds")     # To jsem si udelal jen tak, pro tenhle data set je jedno, jestli to mas jako csv nebo rds.
      # jsou dalsi balicky na cteni jinych souboru, treba: balicek readxlsx - read_xlsx (wow)
write_rds()
write_csv()
write_csv(countries, "data/countriesNew.csv") # export

#Prvni pohled na dataFrame

view(countriesRDS)
head(countries, n = 3) #Ukaze prvni 3 radky datasetu
tail(countries, n = 3) #Posledni 3 radky
summary(countries) #Takovej prehled
names(countries) #Jmena sloupcu
glimpse(countries) #Takovy preview toho datasetu
ncol(countries) #Pocet sloupcu
nrow(countries) #Pocet radku 

#Prace se sloupci

select(countries, country, postsoviet)  #Vyber konkretniho sloupce, prvni argument dataset, dal ty sloupce, co chces zobrazit 
countries |> 
    select(country, postsoviet) #Jen jiny zapis pomoci pipe

select(countries, !c(country, postsoviet)) #Proste negace, vrati vsechno krome tehlech sloupcu

select(countries, country:postsoviet)  #Usek od country po postsoviet
select(countries, contains("_")) #Vybere promenny, ktery obsahuji "x"
select(countries, starts_with("c")) #Vybere promenny co zacinaji na "x"
select(countries, where(is.numeric)) #Vybere numericke promenne 

#Prejmenovavani sloupce

rename(countries, university_educated = uni_prc) #Prejmenuje uni_prc na university_educated, mne to prijde mega divny, ze se to pise takhle naopak, ale fakt je to tak

#Prace s radky + logicke operatory
  # == Is equal, != Not equal, & - AND, | - OR 
filter(countries, postsoviet == "yes" & gdp > 100000) #Asi jasny co to dela a jak hledat
countries |> 
  filter(postsoviet =="yes" & gdp > 100000)
countries |>                          
  filter(maj_belief %in% c("catholic", "nonbelief")) #Vytahne radky, ktere obsahuji neco z toho vektoru 
countries |> 
  filter(is.na(gdp)) #Vyfiltruje radky, kde je gdp NA 
countries_gdp = countries |> 
  select(gdp) |> 
  filter(!is.na(gdp)) #Vyfiltruje radky, kde gdp je  

#Rezani dataframu

slice(countries, 2) #Vezme druhy radek datasetu 
slice_head(countries, n = 3) #Stejne jako head(countries, 3)
slice_head(countries, prop = 0.67) #Vytahne prvnich 67% radku

slice_max(countries, n = 3, order_by = life_exp) #Vybere n pocet radku s nejvyssim X, takze tady 3 zeme s nejvyssi life expectancy
slice_min(countries, n = 3, order_by = life_exp) #To same ale naopak 
slice_sample(countries, n = 3) #Vezme 3 random 

#Rezani podskupin

slice_max(countries, n=3, order_by = life_exp, by = postsoviet) |> 
  select(country, postsoviet, life_exp)

#Poradi radku

arrange(countries, gdp) |> #Seradi zeme podle gdp vzestupne
  select(country, gdp) 
arrange(countries, -gdp) |> 
  select(country, gdp) #Seradi sestupne
countries |> 
  filter(!is.na(gdp)) |> 
  arrange(gdp) #Seradi zeme podle gdp, ale az potom co se zbavi zemi, u kterych gdp nezname

# Procvicovani ------------------------------------------------------------
# 1) Z datasetu countries vyberte sloupce country,
#.   eu_member a dem_index
# 2) Odfiltrujte zeme, u kterych je v promenne eu_index
#    chybejici hodnota (NA).
# 3) Prejmenujte sloupce dem_index na democracy_index
# 4) Vyberte tri zeme cleneske EU a tri neclenske zeme s
#.   nejvyssi hodnotou demokratickeho indexu
#. 5) Ulozte dataframe jako novy csv soubor s nazvem
#.    "top-democracies.csv"
countries |> 
  select(country, eu_member, dem_index)|> 
  filter(!is.na(dem_index))|> 
  rename(democracy_index = dem_index)|> 
  slice_max(n = 3, order_by = democracy_index, by = eu_member)|> 
  write_csv("data/top-democracies.csv")
  

