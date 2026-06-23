# Cargar librerías
library(tensorflow)
library(keras3)
library(caret)
library(datasets)

# Cargar datos iris
data(iris)

# Ver la estructura de los datos
cat("Dimensiones del dataset: %d/n", dim(iris))
cat("Nombres de las columnas: %s/n", colnames(iris))
print("Primeras filas del dataset:")
head(iris)


#str(iris)
print("Resumen del dataset:")
print (summary(iris))
print("Convertir a factor la variable Species")
# Convertir la variable especie a factor numérico
# iris$Species <- as.numeric(iris$Species) - 1  # 0, 1, 2
iris$Species <- factor(iris$Species, labels = c(0,1,2))

# Dividir en características (X) y variable objetivo (y)
print("Convertir a matriz y categórizar la variable objetivo")
x <- as.matrix(iris[, 1:4])
print(head(x))

###########################
# One-hot encoding con model.matrix
# Nota: model.matrix crea una matriz de diseño, y usamos la fórmula ~ Species - 1 para no tener intercepto (es decir, tener una columna por cada nivel)
one_hot <- model.matrix(~ Species - 1, data = iris)

# Ver las primeras filas
head(one_hot)

# Si quieres convertirla en data frame y combinar con los datos originales (sin la columna Species original)
iris_oh <- cbind(iris[-5], one_hot)  # Eliminamos la columna 5 (Species) y unimos

# Ver la estructura
str(iris_oh)
# Convertir la variable objetivo a categórica (one-hot encoding)

print("Convertir a matriz la variable objetivo")
y <- as.matrix(one_hot)
print(head(y))

####################
# Dividir en entrenamiento y prueba
print("Dividir en conjunto de entrenamiento y prueba (80%-20%)")
set.seed(123)
train_index <- createDataPartition(iris$Species, p = 0.8, list = FALSE)

x_train <- x[train_index, ]
x_test <- x[-train_index, ]
y_train <- y[train_index, ]
y_test <- y[-train_index, ]

# Normalizar los datos (opcional pero recomendado)
mean <- apply(x_train, 2, mean)
std <- apply(x_train, 2, sd)
x_train <- scale(x_train, center = mean, scale = std)
x_test <- scale(x_test, center = mean, scale = std)

# Modelo más básico para empezar
print("Crear y entrenar un modelo secuencial simple")
model <- keras_model_sequential() %>%
  layer_dense(units = 10, activation = 'relu', input_shape = c(4)) %>%
  layer_dense(units = 10, activation = 'relu') %>%
  layer_dense(units = 3, activation = 'softmax')
model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam',
  metrics = 'accuracy'
)
# simple_model <- keras_model_sequential() %>%
#   layer_dense(units = 10, activation = 'relu', input_shape = c(4)) %>%
#   layer_dense(units = 3, activation = 'softmax')

# simple_model %>% compile(
#   loss = 'categorical_crossentropy',
#   optimizer = 'adam',
#   metrics = 'accuracy'
# )

history_simple <- model %>% fit(
  x_train, y_train,
  epochs = 30,
  batch_size = 5,
  validation_split = 0.2,
  verbose = 0
)

# Evaluar modelo simple
score <- model %>% evaluate(x_test, y_test, verbose = 0)

print("Evaluar el modelo en el conjunto de prueba:")
print(score)


# Hacer predicciones

# Hacer predicciones (devuelve probabilidades)
predictions <- predict(model, x_test)

# Ver la estructura de las predicciones
print("predicciones:")
str(predictions)
print(head(predictions))


# # Matriz de confusión

library(caret)

# Hacer predicciones
predictions <- predict(model, x_test)
# clases_predichas <- predictions %>% k_argmax() %>% as.numeric()
clases_predichas <- max.col(predictions) - 1
clases_reales <- max.col(y_test) - 1

# Crear factores con nombres de especies
especies <- c("setosa", "versicolor", "virginica")
factor_predicho <- factor(clases_predichas, levels = 0:2, labels = especies)
factor_real <- factor(clases_reales, levels = 0:2, labels = especies)

# Matriz de confusión detallada
matriz_detallada <- confusionMatrix(factor_predicho, factor_real)

print("MATRIZ DE CONFUSIÓN DETALLADA:")
print(matriz_detallada)

# # Mostrar solo la tabla de contingencia
# print("Tabla de contingencia:")
# print(matriz_detallada$table)

# # Métricas por clase
# print("Métricas por clase:")
# print(matriz_detallada$byClass)