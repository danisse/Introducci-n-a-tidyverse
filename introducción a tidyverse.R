#                           R Weekend - Oct 2
#                     Una instroducción al tidyverse
#         Linda Cabrera Orellana y Danisse María Carrascal Polo

#install.packages("tidyverse")
library(tidyverse)

#---- readr----

#Ejemplo1
#Leyendo datos desde una url
datos <- read_csv(url("https://raw.githubusercontent.com/rafalab/dslabs/master/inst/
extdata/murders.csv"))
datos
glimpse(datos)

#Ejemplo 2
#Archivos separados por ;
res<-c("Resistencia;ConcentrMadera
101.4;1
117.4;1.5
117.1;1.5
106.2;1.5
")

resistencia <- read_csv2(res)
resistencia
#vemos que los datos no se leen correctamente. Esto pasa ya que la función 
#read_csv2() lee archivos separados por ";" y cuyo decimal_mark sea ","
#Para leer mejor este dataset específico usamos la función read_delim(), de esta
#forma tenemos más control.

resistencia <- read_delim(file = "ResistenciaPapel.csv", delim = ";",
                          locale = locale(grouping_mark = ","))
resistencia

#En caso de que nuestro archivo esté en formato .xlsx o .xls podemos apoyarnos 
#en las funciones read_excel(), read_xls() o read_xlsx del paquete readxl.

#Desde un archivo .csv
netflix <- read_csv("netflix_titles.csv")

#---- tibble ----
#Si queremos convertir un data frame en tibble:
df<-read.csv(url("https://raw.githubusercontent.com/rafalab/dslabs/master/inst/
extdata/murders.csv"))
#Puede que se tarde un poco más en cargar. Vemos que en la consola se nos muestran
#todas las observaciones del conjunto de datos, debemos subir para observar los
#nombres de las columnas y no nos dice qué tipo de datos son. Convirtiendo esto
#a tibble se solucionarian estos "problemas".

#Nos apoyamos en la función as_tibble() y podemos asignarselo a algo, o no.
as_tibble(df)

#Si queremos crear nuestro tibble linea por linea
tribble(
  ~Resis, ~ConMad,
  101.4, 1,
  117.4, 1.5,
  117.1, 1.5,
  106.2, 1.5,
)

#si nuestros datos guarden cierta relación
tibble(x = 1:5, y = 1+x, z = x ^ 2)

#---- stringr ----
#Volvamos al dataset que cargamos inicialmente y juguemos un poco con nuestros
#caracteres.

#Si necesitamos que nuestros caracteres estén todos en minúscula:
str_to_lower(datos$state)

#si queremos que estén en mayúscula:
str_to_upper(df$state)

#Para ponerlos como estaban inicialmente
str_to_title(datos$state)

#Para buscar una coincidencia específica en nuestro conjunto de datos, podemos
#usar las anclas:
#^ para buscar la coincidencia al inicio de la cadena.
#$ para buscar la coincidencia al final de la cadena.

str_view(df$region, "^N")
#En la pestaña de Viewer R me muestra cuales fueron las coincidencias encontradas

#Un ejemplo más divertido
nom <- "Danisse"
time_of_day <- "morning"
birthday <- T

str_c(
  "Good ", time_of_day, " ", nom,
  if (birthday) " and HAPPY BIRTHDAY! :)",
  "."
)

#---- forcats ----
#Pasamos nuestros datos de region a factor
datos$region <- as_factor(datos$region)

#Para asegurarnos que se cambio podemor verificar de las siguientes formas:
#Revisando el tibble:
datos

#con ayuda de la función levels() de R base
levels(datos$region)

#Ahora, gracias a que tenemos esas observaciones como factor, podemos hacer un
#conteo y asi saber un poco más de nuestro datos.

datos %>% 
  count(region)

#A partir de aquí podriamos crear graficos o metricas que pueden ser de utilidad
#más de adelante.

#---- dplyr----

##Tener una visión general de los datos
names(netflix)
glimpse(netflix)

netflix %>% view()

##PARTE 1: Manipular datos con DPLYR
##Sintaxis= verbo(tablero, argumentos)

# SELECT()
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


# FILTER()
# Filtrar filas según condiciones

names(netflix)
unique(netflix$release_year)

##filtrar filas
filter(netflix, release_year==2011) %>% view()
filter(netflix, country=="Spain")  %>% view()

##filtrar filas utilizando operadores lógicos
filter(netflix, release_year>1990 & country=="Spain")  %>% view()
filter(netflix, release_year>1990 | country=="Spain")  %>% view()


# MUTATE()
# Crear o modificar columnas

netflix <- mutate(netflix, antiguedad = 2021-release_year) %>% view()


# SUMMARISE()
# resumir información de las columnas
summarise(
  netflix,
  prom_antig = mean(antiguedad)
)

#---- tidyr -----
##PARTE 2: Manipular datos con TIDYR
# Datos relacionados con tidyr --------------------------------------------

netflix_type <- capitulos %>%
  pivot_longer(
    c(type, release_year),
    names_to = "nombre_coord",
    values_to = "valor_coord"
  )


# Volvamos al estado original
netflix_type <- netflix %>% 
  pivot_wider(
    names_from = type,
    values_from = release_year
  )
