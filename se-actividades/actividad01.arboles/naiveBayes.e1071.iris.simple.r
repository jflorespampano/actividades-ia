# Naive Bayes para Iris simple
# ejecucion en R: source("naiveBayes.e1071.iris.simple.r", echo = FALSE)
# Cargar paquetes
cat("\nIniciando Naive Bayes para Iris simple...\n")
cat("\nCargando paquetes...\n")
library(e1071)    # Contiene la función naiveBayes
library(caret)    # Para evaluación del modelo
library(ggplot2)  # Para visualización

# Cargar el dataset Iris (viene incluido en R)
data(iris)
cat("\nEstructura del dataset Iris:\n")
str(iris)
# Semilla para reproducibilidad
set.seed(123)

cat("\nCreando particiones de entrenamiento y prueba:\n")
# Crear índices para división (70% entrenamiento, 30% prueba)
train_index <- createDataPartition(iris$Species, p = 0.7, list = FALSE)

# Crear conjuntos de entrenamiento y prueba
# iris[train_index, ], train_indes especifica los índices de las filas a seleccionar
# espacio vacio despues de la coma: significa todas las columnas
train_data <- iris[train_index, ]
# obtenemos todas as filas que no estan en train_index
test_data <- iris[-train_index, ]


# Verificar tamaños
cat("Dimensiones del conjunto de entrenamiento:\n")
print(dim(train_data))
cat("Dimensiones del conjunto de prueba:\n")
print(dim(test_data))

##### Entrena el modelo #####

modelo_nb <- naiveBayes(Species ~ ., data = train_data)


##### hacer predicciones #####
# Predecir con datos de prueba
predicciones <- predict(modelo_nb, test_data)
# Ver predicciones
# muestra un preview de las primeras 16 filas
cat("\nPredicciones:\n")
# print(head(predicciones))
print(predicciones)
# Comparar con valores reales
cat("Valores reales:\n")
# print(head(test_data$Species))
print(test_data$Species)

##### predecir nuevas observaciones #####
nuevos_datos <- data.frame(
  Sepal.Length = c(5.1, 6.7, 5.8),
  Sepal.Width = c(3.5, 3.0, 2.7),
  Petal.Length = c(1.4, 5.2, 4.2),
  Petal.Width = c(0.2, 2.3, 1.3)
)
cat("\nDatos nuevos:\n")
print(nuevos_datos)

# Predecir nuevas observaciones
nuevas_predicciones <- predict(modelo_nb, nuevos_datos)
cat("\nNuevas predicciones:\n")
print(nuevas_predicciones)
# También obtener probabilidades
cat("\nProbabilidades de las nuevas predicciones:\n")
probabilidades <- predict(modelo_nb, nuevos_datos, type = "raw")
print(probabilidades)
cat("\nFIN\n")
