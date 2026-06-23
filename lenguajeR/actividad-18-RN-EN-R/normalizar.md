# normalizar

La normalización es una técnica de preprocesamiento de datos que consiste en reescalar los valores numéricos de una variable para transformarlos a una escala común, sin distorsionar las diferencias en los rangos de valores ni perder información.

Razones para la normalización

* Problema con gradiente: Los algoritmos como redes neuronales, SVM, regresión lineal usan descenso de gradiente. Si las características tienen escalas diferentes, el gradiente "avanza" a diferentes velocidades para cada característica.

* Evitar el dominio de carcaterísticas por ejemplo:

```r
# Ejemplo: sin normalizar
# 'ingresos' domina sobre 'edad' solo por tener valores más grandes
datos <- data.frame(
  ingresos = c(50000, 80000, 120000),  # Domina el modelo
  edad = c(25, 35, 45)                 # Poco influyente (en bruto)
)
```

## Normalizar

```r
normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}
```

Explicación de laa función normaalize

Crea una función llamada normalize
Aplica la normalización min-max que escala los valores al rango [0, 1]
Fórmula: (valor - mínimo) / (máximo - mínimo)

Aplicando la función a los datos:

```r
data_normalized <- as.data.frame(lapply(data, normalize))
```

¿Que hace esta función?

* lapply(data, normalize): Aplica la función normalize a cada columna del dataframe data
* as.data.frame(): Convierte el resultado de vuelta a dataframe (porque lapply devuelve una lista)

## Ejemplo práctico

```r
# Datos de ejemplo
data <- data.frame(
  mpg = c(21.0, 21.0, 22.8, 21.4, 18.7),
  wt = c(2.620, 2.875, 2.320, 3.215, 3.440)
)

# Aplicar el código
normalize <- function(x) {(x - min(x)) / (max(x) - min(x))}
data_normalized <- as.data.frame(lapply(data, normalize))

print("Original:")
print(data)
print("Normalizado:")
print(data_normalized)
```

### Resultdo

```text
Original:
   mpg    wt
1 21.0 2.620
2 21.0 2.875
3 22.8 2.320
4 21.4 3.215
5 18.7 3.440

Normalizado:
    mpg        wt
1 0.5609756 0.3928571
2 0.5609756 0.4955357
3 1.0000000 0.0000000
4 0.6585366 0.7991071
5 0.0000000 1.0000000
```