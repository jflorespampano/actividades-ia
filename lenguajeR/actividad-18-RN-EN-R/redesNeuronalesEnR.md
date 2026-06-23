# Redes Neuronales en R

R ofrece varias opciones poderosas para implementar redes neuronales, desde aproximaciones simples hasta arquitecturas profundas complejas.

## Paquetes Principales para Redes Neuronales en R

### 1 neuralnet

Para Redes Feed-Forward Básicas. Ideal para: empezar y problemas tabulares simples

Ejemplo (ver archivo: ejemplo1.r):
```r
# Instalación y carga
install.packages("neuralnet")
library(neuralnet)

# Ejemplo: Clasificación binaria
data <- mtcars
normalize <- function(x) {(x - min(x)) / (max(x) - min(x))}
data_normalized <- as.data.frame(lapply(data, normalize))

# Entrenar red neuronal
modelo <- neuralnet(
  vs ~ mpg + wt + disp,  # fórmula
  data = data_normalized,
  hidden = c(5, 3),      # 2 capas ocultas: 5 y 3 neuronas
  linear.output = FALSE,  # para clasificación
  act.fct = "logistic"   # función de activación
)

# Visualizar
plot(modelo)

# Predecir
predicciones <- compute(modelo, data_normalized[, c("mpg", "wt", "disp")])

# Mostrar resultados
resultados <- data.frame(
  Real = data_normalized$vs,
  Predicho = predicciones$net.result
)
print("Resultados antes de redondear:")
print(head(resultados))  # Mostrar primeras filas

# redondear predicciones a 0 o 1
resultados[, "Predicho"] <- round(resultados[, "Predicho"], digits = 1)
print("Resultados de la predicción:")
print(head(resultados))  # Mostrar primeras filas
```

### 2 nnet 

Redes de Una Capa Oculta. Ideal para: problemas simples y rápidos.

Ejemplo (ver archivo ejemplo2.r):
```r
library(nnet)

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

```

### 3 keras + tensorflow 

Para Deep Learning. Ideal para: redes profundas y arquitecturas complejas.

Ejemplo (ver archivo ejemplo3.r):

### Instalar bibliotecas

```sh
# verifcar si ya estan instalados

# desinstalar keras si es necesaario
remove.packages("keras")

# e su defecto instalar bibliotecas de ser necsario
install.packages("tensorflow")
install.packages("keras3")
install.packages("reticulate")
install.packages("caret")


```
### Instalar ts

### Configurar pyhton

```sh
# asegurate de que TF este instalado en tu versión de python
# instalalo si es necesario
# en una ventanaa de bash instala
python -c "import tensorflow as tf"
# ahora en RGui
library(reticulate)
# Usa la función reticulate::py_config() se usa para recuperar información detallada sobre la versión de Python que el paquete reticulate está usando actualmente en su sesión de R.
reticulate::py_config()

# Replace the path below with the actual path to your python.exe
use_python("C:/Python313")

# Now load tensorflow

library(tensorflow)
```

## Probar ejemplo: ejemplo3.r


### crear virtualenv (opcional)

Crear un entorno virtual desde cero garantiza un espacio limpio. Crear el entorno: Este código creará un nuevo entorno virtual y le instalará TensorFlow:

```sh
library(reticulate)
library(tensorflow)

# Crear un nuevo entorno virtual e instalar TensorFlow
install_tensorflow(method = "virtualenv", envname = "venv-r-tensorflow")
```

```r
library(reticulate)

# Replace the path below with the actual path to your python.exe
use_python("C:/Python313")

# Now load tensorflow
library(tensorflow)

```

