# ID3

## introducción

ID3 usando la biblioteca Weka.
RWeka es un paquete de R que proporciona una interfaz para Weka (Waikato Environment for Knowledge Analysis), un software de machine learning desarrollado en la Universidad de Waikato, Nueva Zelanda.

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

## actividad

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
