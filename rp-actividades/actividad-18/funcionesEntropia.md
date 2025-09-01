## (Opcional) Implementacion manual simple de ID3

```r
# Función para calcular la entropía
calcular_entropia <- function(vector) {
  proporciones <- table(vector) / length(vector)
  -sum(proporciones * log2(proporciones + 1e-9)) # +1e-9 para evitar log(0)
}

# Función para calcular ganancia de información
calcular_ganancia <- function(data, atributo, objetivo) {
  entropia_total <- calcular_entropia(data[[objetivo]])
  
  # Calcular entropia ponderada por los valores del atributo
  valores <- unique(data[[atribivo]])
  entropia_atributo <- 0
  
  for (valor in valores) {
    subset_data <- data[data[[atributo]] == valor, ]
    peso <- nrow(subset_data) / nrow(data)
    entropia_atributo <- entropia_atributo + peso * calcular_entropia(subset_data[[objetivo]])
  }
  
  ganancia <- entropia_total - entropia_atributo
  return(ganancia)
}

# Ejemplo de uso con iris
ganancia_sepal_length <- calcular_ganancia(iris, "Sepal.Length", "Species")
ganancia_petal_length <- calcular_ganancia(iris, "Petal.Length", "Species")

cat("Ganancia para Sepal.Length:", ganancia_sepal_length, "\n")
cat("Ganancia para Petal.Length:", ganancia_petal_length, "\n")
```