# instalar

```sh
nmp init -y
yarn add @tensorflow/tfjs-node

# no instalar
yarn add csv-parse

```

Nota: Instalar la biblioteca csv-parse da problemas a tf

## Normalización

La normalización es una técnica de preprocesamiento que ajusta los valores de las características a una escala común, sin distorsionar las diferencias en los rangos de valores. Hay varias formas de normalizar, pero las más comunes son:

1. Normalización Min-Max (escala [0,1] o [-1,1])
2. Estandarización (restar la media y dividir por la desviación estándar, resultando en media 0 y desviación 1)
3. Escala por unidad de longitud (normalizar por la norma del vector)

## ¿Por qué normalizar?

* Convergencia más rápida en el entrenamiento
* Evita que características con escalas grandes dominen el modelo
* Mejora la estabilidad numérica