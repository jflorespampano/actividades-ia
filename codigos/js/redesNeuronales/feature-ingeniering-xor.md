# Feature igeniering

## Caso de estudio - Xor

¿Se puede usar el perceptrón para clasificar las salidas del XOR?

Gráfica de las salidas de XOR
```mermaid
flowchart TD
    subgraph "Matriz XOR (X1 horizontal, X2 vertical)"
        direction LR
        C["(0,1) → 1 🟢"] --- D["(1,1) → 0 🔴"]
        A["(0,0) → 0 🔴"] --- B["(1,0) → 1 🟢"]
    end
    
    style A fill:none,stroke:none
    style B fill:none,stroke:none
    style C fill:none,stroke:none
    style D fill:none,stroke:none

```

La respuesta es `NO` por que no son linealmente separables, en la grafica anterior es imposible trazar una recta que separa los puntos verdes de los rojos, sin embargo podemos hacerlo apoyandonos del `feature ingeniering`.


La ingeniería de características (o Feature Engineering) consiste en crear nuevas variables de entrada a partir de las originales, para que un modelo lineal (como el perceptrón) pueda trazar una línea recta (o hiperplano) en este nuevo espacio dimensional y así resolver el problema.


Como sabemos el **XOR** es **No** lineal con sus datos originales que son solo 2 características: X1 y X2.

La tabla XOR con entradas (X1, X2) y (Salida (Y)) es:

|X1	|X2	|Y|
|---|---|--|
|0	|0	|0|
|0	|1	|1|
|1	|0	|1|
|1	|1	|0|

En la grafica 2D (con variables: X1, X2) que se muestra al inicio, verás que los 1 están en esquinas opuestas y los 0 en las otras dos esquinas. Ninguna línea recta puede separarlos. Un perceptrón simple falla aquí.

## Aplicar Ingeniería de Características

Para que el perceptrón (que nos da una línea recta o plano) pueda separar el XOR, vamos a elevar la dimensión de los datos. Crearemos una tercera característica (Z) para elevar la dimension del problema de 2d a 3d, probemos agregando la tercera variable como el producto de las dos originales.

La nueva característica: Z = X1 * X2

Ahora nuestros datos de entrenamiento ya no tienen 2 columnas, sino 3 columnas (X1, X2, Z):


|X1	|X2	|Z (X1·X2)	|Salida (Y)|
|---|---|-----------|----------|
|0	|0	|0	|0|
|0	|1	|0	|1|
|1	|0	|0	|1|
|1	|1	|1	|0|

![alt text](x1xx2.png)

Ahora viene la magia:
El perceptrón aprenderá pesos: W1, W2, W3 y un sesgo (W0). La fórmula será:

Salida = Paso( W0 + W1·X1 + W2·X2 + W3·Z )

El algoritmo encontrará (por ejemplo) estos pesos: W0 = 0.5, W1 = -1, W2 = -1, W3 = 2.
Si sustituyes los valores:

Para (0,0): 0.5 + 0 + 0 + 0 = 0.5 → 1 (Error, esperábamos 0. Ajustamos el sesgo a -0.5)

Probamos con sesgo = -1.5:

(0,0): -1.5 → 0 (Bien)

(0,1): -1.5 -1 = -2.5 → 0 (Error, esperábamos 1. Aumentamos W2)

Finalmente, el perceptrón aprende algo como: W0 = -0.5, W1 = 1, W2 = 1, W3 = -2.

Comprobamos:

(0,0): -0.5 → 0 (Bien)

(0,1): -0.5 + 0 + 1 + 0 = 0.5 → 1 (Bien)

(1,0): -0.5 + 1 + 0 + 0 = 0.5 → 1 (Bien)

(1,1): -0.5 + 1 + 1 - 2 = -0.5 → 0 (Bien)

¡Lo logró! En el nuevo espacio 3D, el perceptrón trazó un plano (no una línea) que separa perfectamente los puntos.

## otras funciones que podemos usar

Observa que tambien podemos usar:
```pyhton
Z=(X1 + X2) ** 2
```

![alt text](x1+x2alCuadrado.png)