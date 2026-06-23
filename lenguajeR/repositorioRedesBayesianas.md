# Repositorios redes bayesianas

Varias redes bayesianas de referencia se usan comúnmente en la literatura como puntos de comparación. Están disponibles en diferentes formatos de varias fuentes, siendo la más conocida el repositorio de redes bayesianas alojado en la Universidad Hebrea de Jerusalén.

Aquí el autor reunió un conjunto de redes, para varias simulaciones, en el paquete de R bnlearn tiene las funciones: 
* read.bif(), 
* read.dsc() y 
* read.net() 

son funciones que se usan para importar redes que han sido guardadas en formatos de otros programas:

|Función	|Formato que Lee	|Asociado a Software...|
|-----------|-------------------|----------------------|
|read.bif()	|BIF (Bayesian Interchange Format)	|Un formato antiguo para el intercambio de redes.|
|read.dsc()	|DSC (Microsoft Interchange Format)	|Programas como Netica (que puede leerlo, pero no escribirlo) y GeNIe (que puede leerlo y escribirlo).|
|read.net()	|NET (HUGIN flat network format)	|Programas como HUGIN y GeNIe (ambos pueden leerlo y escribirlo).|

Ejemplo de uso:
```r
library(bnlearn)

# Lee un archivo en formato DSC y lo guarda como un objeto de R
mi_red <- read.dsc("ruta/a/mi_red.dsc")

# Ahora 'mi_red' es un objeto 'bn.fit' con el que puedes trabajar en R
print(mi_red)
```

Todas las redes discretas están disponibles en los formatos BIF, DSC y NET y han sido revisadas y corregidas según era necesario (es decir, todas las distribuciones de probabilidad condicional suman uno, no hay nodos ficticios con un solo nivel, no hay dependencias colgantes en nodos inexistentes, etc.). 

Los objetos de R con los bn.fit para todas las redes se proporcionan tanto en archivos RDA como RDS. Los archivos RDA se pueden cargar, por ejemplo, con load("asia.rda"), lo que crea un objeto llamado bn en el ámbito actual. Los archivos RDS se pueden cargar, por ejemplo, con asia = readRDS("asia.rda"), lo que devuelve la red y la asigna.

En resumen, estas funciones son una puerta de entrada para trabajar en R con redes bayesianas creadas en otros entornos, facilitando enormemente el intercambio y la reutilización de modelos.

[repositorio de redes bayesianas](https://www.bnlearn.com/bnrepository/)