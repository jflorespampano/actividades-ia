# mtcars es un data frame, contiene datos de 32 automóviles 
# de la revista Motor Trend de 1974. Incluye 11 variables (columnas) 
# y 32 observaciones (filas).
# puede ver las características de los datos en:"
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html
# datos:
# [, 1]	mpg	Miles/(US) gallon
# [, 2]	cyl	Number of cylinders
# [, 3]	disp	Displacement (cu.in.)
# [, 4]	hp	Gross horsepower
# [, 5]	drat	Rear axle ratio
# [, 6]	wt	Weight (1000 lbs)
# [, 7]	qsec	1/4 mile time
# [, 8]	vs	Engine (0 = V-shaped, 1 = straight)
# [, 9]	am	Transmission (0 = automatic, 1 = manual)
# [,10]	gear	Number of forward gears
# [,11]	carb	Number of carburetors

# con base en los valores de mpg (millas x galon), wt (peso) 
# y disp (desplazamiento pulgadas cúbicas)
# queremos predecir si el motor es en V(0) o en línea (1)

print("Ejemplo de red neuronal con el paquete neuralnet")
print("Datos: mtcars (preinstalado en R)")
# Instalación y carga
#install.packages("neuralnet")
library(neuralnet)

# Ejemplo: Clasificación binaria

# obtener los datos me mtcars (vienen preacragados en R )
data <- mtcars

print("Primeras filas del dataset original:")
print(head(mtcars[, c("mpg", "wt", "disp", "vs")]))  # Mostrar primeras filas


# normalizar los datos
# la normalización es importante para que la red neuronal funcione bien
normalize <- function(x) {(x - min(x)) / (max(x) - min(x))}
data_normalized <- as.data.frame(lapply(data, normalize))
print("Primeras filas del dataset normalizado:")
print(head(data_normalized[, c("mpg", "wt", "disp", "vs")]))

# Entrenar red neuronal
# queremos predecir vs en funcion de mpg, wt y disp
modelo <- neuralnet(
  vs ~ mpg + wt + disp,  # fórmula
  data = data_normalized,
  hidden = c(5, 3),      # 2 capas ocultas: 5 y 3 neuronas
  linear.output = FALSE,  # para clasificación
  act.fct = "logistic",   # función de activación
  stepmax = 5000,      # máximo de pasos
  threshold = 0.001        # Umbral de convergencia
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
