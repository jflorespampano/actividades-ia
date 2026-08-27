# archivo segment-challenge.arff

## Introducción

Se tomaron un conjunto  un conjunto de 7 imágenes de paisajes al aire libre a parti de los que se obtuvieron los datos de **segment-challenge.arff** son. Para crear el conjunto de datos, estas imágenes fueron segmentadas a mano, píxel por píxel, para clasificar cada uno de ellos en una de siete categorías (como sky, foliage, brickface, etc.).

## Origen del Dataset
* Creadores: El conjunto de datos fue creado por el Vision Group de la Universidad de Massachusetts.
* Donante: Fue donado al repositorio de la UCI por Carla Brodley (también de la UMass), en noviembre de 1990.
* Procedencia: Los datos son parte del conocido UCI Machine Learning Repository, una colección de conjuntos de datos usada ampliamente en la investigación de aprendizaje automático.

## Procesamiento de las Imágenes

1. El proceso para convertir las imágenes originales en los datos del archivo .arff fue el siguiente:
2. Selección de Regiones: Se extrajeron aleatoriamente regiones de 3x3 píxeles de las 7 imágenes segmentadas.
3. Extracción de Características: Para cada una de estas pequeñas regiones, se calcularon los 18 atributos numéricos que ves en el archivo (como las medias de color, los detectores de bordes o las medidas de textura).
4. Asignación de la Clase: La clase de cada instancia (ej. sky, grass) se determinó según la clasificación que se le había dado a la mayoría de los píxeles en esa región de 3x3 durante la segmentación manual.

En resumen, el archivo no contiene las imágenes en sí, sino una representación numérica de pequeñas porciones de esas 7 fotografías de paisajes.

## Atributos

El archivo de entrenamiento (segment-test.arff) contiene exactamente los mismos 19 atributos que el archivo de prueba que tambien esta en Weka. Cada instancia representa una región de 3x3 píxeles de una imagen segmentada a mano, y se describe mediante 18 características numéricas que capturan información sobre su posición, textura y color.

### Atributos de Posición y Tamaño
Estos tres primeros atributos describen la ubicación y el tamaño de la región en la imagen.

* region-centroid-col: La columna del píxel central de la región.
* region-centroid-row: La fila del píxel central de la región.
* region-pixel-count: El número total de píxeles en la región, que siempre es 9 (3x3)

## Atributos de Textura y Bordes
Estos atributos se calculan para detectar patrones y bordes dentro de la región de 3x3 píxeles.

* short-line-density-5: Resultado de un algoritmo que cuenta cuántas líneas de longitud 5 (en cualquier orientación) y bajo contraste (menor o igual a 5) pasan a través de la región.
* short-line-density-2: Similar al anterior, pero cuenta líneas de alto contraste (mayor que 5).
* vedge-mean: Mide el contraste promedio entre píxeles adyacentes horizontalmente, funcionando como un detector de bordes verticales.
* vedge-sd: La desviación estándar de la medida anterior (vedge-mean).
* hedge-mean: Mide el contraste promedio entre píxeles adyacentes verticalmente, funcionando como un detector de bordes horizontales.
* hedge-sd: La desviación estándar de la medida anterior (hedge-mean)

## Atributos de Color
Estos atributos describen el color de la región en diferentes espacios de color.

* intensity-mean: El promedio de intensidad de la región, calculado como (R + G + B) / 3.
* rawred-mean: El promedio del valor del canal Rojo (R).
* rawblue-mean: El promedio del valor del canal Azul (B).
* rawgreen-mean: El promedio del valor del canal Verde (G).
* exred-mean: Mide el "exceso de rojo" en la región, calculado como (2R - (G + B)).
* exblue-mean: Mide el "exceso de azul" en la región, calculado como (2B - (G + R)).
* exgreen-mean: Mide el "exceso de verde" en la región, calculado como (2G - (R + B)).
* value-mean: Resultado de una transformación no lineal 3D del espacio de color RGB.
* saturation-mean: El valor de saturación de la misma transformación no lineal.
* hue-mean: El valor de tono (hue) de la misma transformación no lineal

## El Atributo de Clase
El último atributo es la clase a predecir. Es un valor nominal con 7 categorías posibles:

* brickface (Pared de ladrillos)
* sky (Cielo)
* foliage (Follaje)
* cement (Cemento)
* window (Ventana)
* path (Camino)
* grass (Césped)

Tanto el archivo de entrenamiento como el de prueba tienen estos mismos 19 atributos, lo que permite que modelos de clasificación como J48 puedan ser entrenados con uno puedan evaluarse con el otro.

## Actividad

1. aplica el algoritmo j48 en **Weka** a este archivo y visualiza el árbol, pruebalo con registros del archivo `segment-test.arff`.

En R puedes usar archivos `.arff` de la siguinte manera:
* instala y carga weka
```R
install.packages("RWeka")
library(RWeka)
```
* lee los datos del archivo
```R
datos <- read.arff("segment-challenge.arff")
```

2. Aplica el algoritmo **j48** en R con un archivo `RMD` explicando el origen y descripcion de los datos como se hace arriba en este archivo, prueba con algunos datos del archivo de prueba.

3. Prueba el siguiente código *python* para construir un árbol de desición sobre el mismo archivo de datos.

```python
import pandas as pd
from scipy.io import arff
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report

# 1. Cargar el archivo .arff
# La función loadarff devuelve los datos y los metadatos.
data, meta = arff.loadarff('segment-challenge.arff')

# 2. Convertir los datos a un DataFrame de pandas
df = pd.DataFrame(data)

# 3. Preparar los datos para el modelo
# Asumiendo que la última columna es la variable objetivo (la clase)
X = df.iloc[:, :-1]  # Todas las columnas excepto la última (características)
y = df.iloc[:, -1]   # La última columna (etiquetas)

# Nota: Las etiquetas suelen venir como bytes (ej. b'brickface').
# Las decodificamos a strings para que sean más fáciles de leer.
y = y.str.decode('utf-8')

# 4. Dividir en conjuntos de entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42
)

# 5. Crear y entrenar el árbol de decisión
clf = DecisionTreeClassifier(random_state=42)
clf.fit(X_train, y_train)

# 6. Hacer predicciones y evaluar el modelo
y_pred = clf.predict(X_test)
print(classification_report(y_test, y_pred))
```

## Entregables

1. presentación detallada en pdf donde se muestren los pasos que seguiste para visualizar el árbol en weka.
2. archivo `.rmd` y un archivo `pdf` creado a partir del archivo `.rmd`.
3. presentación detallada en pdf donde se muestren los pasos que seguiste para visualizar el árbol en python.