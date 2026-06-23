# Para algoritmos genéticos
# install.packages("GA")

# Para el dataset Iris y modelos
# install.packages("caret")
# install.packages("randomForest")

# Para visualización
# install.packages("ggplot2")

library(GA)
library(caret)
library(randomForest)

# Cargar datos
data(iris)
X <- iris[, 1:4]
y <- iris$Species

# Función de evaluación para el GA
fitness_function <- function(chromosome) {
  # chromosome: vector binario [1,0,1,1] para seleccionar características
  
  # Si no selecciona ninguna característica, retornar fitness bajo
  if (sum(chromosome) == 0) {
    return(-1000)
  }
  
  # Seleccionar características
  selected_features <- which(chromosome == 1)
  X_subset <- X[, selected_features, drop = FALSE]
  
  # Validación cruzada
  set.seed(123)
  train_control <- trainControl(method = "cv", number = 5)
  
  # Entrenar modelo
  model <- train(
    x = X_subset,
    y = y,
    method = "rf",
    trControl = train_control,
    tuneLength = 2
  )
  
  # Accuracy como fitness
  accuracy <- max(model$results$Accuracy)
  
  # Penalizar por usar muchas características
  penalty <- 0.1 * sum(chromosome) / length(chromosome)
  
  return(accuracy - penalty)
}

# Configurar algoritmo genético
ga_result <- ga(
  type = "binary",               # Tipo binario
  nBits = 4,                     # 4 características
  fitness = fitness_function,    # Función de evaluación
  popSize = 50,                  # Tamaño de población
  maxiter = 100,                 # Iteraciones máximas
  pmutation = 0.1,               # Probabilidad de mutación
  pcrossover = 0.8,              # Probabilidad de cruce
  elitism = 2,                   # Elitismo
  run = 50,                      # Parar si no mejora en 50 iteraciones
  seed = 123
)

# Resultados
summary(ga_result)
plot(ga_result)

# Mejor solución
best_solution <- ga_result@solution
selected_features <- which(best_solution[1,] == 1)
cat("Características seleccionadas:", names(X)[selected_features], "\n")