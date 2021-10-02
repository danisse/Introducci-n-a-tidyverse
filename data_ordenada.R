
## Cargamos las librerías
library(tidyverse)
library(datos)


#------PIVOT_LONGER()------------

## pivot_longer(), (pivotar a lo largo) los nombres de las columnas no representan nombres de variables, 
## sino que representan los valores de una variable.
## por lo que hacemos es transformar los nombres de columnas en observaciones

tabla4a

pivot_longer(tabla4a,
             cols = c('1999', '2000'), 
             names_to = "anio", 
             values_to = "casos")



#------PIVOT_WIDER()------------

## pivot_wider() (pivotar a lo ancho) es lo opuesto de pivot_longer(). Se usa cuando una observación 
## aparece en múltiples filas. 

tabla2

pivot_wider(tabla2, names_from = tipo, values_from = cuenta)


## Como te habrás dado cuenta a partir de sus nombres, las funciones pivot_longer() y pivot_wider() 
## son complementarias. pivot_longer() genera tablas angostas y largas, pivot_wider() genera tablas 
## anchas y cortas.




#------SEPARATE()------------

## separate() desarma una columna en varias columnas, dividiendo de acuerdo a la posición de un 
## carácter separador.

tabla3

separate(tabla3, 
         tasa, 
         into = c("casos", "poblacion"))

## Por defecto, separate() dividirá una columna donde encuentre un carácter no alfanumérico 
## (esto es, un carácter que no es un número o letra). Por ejemplo, en el siguiente código, 
## separate() divide los valores de tasa donde aparece una barra (/). Si deseas usar un carácter 
## específico para separar una columna, puedes especificarlo en el argumento sep de separate(). 
## Por ejemplo, el código anterior se puede re-escribir del siguiente modo:

separate(tabla3, 
         tasa, 
         into = c("casos", "poblacion"), 
         sep = "/")

separate(tabla3,
         anio, 
         into = c("siglo", "anio"), 
         sep = 2)



#------UNITE()------------

## unite() es el inverso de separate(): combina múltiples columnas en una única columna. 
## Necesitarás esta función con mucha menos frecuencia que separate(), pero aún así es una buena 
## herramienta para tener en el bolsillo trasero.

tabla5

unite(tabla5, nueva, siglo, anio)

unite(tabla5, nueva, siglo, anio, sep="")



#------EJERCICIO------------

# Taller

# Ordena la siguiente tabla. ¿Necesitas alargarla o ensancharla? ¿Cuáles son las variables?

embarazo <- tribble(
        ~embarazo, ~hombre, ~mujer,
        "sí", NA, 10,
        "no", 20, 12
    )

#Respuesta
#Necesitamos alargarla

embarazo

pivot_longer(embarazo,
             cols = c('hombre', 'mujer'), 
             names_to = "sexo", 
             values_to = "casos")



