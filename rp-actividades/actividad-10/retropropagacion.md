# retropropagación

La retropropagación (o backpropagation en inglés) es un algoritmo fundamental en el entrenamiento de redes neuronales. Su objetivo es ajustar los pesos de las conexiones entre neuronas para minimizar el error en las predicciones de la red. Funciona propagando el error desde la salida de la red hacia atrás, capa por capa, utilizando el cálculo de gradientes y la regla de la cadena del cálculo diferencial.

# ¿Cómo funciona?
Propagación hacia adelante (forward pass):

Los datos de entrada se pasan a través de la red, capa por capa, hasta obtener una salida.

En cada neurona, se aplica una combinación lineal de las entradas con los pesos, seguida de una función de activación.

# Cálculo del error:

Se compara la salida de la red con el valor esperado (etiqueta) utilizando una función de pérdida (por ejemplo, el error cuadrático medio).

Retropropagación del error (backward pass):

El error se propaga hacia atrás, desde la capa de salida hasta la capa de entrada.

En cada capa, se calcula el gradiente de la función de pérdida con respecto a los pesos de la red, utilizando la regla de la cadena.

# Actualización de los pesos:

Los pesos se ajustan en la dirección opuesta al gradiente, utilizando un método de optimización como el descenso de gradiente. Esto reduce el error en las predicciones.

Matemáticamente:
Si L es la función de pérdida, w es un peso y η es la tasa de aprendizaje, la actualización del peso se realiza como:

w    = w        - η ⋅ ∂L/∂w
nuevo  anterior
​
 
El gradiente ∂L/∂w se calcula utilizando la regla de la cadena, descomponiendo la derivada a través de las capas de la red.

Importancia:
La retropropagación permite que las redes neuronales aprendan de manera eficiente, ajustando los pesos para mejorar su rendimiento.

Es la base del entrenamiento de redes neuronales profundas (deep learning).

Limitaciones:
Puede sufrir problemas como el vanishing gradient (gradientes que se vuelven muy pequeños) o el exploding gradient (gradientes que se vuelven muy grandes).

Requiere un gran volumen de datos y poder computacional para entrenar redes complejas.

# Resumen

la retropropagación es el mecanismo que permite a las redes neuronales aprender a partir de los errores, ajustando sus parámetros para mejorar su capacidad predictiva.