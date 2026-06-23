library(nnet)

print("Ejemplo de red neuronal con nnet en R")
print("Dataset iris:")
print(head(iris))
# Entrenamiento simple
modelo_nnet <- nnet(
  Species ~ .,           # usar todas las variables
  data = iris, 
  size = 10,             # neuronas en capa oculta
  maxit = 1000           # iteraciones máximas
)

# Predicción
pred <- predict(modelo_nnet, iris, type = "class")

# Crear nuevo dataset
iris_con_predicciones <- cbind(iris, Predicted_Species = pred)

# Ver las primeras filas
print("Predicciones:")  
print(head(iris_con_predicciones))

# Matriz de confusión
print("Matriz de confusión:")
print(table(pred, iris$Species))
# Precisión
print("Precisión:") 
precision <- sum(diag(table(pred, iris$Species))) / nrow(iris)
print(precision)
