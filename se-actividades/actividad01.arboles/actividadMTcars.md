# Mtcars

Es un dataset que contiene datos de rendimiento y características técnicas de 32 modelos de automóviles del año 1974. Fue extraído de una revista estadounidense llamada Motor Trend (de ahí el nombre mt), que realizaba pruebas de carretera y viene incluido en la instalación de R.

## Estructura del Dataset

* Observaciones: 32 filas (cada una es un modelo de coche)
* Variables: 11 columnas (todas numéricas)

# Descripción de las Variables

| Variable | Descripción | Tipo |
|----------|-------------|------|
| mpg | Millas por galón (consumo de combustible). Variable objetivo más común | Numérica (continuo) |
| cyl | Número de cilindros (4, 6, 8) | Numérica (discreta) |
| disp | Cilindrada del motor (pulgadas cúbicas) | Numérica (continuo) |
| hp | Caballos de fuerza (potencia del motor) | Numérica (continuo) |
| drat | Relación del eje trasero (transmisión) | Numérica (continuo) |
| wt | Peso del vehículo (miles de libras) | Numérica (continuo) |
| qsec | Tiempo en el cuarto de milla (segundos) | Numérica (continuo) |
| vs | Tipo de motor: 0 = V-shape, 1 = Straight (en línea) | Numérica (binaria) |
| am | Tipo de transmisión: 0 = Automática, 1 = Manual | Numérica (binaria) |
| gear | Número de marchas (3, 4, 5) | Numérica (discreta) |
| carb | Número de carburadores (1 a 8) | Numérica (discreta) |


El objetivo más común es predecir el consumo de combustible (mpg) en función de otras variables como el peso (wt), la potencia (hp) o el número de cilindros (cyl).

## Cargar los datos

```R
# Cargar y explorar
data(mtcars)
head(mtcars)

# Modelo de regresión: predecir mpg con peso y potencia
modelo <- lm(mpg ~ wt + hp, data = mtcars)
summary(modelo)
```

## Actividad

1. Construir un árbol de decisión para predecir el consumo de combustible de un vehiculo.

## Entregables

1. presentación detallada en pdf con el proceso de construcción y prueba de la clasificación en un archivo RMD y en pdf construido a partir del archivo .RMD.
