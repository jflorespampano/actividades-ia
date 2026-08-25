# Actividades

Árboles de decisión y Naive Bayes

## Introducción

Estudie los archivos pdf (\ia\sistemasExpertos\arboles):
* `resumen.Teorema.Bayes.pdf`
* `Naive.Bayes.pdf`
* `arboles/arbol-decision-ID3algoritmo.pdf`
* `arboles/Ejemplo.naive.bayes.jugar.pdf`

## Actividades

* Instale el interprete del lenguaje R y aprenda sus principales características e instrucciones, apóyese en el archivo: `actividadInstalarR.md` en la carpeta: `ia/lenguaje-r/`

Basándode en los archivos *pdf* de la carpeta haga:

1. Estudie el archivo 'arbol-decision-id3 algoritmo.pdf'
2. Aplique el algoritmo ID3 al conjunto de datos Iris, lo datos iris los puede obtener del archivo: `iris.data.csv`, como resultado deberá obtener un archivo Excell para los datos  Iris.
3. Instale el software [weka](https://waikato.github.io/weka-wiki/downloading_weka/) apoyandose en el archivo: `arbol-decision-ID3 algoritmo.pdf` diapositiva 44.
4. Pruebe el algoritmo J48(implementacion de ID3 en weka) en el software Weka apoyandose en el los archivos:
    * `ia\sistemasExpertos\arboles\arbol-decision-ID3algoritmo.pdf` diapositivas 43 a 53 y en el archivo
    * `actividadID3.weka.md` en esta carpeta.
5. Pruebe el código ID3 en R
    * pruebe el código `weka.id3.iris.r` de esta carpeta
    * realice la actividad 1 del archivo `\actividades-ia\python\clasificarIris\actividad.md`, que muestra el algoritmo CART en python
6. Estudie los archivos:
    * `ia\sistemasExpertos\arboles\resumen.Teorema.bayes.pdf`
    * `ia\sistemasExpertos\arboles\Naive.Bayes.pdf`
    * `ia\sistemasExpertos\arboles\Ejemplo.naive.bayes.jugar.pdf`
    * pruebe el código: `naiveBayes.e1071.iris.simple.r` de esta carpeta
    * vea como crear archivos RMD en el archivo: 'RStudio.md', puede ver un ejemplo de este tipo de archivo en: 'lenguajeR/ejemploRMd.Rmd' y el archivo que con el se produce: 'ejemploRMd.html'
    * Haga un archivo '.Rmd' explicando la aplicación de naive Bayes en R, al conjunto de datos iris
7. El archivo './naive-byes.iris.data.xls' tiene un conjunto de tablas con las formulas aplicadas para el algoritmo naive bayes, los resultados del clasificador NB estan tabulados a partir de la celdas [t151:ac413], los datos originales de las observaciones de iris están a partir de la celda [a1:f150], realice lo siguiente:
    * Para evaluar el modelos: elija aleatoriamente 20 observaciones iris y pruebe el clasificador NB
    * haga una matriz de 3x3 donde los renglones de la matriz son: (setosa, virginica, versicolor) y los renglones son: (setosa, virginica, versicolor)

|               | setosa  | virginica | versicolor |
|:-------------:|:-------:|:---------:|:----------:|
| **setosa**    |    0    |   0       |      0     |
| **virginica** |    0    |   0       |      0     |
| **versicolor**|    0    |   0       |      0     |

Coloque en las filas los resultados de sus 20 observaciones contra los valores reales, incrementando el número de la matriz, por ejemplo, si su clasificador dio setosa y el valor real es versicolor, incrementara el valor de la fila setosa, columna versicolor. A esta matriz se le llama matriz de confusión.

8. Realice la actividad './actividadNBFCI.md'
9. Crea un cuaderno Colab para iris, apóyate en `/ia/colab/cuadernosColab.md`

## Entregables:

En una carpeta nueva llamada arboles dentro de la carpeta se de tu repositorio en github agrega:
1. sin resultado
2. pdf con una presentación del proceso y el resultado de la aplicación de ID3 a iris
3. sin resultado
4. presentación en pdf del punto aplicar el agoritmo J48 a iris en weka
5. presentación en pdf de estos 2 ejercicios
6. Archivos rmd y html
7. matriz de confusión
8. no lo realice
9. liga al cuaderno colab
