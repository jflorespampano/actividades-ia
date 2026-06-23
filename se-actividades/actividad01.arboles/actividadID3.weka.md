# ID3 (Iterative Dichotomiser 3)

Es uno de los algoritmos fundamentales e históricos para construir Árboles de Decisión.

## Introducción

 ID3 es el nombre del algoritmo clásico. Los árboles de decisión modernos y más potentes (como C4.5, CART o los usados en Random Forest) son evoluciones directas de ID3, pero corrigen algunas de sus limitaciones.

El Principio Fundamental del algoritmo es: Buscar el Mejor "Dividir y Vencerás"
Imagina que tienes un montón de datos (por ejemplo, características de animales) y quieres predecir una etiqueta (por ejemplo, "¿Es un mamífero?").

ID3 construye el árbol de arriba hacia abajo, pregunta por pregunta. En cada paso, mira todas las características disponibles (ej: "¿Tiene pelo?", "¿Pone huevos?", "¿Tiene plumas?") y elige la mejor característica para hacer la primera pregunta.

¿Cómo define "mejor"? Usa un concepto de la teoría de la información: la Ganancia de Información (Information Gain).

Para medir "qué buena es una pregunta", ID3 necesita medir el "desorden" actual de los datos.

1. Entropía (Entropy): Mide la impureza o incertidumbre de un conjunto de datos.
    * Baja entropía (0): Todos los datos pertenecen a la misma clase. (Ej: Solo gatos).
    * Alta entropía (1): Los datos están perfectamente mezclados. (Ej: 50% gatos, 50% perros).

2. Ganancia de Información (Information Gain): Es la reducción de entropía que conseguimos al dividir los datos según una determinada característica.
   * Ganancia = Entropía(antes) - Entropía(después de la división)

El Algoritmo Paso a Paso (Conceptual)

1. Calcular la entropía total del conjunto de datos actual.
2. Para cada característica (columna, excepto la etiqueta):
    * Calcular la entropía de cada subconjunto que se crearía al dividir por los valores de esa característica.
    * Calcular la ganancia de información para esa característica.
3. Seleccionar la característica con la mayor ganancia de información. Ese será el nodo de decisión actual.
4. Dividir el conjunto de datos en subconjuntos según los valores de la característica elegida.
5. Aplicar recursivamente los pasos 1-4 a cada subconjunto, utilizando las características restantes (sin usar la ya elegida).
6. Condiciones de parada:
    * Todos los ejemplos en un subconjunto tienen la misma clase (entropía 0). -> Se crea una hoja con esa clase.
    * No quedan características para dividir. -> Se crea una hoja con la clase mayoritaria.
    * No quedan ejemplos en un subconjunto. -> Se crea una hoja con la clase mayoritaria del nodo padre.

## Limitaciones Importantes del Algoritmo ID3

Al usar ID3(), es crucial recordar sus limitaciones, ya que es un algoritmo base y relativamente antiguo. Estas limitaciones están documentadas tanto en la implementación de WEKA como en la de R.

1. Solo atributos nominales (categóricos): No puede manejar atributos numéricos continuos (e.g., edad, temperatura, ingresos). Si tu data.frame tiene columnas numéricas, el algoritmo fallará.

2. Sin valores faltantes (missing values): No puede trabajar con datos que tengan NA. Debes limpiar o imputar esos valores antes de llamar a la función.

3. Sin poda (unpruned): El árbol que construye es muy detallado y tiende a sobreajustarse (overfitting) a los datos de entrenamiento. Esto significa que puede funcionar muy bien con los datos que usaste para entrenarlo, pero mal con datos nuevos.

## Alternativas Más Robustas en RWeka

Debido a estas limitaciones, para proyectos reales se suelen preferir algoritmos más modernos disponibles en RWeka:

* J48(): Es la implementación en WEKA del algoritmo C4.5, una evolución del ID3. Maneja atributos numéricos y valores faltantes, e incluye poda. Es la opción más directa y poderosa para clasificación.

* RandomForest(): Implementa el popular algoritmo de Random Forest, que construye muchos árboles para obtener una predicción más precisa y robusta.


## RWeka

RWeka proporciona una interfaz para Weka (Waikato Environment for Knowledge Analysis), un software de machine learning desarrollado en la Universidad de Waikato, Nueva Zelanda.Es un paquete de R que proporciona una interfaz para acceder a los clasificadores y filtros de WEKA. Esto significa que puedes construir un árbol de decisión ID3 con una sintaxis muy similar a la de otras funciones de modelado en R (como lm o rpart), pero el motor detrás es el código Java del algoritmo de WEKA.

Algoritmos principales de Weka
```r
# clasificación
# Árbol de decisión J48 (C4.5)
modelo_j48 <- J48(Species ~ ., data = iris)

# Naive Bayes
modelo_nb <- NaiveBayes(Species ~ ., data = iris)

# Random Forest
modelo_rf <- RandomForest(Species ~ ., data = iris)

# SVM
modelo_svm <- SMO(Species ~ ., data = iris)

# Regresión Logística
modelo_logistic <- Logistic(Species ~ ., data = iris)

# Regresión lineal
modelo_lm <- LinearRegression(Sepal.Length ~ ., data = iris)

# Árboles de regresión M5P
modelo_m5p <- M5P(Sepal.Length ~ ., data = iris)

# Regresión por Random Forest
modelo_rf_reg <- RandomForest(Sepal.Length ~ ., data = iris)
```

## Implementación del Algoritmo ID3 en R con RWeka.

Primero, necesitas instalar y cargar el paquete RWeka. Es importante tener Java instalado en tu sistema, ya que RWeka lo requiere para funcionar.

```R
# Instalar el paquete (solo una vez)
install.packages("RWeka")

# Cargar la librería
library(RWeka)
```

Segundo. El Clasificador ID3

Una vez cargado RWeka, puedes usar la función ID3() para crear tu modelo. Su sintaxis es muy similar a la de otras funciones de modelado en R.

```R
modelo <- ID3(formula, data)
```

* formula: Una fórmula simbólica que describe el modelo, como clase ~ atributo1 + atributo2 o clase ~ . (para usar todos los demás atributos).
* data: El data.frame que contiene los datos de entrenamiento.

## actividad

### Actividad 1 lentes de contacto

Usemos el famoso dataset "contact-lenses" (lentes de contacto), que viene incluido en RWeka, para predecir el tipo de lente recomendado según varias características del paciente

```R
# Cargar el dataset de ejemplo
data("contact-lenses", package = "RWeka")

# Ver las primeras filas para entender los datos
head(`contact-lenses`)

#   age spectacle astigmatism tear_prod_rate contact_lenses
# 1 young    myope         no       reduced         none
# 2 young    myope         no        normal         soft
# ...

# --- Construir el modelo ID3 ---
# Predecimos 'contact_lenses' usando todos los demás atributos (.)
modelo_id3 <- ID3(contact_lenses ~ ., data = `contact-lenses`)

# --- Ver el resultado ---
print(modelo_id3)

# --- Hacer predicciones ---
predicciones <- predict(modelo_id3, newdata = `contact-lenses`)

# --- Evaluar la precisión (por ejemplo) ---
matriz_confusion <- table(`contact-lenses`$contact_lenses, predicciones)
print(matriz_confusion)

# Calcular la precisión
precision <- sum(diag(matriz_confusion)) / sum(matriz_confusion)
print(paste("Precisión del modelo ID3:", precision))
```

### Ejemplo 2 Iris

En la consola de R realice

```r
# Instalar
install.packages("RWeka")
# cargar el paquete
library(RWeka)

# Cargar los datos de iris (vienen prcargados en R)
data(iris)

# Aplicar J48, la implementación del algoritmo ID3 en Weka
id3_model <- J48(Species ~ ., data = iris, control = Weka_control(U = TRUE))
# Es la implementación del algoritmo C4.5 (evolución del ID3) en el paquete RWeka
# Species es la variable objetivo (~) indica, enfuncion de todas las demas variables del dataset
# Equivalente a: Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
# U = TRUE: árbol sin podar (ID3 puro)

# Ver el árbol
print(id3_model)
summary(id3_model)

# Visualizar el árbol (usando el paquete partykit)

install.packages("partykit")
library(partykit)
windows()
plot(id3_model)

# Si ocurre: error en la linea plot: diff.default(xscale): 
#  cannot pop the top-level viewport ('grid' and 
# 'graphics' output mixed?)
# El error sucede cuando se mezclan:
# grid: Sistema gráfico moderno (usado por ggplot2, rpart.plot, etc.)
# graphics: Sistema gráfico base de R (usado por plot() base)
# para solucionarlo poner:
# windows() antes del plot

```
