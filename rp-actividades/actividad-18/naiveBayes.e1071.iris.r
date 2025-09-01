# Naive Bayes para Iris

# Cargar paquetes
library(e1071)    # Contiene la función naiveBayes
library(caret)    # Para evaluación del modelo
library(ggplot2)  # Para visualización

# Cargar el dataset Iris (viene incluido en R)
data(iris)

str(iris)
# muestra un preview de las primeras 16 filas
head(iris)
summary(iris)

sum(is.na(iris))


table(iris$Species)

pairs(iris[,1:4], col = iris$Species, pch = 16)

set.seed(123)

train_index <- createDataPartition(iris$Species, p = 0.7, list = FALSE)

# Crear conjuntos de entrenamiento y prueba
# iris[train_index, ], train_indes especifica los índices de las filas a seleccionar
# espacio vacio despues de la coma: significa todas las columnas
train_data <- iris[train_index, ]
# obtenemos todas as filas que no estan en train_index
test_data <- iris[-train_index, ]

# Verificar tamaños
dim(train_data)
dim(test_data)

##### Entrena el modelo #####
modelo_nb <- naiveBayes(Species ~ ., data = train_data)

# Ver el modelo entrenado
print(modelo_nb)

# Ver las probabilidades a priori
modelo_nb$apriori

# Ver las medias por clase
# tables es un componente del objeto modelo_nb que contiene las probabilidades condicionales
modelo_nb$tables

##### hacer predicciones #####

# Predecir con datos de prueba
predicciones <- predict(modelo_nb, test_data)

# Ver predicciones
# muestra un preview de las primeras 16 filas
head(predicciones)

# Comparar con valores reales
head(test_data$Species)

##### predecir nuevas observaciones #####

nuevos_datos <- data.frame(
  Sepal.Length = c(5.1, 6.7, 5.8),
  Sepal.Width = c(3.5, 3.0, 2.7),
  Petal.Length = c(1.4, 5.2, 4.2),
  Petal.Width = c(0.2, 2.3, 1.3)
)

# Predecir nuevas observaciones
nuevas_predicciones <- predict(modelo_nb, nuevos_datos)
print(nuevas_predicciones)

# También obtener probabilidades
probabilidades <- predict(modelo_nb, nuevos_datos, type = "raw")
print(probabilidades)
