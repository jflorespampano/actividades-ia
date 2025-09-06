## Actividad

Realice la siguiente actividad para crear una red neuronal en R usando la biblioteca **neuralnet**


## paquete e1071:

El paquete e1071 es una herramienta robusta y versátil en el lenguaje de programación R, ofreciendo funciones para tareas de modelado estadístico y aprendizaje automático. Este paquete, desarrollado por el Departamento de Estadística de la Universidad Tecnológica de Viena, proporciona implementaciones de algoritmos conocidos como Máquinas de Vectores de Soporte (SVM), clasificadores Naive Bayes, algoritmos de agrupamiento como k-means y fuzzy c-means, así como utilidades diversas como transformadas de Fourier y ajuste de parámetros

```sh
install.packages("e1071")
```

# Red neuronal (ejemplo)

## Crear red neuronal

Craremos una red neuronal con el paquete neuralnet. Trabajaremos con los datos IRIS que ya vienen incorporadoe en R.

Empezaremos importando paquetes R esenciales para la manipulación de datos y la formación de modelos.

```sh
# desde la consola de R, instale los siguientes paquetes si no lo ha hecho
install.packages("tidyverse")
install.packages("neuralnet")
# usaremos la funcion mutate_if por tanto requeriremos el pkt  dplyr
install.packages("dplyr")
```

## Análisis de datos

Puede acceder a los datos escribiendo `iris` y ejecutándo en la consola de R con el siguiente comando (no lo ejecute aun):

```r
iris <- iris 
```

Antes de entrenar los datos, tenemos que convertir los tipos de columnas de caracteres en factores.
Nota: estamos utilizando el espacio de trabajo DataCamp R para ejecutar los ejemplos. 

```r
iris <- iris |> dplyr::mutate_if(is.character, as.factor)
```

Lo que acabamos de hacer es convertir el campo caracter de IRIS en un campo de tipo factor.
Un factor es básicamente un vector que contiene etiquetas categóricas (o cualitativas), y cada etiqueta se asocia con un nivel. Por ejemplo, si tienes una variable que representa el color de una fruta, las etiquetas podrían ser "rojo", "verde", "amarillo"; o tipos de vehículos ("auto", "camión", "moto"). Internamente, los factores se almacenan como enteros que representan los niveles, pero al usuario se le muestran como etiquetas categóricas.

La función **mutate_if(is.character, as.factor)** modifica la columna character y lo conviente al tipo factor.

El operador |> en R, conocido como el operador de pipe nativo, fue introducido en la versión 4.1.0 de R y se utiliza para encadenar operaciones de manera más legible y fluida. Este operador permite pasar el resultado de una operación como entrada (argumento) a otra función. Se inspira en el operador %>% del paquete magrittr, pero es parte del núcleo del lenguaje.

Como resumen de la sentencia anterior:
```r
iris <- iris |> dplyr::mutate_if(is.character, as.factor)
```
Hace:

|> (Pipe operator):

Toma el objeto a la izquierda (iris) y lo pasa como primer argumento a la función de la derecha
Equivalente a: dplyr::mutate_if(iris, is.character, as.factor)

dplyr::mutate_if():

mutate_if: Función de dplyr que aplica una transformación solo a las columnas que cumplen una condición
Primer argumento: .tidyselect - la condición que deben cumplir las columnas
Segundo argumento: .funs - la función a aplicar

is.character:
Condición: selecciona solo las columnas que son de tipo character (texto)

as.factor:
Función que convierte variables de tipo character a factor (variable categórica)

¿Qué hace exactamente?
Convierte todas las columnas de tipo character en el dataset iris a factores (variables categóricas)


Veamos ahora un resumen de IRIS ejecutando:

```r
summary(iris)
```
Hasta ahora lo que hemos hecho en obteener y formatear el conjunto de datos iris en la variable iris.

## Formar y probar la división

Establecer una semilla en R (usando la función set.seed()) significa fijar un punto de inicio para el generador de números aleatorios. Esto es muy útil cuando trabajas con funciones que implican aleatoriedad, como generar números aleatorios, particionar datos o inicializar modelos en aprendizaje automático.

¿Por qué es importante?
Al establecer una semilla, garantizas que los resultados aleatorios sean reproducibles. Es decir, si tú y otra persona ejecutan el mismo código con la misma semilla, ambos obtendrán los mismos resultados.


Estableceremos semillas para la reproducibilidad y dividiremos los datos en conjuntos de datos de entrenamiento y de prueba para el entrenamiento y la evaluación del modelo. Lo dividiremos en 80:20. 

La funcion sample(data,size) obtienen una muestra aleatoria de tamaño size.

```sh
set.seed(245)
data_rows <- floor(0.80 * nrow(iris)) # floor redondea un número hacia abajo 
# obtienemos el 80% de los indices de 1 a numero de filas de iris
train_indices <- sample(c(1:nrow(iris)), data_rows) 
train_data <- iris[train_indices,]
# la siguiente elimina de iris los indices del arreglo train_indices
test_data <- iris[-train_indices,]
```

El código anterior hace: tareas: 
1. Establece una semilla con fines de reproducibilidad. 
2. Calcula el número de filas que se utilizarán para los datos de entrenamiento multiplicando 0,80 (80%) por el número total de filas del conjunto de datos del iris. 
3. Muestrea aleatoriamente el número de índices de data_rows entre 1 y el número total de filas del conjunto de datos del iris utilizando la función sample(). 
4. Selecciona las filas correspondientes a los índices muestreados del conjunto de datos del iris y las asigna a la variable train_data. 
5. Selecciona las filas que no se seleccionaron para el entrenamiento (es decir, las filas restantes) y las asigna a la variable datos_prueba. En general, este código se utiliza para dividir el conjunto de datos del iris en conjuntos de datos de entrenamiento y de prueba con fines de aprendizaje automático.

## Entrenamiento de la red neuronal

El paquete **neuralnet** está anticuado, pero sigue siendo popular entre la comunidad R. 

La función `neuralnet` es sencilla. No nos ofrece la libertad de crear una arquitectura de modelos totalmente personalizable. 

Instalar neuralnet:

```sh
install.packages("neuralnet")
```

Cargar neural net en la sesion

```sh
library(neuralnet)
```

En nuestro caso, le proporcionamos una fórmula de aprendizaje automático y datos, al igual que GLM (modelos lineales generalizados). La fórmula consta de variables objetivo y características. 

Después, creamos dos capas ocultas, la primera capa con cuatro neuronas y la segunda con dos neuronas. 

```sh
model = neuralnet(
    Species~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width,
data=train_data,
hidden=c(4,2),
linear.output = FALSE
)
```

Este codigo hace:  Utiliza el paquete neuralnet para crear un modelo de red neuronal. La función neuralnet() recibe varios argumentos: 
- Especies~Longitud.Sepal+Anchura.Sepal+Longitud.Petal+Anchura.Petal" especifica la fórmula del modelo, donde "Especies" es la variable objetivo y "Longitud.Sepal", "Anchura.Sepal", "Longitud.Petal" y "Anchura.Petal" son las variables predictoras. 
- Datos=datos_de_entrenamiento especifica el conjunto de datos de entrenamiento. 
- hidden=c(4,2)especifica el número de capas ocultas y el número de neuronas en cada capa. En este caso, hay dos capas ocultas con cuatro y dos neuronas, respectivamente. 
-linear.output = FALSEespecifica que la salida no debe ser lineal. El objetomodelo` resultante puede utilizarse para realizar predicciones sobre nuevos datos.

Mostar el modelo:

```sh
plot(model,rep = "best")
```
Esto muestra la red garficamente.

## Evaluación de modelos

Para la matriz de confusión:

Predeciremos las categorías utilizando un conjunto de datos de prueba. 
Crear una lista de nombres de categorías.
Cree un marco de datos de predicción y sustituya las salidas numéricas por etiquetas. 
Utiliza tablas para mostrar los valores "reales" y "previstos" uno al lado del otro. 

```sh
pred <- predict(model, test_data)
labels <- c("setosa", "versicolor", "virginca")

prediction_label <- data.frame(max.col(pred)) |>     
dplyr::mutate(pred=labels[max.col.pred.]) |>
dplyr::select(2) |>
unlist()

table(test_data$Species, prediction_label)
```

El código anterior hace: 
1. La primera línea de código utiliza la función predict para realizar predicciones sobre los datos de prueba utilizando un modelo previamente entrenado. 
2. Los valores predichos se almacenan en una variable llamada "pred". 
3. La línea siguiente crea un vector de etiquetas para las tres posibles especies de flores del conjunto de datos. 
4. La tercera línea crea un marco de datos con el índice de columna del valor máximo en cada fila de la variable "pred". Para ello se utiliza la función max.col. El marco de datos resultante sólo tiene una columna. 
5. La cuarta línea utiliza la función mutate para añadir una nueva columna al marco de datos llamada "pred". Los valores de esta columna son las etiquetas correspondientes a las especies predichas, basadas en el índice del valor máximo de cada fila de la variable "pred". 
6. La quinta línea utiliza la función select para mantener sólo la columna "pred" en el marco de datos. 
7. La sexta línea utiliza la función unlist para convertir el marco de datos en un vector. 
8. Por último, la última línea crea una tabla que compara las especies reales de los datos de prueba con las especies previstas. La tabla muestra cuántas flores se clasificaron correctamente y cuántas se clasificaron erróneamente.


Obtuvimos resultados casi perfectos. Parece que nuestro modelo ha predicho erróneamente tres muestras. Podemos mejorar el resultado añadiendo más neuronas en cada capa. 

           prediction_label
            setosa versicolor virginica
  setosa          8          0        0
  versicolor      0         13        0
  virginica       0          3        6 

## ejemplo de xor

### funcion 

La función neuralnet en R tiene varios parámetros que se pueden ajustar para personalizar y controlar el entrenamiento de una red neuronal. Aquí están los parámetros principales y sus descripciones:

Parámetros Principales de neuralnet
1. formula: La fórmula que define la relación entre las variables de entrada y salida. Ejemplo: output ~ input1 + input2.
Sintaxis del Parámetro formula
La sintaxis básica es:
respuesta ~ predictor1 + predictor2 + ... + predictorN
respuesta: La variable de salida que quieres predecir.

predictor1, predictor2, ..., predictorN: Las variables de entrada que se utilizan para predecir la variable de salida.

2. data: El conjunto de datos que se utiliza para entrenar la red neuronal. Debe ser un data frame.

3. hidden: Un vector que especifica el número de neuronas en cada capa oculta. Por ejemplo, hidden = 2 crea una capa oculta con 2 neuronas. Puedes especificar múltiples capas ocultas: hidden = c(5, 3) crea una red con 5 neuronas en la primera capa oculta y 3 neuronas en la segunda capa oculta.

4. threshold: Un valor que define el umbral para la convergencia del algoritmo de entrenamiento. Por defecto, es 0.01.

5. stepmax: El número máximo de pasos permitidos para la optimización. Por defecto, es 1e+05.

6. lifesign: Controla los mensajes de salida durante el entrenamiento. Puede ser "none", "minimal" o "full".

7. lifesign.step: Un entero que define el número de pasos entre las actualizaciones de progreso si lifesign no es "none".

8. startweights: Un vector opcional de pesos iniciales para las conexiones de la red neuronal.

9. algorithm: El algoritmo de optimización que se utilizará. Puede ser "rprop+" (por defecto), "rprop-", "slr", o "backprop".

10. learningrate: La tasa de aprendizaje utilizada por el algoritmo "backprop". Por defecto, es 0.01.

11. err.fct: La función de error que se utilizará. Puede ser "sse" (suma de los errores al cuadrado) o "ce" (entropía cruzada).

12. act.fct: La función de activación para las neuronas. Por defecto, es logistic, pero también puede ser tanh.

13. linear.output: Un booleano que indica si la salida es lineal. Por defecto, es TRUE. Para problemas de clasificación, se suele establecer en FALSE.

### Ejemplo de Uso
Aquí tienes un ejemplo de cómo utilizar algunos de estos parámetros:

r
```r
# Instalar y cargar el paquete neuralnet
install.packages("neuralnet")
library(neuralnet)

# Crear un conjunto de datos de ejemplo
data <- data.frame(
  input1 = c(0, 0, 1, 1),
  input2 = c(0, 1, 0, 1),
  output = c(0, 1, 1, 0)
)

# Entrenar la red neuronal con parámetros personalizados
modelo <- neuralnet(
  output ~ input1 + input2,
  data,
  hidden = c(5, 3),
  threshold = 0.01,
  stepmax = 1e+05,
  lifesign = "minimal",
  algorithm = "rprop+",
  err.fct = "ce",
  act.fct = "logistic",
  linear.output = FALSE
)

# Visualizar la red neuronal
plot(modelo)

```

Este ejemplo crea una red neuronal con dos capas ocultas, la primera con 5 neuronas y la segunda con 3 neuronas, y utiliza la entropía cruzada como función de error.

# Ligas

[guia de R, con  guia de instalación](https://www.icesi.edu.co/editorial/empezando-usar-web/Instal.html#sec:InstalWin)
[introducción](https://bookdown.org/jboscomendoza/r-principiantes4/windows.html)
[ejemplo redes neuronales](https://www.datacamp.com/es/tutorial/neural-network-models-r)
[referencia](https://carlosfernandovg.github.io/RBookdown/dplyrmutate.html#)
[fullrefman](file:///C:/Program%20Files/R/R-4.4.3/doc/manual/fullrefman.pdf)
[factor](https://bookdown.org/jboscomendoza/r-principiantes4/factor.html)
[este ejemplo](https://www.datacamp.com/es/tutorial/neural-network-models-r)

## datos de ejemplo

[heart](https://archive.ics.uci.edu/dataset/45/heart+disease)
