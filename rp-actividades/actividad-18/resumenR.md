## instalación

Instalar el lenguaje R desde: Página oficial de R  [instalar](https://www.r-project.org/)
Si lo requiere, apoyese en esta guia de instalación [guia de instalación](https://www.icesi.edu.co/editorial/empezando-usar-web/Instal.html#sec:InstalWin)

## introduccion


R es un  software libre y de código abierto, es una mejor opcion que scilab para redes neuronales.
Al instalar R tendra un acceso directo desde el escritorio, ejecutelo y verá la consola de R con el cursor(>).

Comandos de la consola:

```r
q() #sale de la consola
# crear variaable
x<-4 #crea la variable x
x #muestra la variable x
print(x) #muetra la variable x
# si desea ayuda sobre un comando escriba:
help(print)
y<-seq(1:10) #crea una sequencia numerica del 1 al 10
```

Graficar

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

## funciones básicas

```r
x<-4
sqrt(x)
log(10)
```

## operadores relacionales

<>,<=,>=,==,!=, ! (no lógico), & (y lógico), | (or lógico)

ejemplo: z != y & log(z) > 3 #devolvera true/false

## arreglos

crear vector (array de una dimensión)

```r
ventas <- c(2, 3, 4.5, 5)
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

función paste

```r
# pruebe lo siguente
nombres2 <- paste(c("x","y"), rep(1:10, each=2), sep="_")
```

```r
# crear matriz
mi_matriz <- matrix(1:6, nrow = 2, ncol = 3)
# Crear un vector
mi_vector <- c(1, 2, 3, 4, 5, 6)
# Convertir el vector en una matriz de 2 filas y 3 columnas
mi_matriz <- matrix(mi_vector, nrow = 2, ncol = 3)
nrow(m) #nos da el numero de renglones(filas) de m
```
## comandos prncipales

## instalar paquetes

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