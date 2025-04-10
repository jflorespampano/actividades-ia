## script: xor.r
## red neuronal para indetificar las salidas del xor
## recuerde que las salidas del xor no son  linealmente separables
## usaremos 
# Instalar y cargar el paquete neuralnet en R (no es necesario si esta cargada)
# instalar
# install.packages("neuralnet")
# cargar
# library(neuralnet)

# Crear el conjunto de datos XOR
data <- data.frame(
  input1 = c(0, 0, 1, 1),
  input2 = c(0, 1, 0, 1),
  output = c(0, 1, 1, 0)
)

# Entrenar la red neuronal con una capa oculta de 2 neuronas
modelo <- neuralnet(output ~ input1 + input2, data, hidden = 2, err.fct = "ce", linear.output = FALSE)

# Visualizar la red neuronal
plot(modelo)

# Crear un nuevo data frame con datos de prueba
data_prueba <- data.frame(
  input1 = c(0, 0, 1, 1),
  input2 = c(0, 1, 0, 1)
)

# Hacer predicciones
predicciones <- compute(modelo, data_prueba)

# Imprimir las predicciones
print(predicciones$net.result)
