# Actividades

Árboles de decisión y Naive Bayes

## Introducción

Estudie los archivos pdf:
* `actividades-ia/se-actividades/actividad01.arboles/arboles/resumen.Teorema.Bayes.pdf`
* `actividades-ia/se-actividades/actividad01.arboles/arboles/Naive.Bayes.pdf`
* `actividades-ia/se-actividades/actividad01.arboles/arboles/arbol-decision-ID3%20algoritmo.pdf`
* `actividades-ia/se-actividades/actividad01.arboles/arboles/Ejemplo.naive.bayes.jugar.pdf`

Instale el interprete del lenguaje R y aprenda sus principales características e instrucciones, apóyese en los archivos:

* 'ATIVIDADES-IA/lenguajeR/Rbasico.md' y 
* 'ATIVIDADES-IA/lenguajeR/RStudio.md'

## Actividades

Basándode en los archivos *pdf* de la carpeta './arboles' haga:

1. Estudie el archivo 'arbol-decision-id3 algoritmo.pdf'
2. Aplique el algoritmo ID3 al conjunto de datos Iris apoyandose en el archivo Excell: `naive-bayes.iris.data.xlsx`, lo datos iris los puede obtener del archivo: `iris.data.csv`, como resultado deberá obtener un archivo Excell para los datos  Iris.
3. Instale el software [weka](https://waikato.github.io/weka-wiki/downloading_weka/)
4. Pruebe el algoritmo J48(implementacion de ID3 en weka) en el software Weka
5. Pruebe el código ID3 en R
    * revise el archivo: `actividadID3.weka.md` que explica el uso de *weka*
    * pruebe el código `weka.id3.iris.r`
6. Estudie los archivos:
    * resumen.Teorema.bayes.pdf
    * Naive.Bayes.pdf
    * Ejemplo.naive.bayes.pdf
    * pruebe el código: 'naiveBayes.e1071.iris.simple.r'
    * vea como crear archivos RMD en el archivo: 'RStudio.md', puede ver un ejemplo de este tipo de archivo en: 'lenguajeR/ejemploRMd.Rmd' y el archivo que con el se produce: 'ejemploRMd.html'
    * Haga un archivo '.Rmd' explicando la aplicación de naive Bayes en R, al conjunto de datos iris
7. El archivo './naive-byes.iris.data.xls' tiene un conjunto de tablas con las formulas aplicadas para el lgoritmo naive bayes, los resultados del clasificador NB estan tabulados a partir de la celdas [t151:ac413], los datos originales de las observaciones de iris están a partir de la celda [a1:f150], realice lo siguiente:
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

1. pdf con el resultado de la aplicación de ID3 a iris
2. Reporte del punto la aplicar el agoritmo J48 a iris en weka
3. Liga al cuaderno Colab
4. Archivos rmd y html del punto 6
5. matriz del punto 7.
6. archivo rmd y html del punto 8.
7. liga al cuderno colab

