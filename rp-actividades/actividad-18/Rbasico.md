# R

R es un lenguaje de programación y entorno computacional dedicado a la estadística. R es diferente a otros lenguajes de programación, esto es porque fue creado con el único propósito de hacer estadística. Esta característica es la razón de que R sea un lenguaje de programación, que puede resultar absurdo en algunos sentidos para personas con experiencia en otros lenguajes, pero también es la razón por la que R es una herramienta muy poderosa para el trabajo en estadística, puesto que funciona de la manera que una persona especializada en esta disciplina desearía que lo hiciera.

R tiene sus orígenes en S, un lenguaje de programación creado en los Laboratorios Bell de Estados Unidos. Sí, los mismos laboratorios que inventaron el transistor, el láser, el sistema operativo Unix y algunas otras cosas más.

Para agisto 225 segun Tiobe Index R esta en el numero 14.

En R, todo es un objeto. Todos los datos y estructuras de datos son objetos. Además, todos los objetos tienen un nombre para identificarlos.


## instalación


Instala el lenguaje R desde: Página oficial de R  
[instalar](https://www.r-project.org/)
Si lo requiere, apoyese en esta guia de instalación 
[guia de instalación](https://www.icesi.edu.co/editorial/empezando-usar-web/Instal.html#sec:InstalWin)
[Rstudio](https://posit.co/download/rstudio-desktop/)

## consola


R es un  software libre y de código abierto, es una mejor opcion que scilab para redes neuronales.
Al instalar R tendra un acceso directo desde el escritorio, ejecutelo y verá la consola de R con el cursor(>).

Comandos de la consola:

```r
q() #sale de la consola
help(print) # si desea ayuda sobre un comando escriba:
getwd() # devuelve el directoriode  trabajo
setwd("C:/otro_directorio") # cambiar el directorio de trabajo
setwd("C:/trabajo/jflorespampano@gmail.com/actividades-ia/rp-actividades/actividad-18") # cambiar el directorio de trabajo
# Ver archivos
list.files()
# Ver directorios
list.dirs()
# Ejecutar scrpt desde la consola de R
source("naiveBayes.e1071.iris.simple.r", echo = FALSE)
ctr+L limpiar consola

```

## Graficar

```r
#pruebe lo siguiente
x<-seq(1:10)
y<-seq(1:10)
plot(x,y)
```
Operadores: +,-,*,/,^, %%(modulo), %/% (division entera)


```r
# pruebe lo siguiente:
x<-seq(1:10)
y<-x^2
plot(x,y)
```

**recomendación** de estilo: Deja un espacio antes y después de operadores binarios como +, -, * y /. También deja espacios antes de abrir y cerrar paréntesis, a menos que estés evaluando una función.

Los elementos en R se almacenan como objetos, si desea monitorear los objetos en su espacio de trabajo ponga:
```r
objects()
```

## sesion

Los objetos y funciones de R son almacenados en la memoria RAM de nuestra computadora.

Cuando ejecutamos R, ya sea directamente o a través de RStudio, estamos creando una instancia del entorno  de este lenguaje. cada instancia es una sesión.

Todos los objetos y funciones creadas en una sesión, permanecen sólo en ella, no son compartidos entre sesiones, sin embargo una sesión puede tener el mismo directorio de trabajo que otra sesión.

Es posible tener más de una sesión de R activa en la misma computadora.

Cuando cerramos R, también cerramos nuestra sesión. Se nos preguntará si deseamos guardar el contenido de nuestra sesión para poder volver a ella después. Esto se guarda en un archivo con extensión **.Rdata* en tu directorio de trabajo.

Para conocer los objetos y funciones que contiene nuestra sesión, usamos la función ls(), que nos devolverá una lista con los nombres de todo lo guardado en la sesión.

ls()


De manera más precisa, nuestra sesión es un entorno de trabajo y los objetos pertenecen a un entorno específico.

Los entornos son un concepto importante al hablar de lenguajes de programación, pero también son un tema que sale del alcance de este libro.

Con que recuerdes que cada sesión de R tiene su propio entorno global, eso será suficiente.

```r
# Guarda todos los objetos, funciones, datos, etc.
save.image("mi_sesion.RData")

# o en archivo->guardar area de trabajo en RGui
# ousando ctrl+s
# O usando el menú de RStudio:
# Session -> Save Workspace As...
# Para recuperar todo
load("mi_sesion.RData")

# O usando el menú de RStudio:
# Session -> Load Workspace...
```

## asignación

los comentarios enmpiezan con el caracter #

variable <- valor

```r
# crear variaable
x<-4 #crea la variable x
x #muestra la variable x
print(x) #muetra la variable x

y<-seq(1:10) #crea una sequencia numerica del 1 al 10
```

## funciones básicas

```r
x<-4
sqrt(x)
log(10)
```

## scripts

Los scripts son documentos cdigo en R, pero R los puede leer y ejecutar el código que contienen.

Aunque R permite el uso interactivo, es recomendable que guardes tu código en un archivo .R. En realidad, en proyectos complejos, es posible que sean necesarios mútiples scripts para distintos fines.

Podemos abrir y ejecutar scripts en R usando la función source(), dandole como argumento la ruta del archivo .R en nuestra computadora, entre comillas.

Por ejemplo.

source("C:/Mis scripts/mi_script.R")
Cuando usamos RStudio y abrimos un script con extensión .R, este programa nos abre un panel en el cual podemos ver su contenido. De este modo podemos ejecutar todo el código que contiene o sólo partes de él.


## tipos de datos

Tipo	           Ejemplo	    Nombre en inglés
Entero	          1	          integer
Numérico	          1.3	          numeric
Cadena de texto	“uno”	     character
Factor	           uno	          factor
Lógico	          TRUE	          logical
Perdido	          NA	          NA
Vacio	          NULL	          null

Además de estos tipos, en R también contamos con datos complejos numéricos complejos (con una parte real y una imaginaria), raw (bytes), fechas y raster, entre otros. Estos tipos tiene aplicaciones muy específicas, por ejemplo, los datos de tipo fecha son ampliamente usados en economía, para análisis de series de tiempo.

Enteros y numeericos

Los datos enteros son enteros
Los datos numéricos son numeros con parte decimal

Cadenas de texto
Estan entre comillas o entre apostrofes

Factor
Un factor es un tipo de datos específico a R. Puede ser descrito como un dato numérico representado por una etiqueta.

Supongamos que tenemos un conjunto de datos que representan el sexo de personas encuestadas por teléfono, pero estos se encuentran capturados con los números 1 y 2. El número 1 corresponde a femenino y el 2 a masculino. En R, podemos indicar que se nos muestre, en la consola y para otros análisis, los 1 como femenino y los 2 como masculino. 

Lógico
Los datos de tipo lógico sólo tienen dos valores posibles: verdadero (TRUE) y falso (FALSE).

Na y Null
En R, usamos NA para representar datos perdidos, mientras que NULL representa la ausencia de datos.

La diferencia entre las dos es que un dato NULL aparece sólo cuando R intenta recuperar un dato y no encuentra nada, mientras que NA es usado para representar explícitamente datos perdidos, omitidos o que por alguna razón son faltantes.

Por ejemplo, si tratamos de recuperar la edad de una persona encuestada que no existe, obtendríamos un NULL, pues no hay ningún dato que corresponda con ello. En cambio, si tratamos de recuperar su estado civil, y la persona encuestada no contestó esta pregunta, obtendríamos un NA.

NA además puede aparecer como resultado de una operación realizada, pero no tuvo éxito en su ejecución.

Cohercion de datos
Los datos pueden ser  transformados en diferentes tipos
La coerción de tipos se realiza de los tipos de datos más restrictivos a los más flexibles.

Las coerciones ocurren en el siguiente orden.

lógico -> entero -> numérico -> cadena de texto (logical -> integer -> numeric -> character)

Las coerciones no pueden ocurrir en orden inverso. Podemos coercionar un dato de tipo entero a uno numérico, pero uno de cadena de texto a numérico.

Coerción explícita con la familia as()
También podemos hacer coerciones explícitas usando la familia de funciones as().

Función	Tipo al que hace coerción
as.integer()	Entero
as.numeric()	Numerico
as.character()	Cadena de texto
as.factor()	Factor
as.logical()	Lógico
as.null()	NULL

Ejemplo:
convertir 5 a una cadena de tetxo:
as.character(5)

Verificar el tipo de un dato
class(dato)
tambien se puede aplicar las fncione boolenas
is.integer()	Entero
is.numeric()	Numerico
is.character()	Cadena de texto
is.factor()	Factor
is.logical()	Lógico
is.na()	NA
is.null()	NULL

ejemplo: is.numeric(5)



## operadores 

### aritmeticos

Operador	        Operación	Ejemplo	Resultado
+	Suma	        5 + 3	    8
-	Resta	        5 - 3	    2
*	Multiplicación	5 * 3	    18
/	División	    5 /3	    1.666667
^	Potencia	    5 ^ 3	    125
%%	División entera	5 %% 3	    2

### relacionales

Operador	            Comparación	Ejemplo	Resultado
<	Menor que	            5 < 3	FALSE
<=	Menor o igual que	    5 <= 3	FALSE
>	Mayor que	            5 > 3	TRUE
>=	Mayor o igual que	    5 >= 3	TRUE
==	Exactamente igual que	5 == 3	FALSE
!=	No es igual que	        5 != 3	TRUE


### logicos

Operador	Comparación	Ejemplo	            Resultado
x | y	    x Ó y es verdadero	            TRUE | FALSE	TRUE
x & y	    x Y y son verdaderos	        TRUE & FALSE	FALSE
!x	        x no es verdadero (negación)	!TRUE	        FALSE
isTRUE(x)	x es verdadero (afirmación)	    isTRUE(TRUE)	TRUE

### asignación

variable <- valor ## verificar variable = valor

### estructuras de datos en R

Dimensiones	Homogeneas	Heterogeneas
1	        Vector	    Lista
2	        Matriz	    Data frame
n	        Array

## vector

crear vector (array de una dimensión)

```r
# crear vector
ventas <- c(2, 3, 4.5, 5)
#obtener su tamaño
length(ventas)
# crear una sequencia
x <- c(1:10)
# crear una sequencia
y<-seq(from =-2, to = 10, by=2)
```

rep(x, times, each)

```r
ventas <- c(2, 3, 4.5, 5)
v2 <- rep(ventas, times=3)
```

Obtener un elemento de un arreglo:
elemento <- mi_vector[3]


## vectorizar las operaciones

```r
mi_vector <- c(2, 3, 6, 7, 8, 10, 11)
mi_vector + 2
## [1]  4  5  8  9 10 12 13
mi_vector %% 2
## [1] 0 1 0 1 0 0 1
mi_vector < 7
## [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
mi_vector == 7
## [1] FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
```

## matriz

# Tres renglones y cuatro columnas

crear una matriz:

```r
matriz <- matrix(1:9, nrow = 3, ncol = 3)
```
salida:

     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9

Ejemplo:
```r
# crear matriz
mi_matriz <- matrix(1:6, nrow = 2, ncol = 3)
# Crear un vector
mi_vector <- c(1, 2, 3, 4, 5, 6)
# Convertir el vector en una matriz de 2 filas y 3 columnas
mi_matriz <- matrix(mi_vector, nrow = 2, ncol = 3)
nrow(m) #nos da el numero de renglones(filas) de m
```

Otro procedimiento para crear matrices es la unión vectores con las siguientes funciones:

cbind() para unir vectores, usando cada uno como una columna.
rbind() para unir vectores, usando cada uno como un renglón.

Si utilizamos cbind(), entonces cada vector será una columna.
matriz <- cbind(vector_1, vector_2, vector_3, vector_4)

```r

A <- matrix(1:6, nrow = 2)  # 2x3
B <- matrix(7:12, nrow = 3) # 3x2

# Para multiplicación elemento por elemento (mismas dimensiones)
A <- matrix(1:4, nrow = 2)
B <- matrix(5:8, nrow = 2)

## Multiplicacion elemental
resultado <- A * B
print(resultado)
# Multiplicación matricial
resultado <- A %*% B
print(resultado)
```

## Listas

Lista: Una lista es una colección ordenada de objetos que pueden ser de diferentes tipos, como vectores, matrices, data frames, entre otros.
lista <- list(numeros = c(1, 2, 3), letras = c("a", "b", "c"))



## funciones en R

mi_funcion <- function(x) { return(x^2) }

## función paste

```r
# pruebe lo siguente
nombres2 <- paste(c("x","y"), rep(1:10, each=2), sep="_")
```
Salida:
 [1] "x_1"  "y_1"  "x_2"  "y_2"  "x_3"  "y_3"  "x_4"  "y_4"  "x_5"  "y_5" 
[11] "x_6"  "y_6"  "x_7"  "y_7"  "x_8"  "y_8"  "x_9"  "y_9"  "x_10" "y_10"


## comandos prncipales

## cargar datos csv

```r
data_csv2 <- read.csv2("ruta/del/archivo.csv")

#Podemos eliminar las filas que contienen datos faltantes utilizando la función na.omit()
df_sin_missing <- na.omit(df)
```

## instalar paquetes

R puede ser expandido con paquetes. Cada paquete es una colección de funciones diseñadas para atender una tarea específica. Por ejemplo, hay paquetes para trabajo visualización geoespacial, análisis psicométricos, mineria de datos, interacción con servicios de internet y muchas otras cosas más.

Estos paquetes se encuentran alojados en CRAN, así que pasan por un control riguroso antes de estar disponibles para su uso generalizado.

Podemos instalar paquetes usando la función install.packages(), dando como argumento el nombre del paquete que deseamos instalar, entre comillas.

Por ejemplo, para instalar el paquete readr, corremos lo siguiente.

install.packages("readr")

## paquete e1071:

El paquete e1071 es una herramienta robusta y versátil en el lenguaje de programación R, ofreciendo funciones para tareas de modelado estadístico y aprendizaje automático. Este paquete, desarrollado por el Departamento de Estadística de la Universidad Tecnológica de Viena, proporciona implementaciones de algoritmos conocidos como Máquinas de Vectores de Soporte (SVM), clasificadores Naive Bayes, algoritmos de agrupamiento como k-means y fuzzy c-means, así como utilidades diversas como transformadas de Fourier y ajuste de parámetros

```sh
install.packages("e1071")
```

# ejecutar scrip

desde el gui en su ventana de comandos
si debe instalar o cargar una biblioteca hagalo así:

```sh
install.packages("neuralnet")
library(neuralnet)
#para ejecutar un script:
source("C:/trabajo2025/materialDidactico/reconoc-patrones/codigos/R/xor.r")
```

Otra forma de ejecutar script es 
1. cargar el script
2. en el menu editar seleccionar **ejecutar todo**

## manejo de arraglos

```r
#Esta expresión extrae todos los valores de la columna "Species"
table(iris$Species)
```


## ligas

[ver analisis de datos basico](https://openwebinars.net/blog/introduccion-lenguaje-r/)
[refrencia](https://bookdown.org/jboscomendoza/r-principiantes4/introduccion-que-es-r-y-para-que-es-usado.html)
[configuracion basica](https://docs.kanaries.net/es/topics/R/6-r-lib-for-beginners)
