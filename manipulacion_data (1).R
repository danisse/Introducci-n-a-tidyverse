
##Instalar y cargar los paquetes
library(readr)
library(tidyverse)


##Para cargar la data
netflix <- read_csv("netflix_titles.csv")      #leer archivo csv


##Tener una visión general de los datos
names(netflix)
glimpse(netflix)

netflix %>% view()

##PARTE 1: Manipular datos con DPLYR
##Sintaxis= verbo(tablero, argumentos)



#------SELECT()------------

# Seleccionar columnas según condiciones

##Seleccionar columnas por su nombre
select(netflix, title, country, duration) %>% view()

select(netflix, !(cast)) %>% view()     ##también se puede usar el - en lugar de !

select(netflix, !c(cast, director)) %>% view()

##Seleccionar columnas que inician con una letra específica
select(netflix, starts_with("c")) %>% view()

##Seleccionar columnas que finalizan con una letra específica
select(netflix, ends_with("n")) %>% view()

select(netflix, starts_with("c") | ends_with("n")) %>% view()

##Seleccionar columnas que contienen un texto específico
select(netflix, contains("on")) %>% view()
select(netflix, contains("ON")) %>% view()   #No discrimina mayúsculas y minúsculas


#------FILTER()------------

# Filtrar filas según condiciones

names(netflix)
unique(netflix$release_year)

##filtrar filas
filter(netflix, release_year==2011) %>% view()
filter(netflix, country=="Spain")  %>% view()

##filtrar filas utilizando operadores lógicos
filter(netflix, release_year>1990 & country=="Spain")  %>% view()
filter(netflix, release_year>1990 | country=="Spain")  %>% view()


#------MUTATE()------------

# Crear o modificar columnas

netflix <- mutate(netflix, antiguedad = 2021-release_year) %>% view()



#------SUMMARISE()------------

# resumir información de las columnas
summarise(
    netflix,
    prom_antig = mean(antiguedad)
)


#------COMBINACIÓN DE MULTIPLES OPERACIONES CON PIPE Y GROUP BY------------

netflix %>% 
    filter(release_year > 2015) %>% 
    group_by(type) %>% 
    summarise(
        conteo = n()
    )


