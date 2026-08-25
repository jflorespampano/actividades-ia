# weka

Weka (que significa Waikato Environment for Knowledge Analysis) es un software libre y de código abierto muy conocido en el mundo de la minería de datos y el machine learning .
 Fue desarrollado por la Universidad de Waikato en Nueva Zelanda y está escrito en Java . Su nombre hace referencia al ave de esa misma región, que no vuela y tiene una naturaleza curiosa.

 1. El origen (ID3)
    * ID3 (Iterative Dichotomiser 3) fue creado por Ross Quinlan en 1986.
    * Fue uno de los primeros algoritmos de árboles de decisión populares.
    * Su gran limitación: solo funcionaba con atributos categóricos (discretos). No podía manejar números (atributos continuos) como el largo o ancho del pétalo en el dataset Iris.
2. La evolución (C4.5)
    * Para solucionar las carencias de ID3, el mismo Ross Quinlan creó en 1993 una versión mejorada llamada C4.5.
    * C4.5 ya podía manejar atributos numéricos (encuentra automáticamente el punto de corte, por ejemplo petalwidth <= 0.6).
3. La implementación en Weka (J48)
    * J48 es simplemente el nombre que le dio Weka a su implementación del algoritmo C4.5 de Quinlan.

## instalar

[descarga](https://waikato.github.io/weka-wiki/downloading_weka/)

Del lado derecho en tabla de contenuidos busca la version estable pára tu procesador, descarga e instala.

## ejercicio

crear un árbol de decisión para Iris

* Paso 1: Ejecuta weka

* Paso 2: Aplicar J48 a iris
1. Abrir Weka y cargar los datos: 
   1. Inicia Weka, abre el "Weka Explorer" y 
   2. ve a la pestaña "Preprocess". 
   3. Haz clic en "Open file..." y 
   4. busca el archivo iris.arff (normalmente viene en la carpeta data de la instalación de Weka c:/archivos de programa/weka-3-8-7/data).
2. Ir a la pestaña de clasificación: Ve a la pestaña "Classify". Esta es donde seleccionarás el algoritmo y realizarás la evaluación.
3. Seleccionar el algoritmo J48: Haz clic en el botón "Choose". Se desplegará un menú. Navega a "trees" y selecciona "J48".
4. Configurar la opción de prueba: En la sección "Test options" (justo debajo del botón "Choose"), selecciona un método de evaluación. La opción más fiable y estándar es la validación cruzada (Cross-validation). Lo común es usar 10 folds (pliegues). Puedes dejar el resto de opciones por defecto o probar a usar el conjunto de entrenamiento como prueba para ver la diferencia.
5. Ejecutar el algoritmo: Haz clic en el botón "Start". El proceso es casi instantáneo, y en unos segundos verás los resultados en el panel de la derecha.

Te dará lago como esto:
```text
J48 pruned tree
------------------
petalwidth <= 0.6: Iris-setosa (50.0)
petalwidth > 0.6
|   petalwidth <= 1.7
|   |   petallength <= 4.9: Iris-versicolor (48.0/1.0)
|   |   petallength > 4.9
|   |   |   petalwidth <= 1.5: Iris-virginica (3.0)
|   |   |   petalwidth > 1.5: Iris-versicolor (3.0/1.0)
|   petalwidth > 1.7: Iris-virginica (46.0/1.0)
```

Esto significa que el algoritmo clasifica las flores usando principalmente el ancho del pétalo (petalwidth) y, en algunos casos, el largo (petallength). El número entre paréntesis (X/Y) indica cuántas instancias caen en esa hoja (X) y cuántas de ellas están mal clasificadas (Y).

Resumen de la Evaluación: En la sección "Summary" verás métricas clave, como el porcentaje de acierto (Correctly Classified Instances), que para el conjunto de entrenamiento suele estar cerca del 98%. Si usaste validación cruzada, esta cifra será una estimación más realista de cómo funciona el modelo con datos nuevos.

Matriz de Confusión: En la parte inferior de los resultados, encontrarás la "Confusion Matrix" (matriz de confusión). Esta tabla muestra, para cada clase real, cuántas instancias fueron correcta o incorrectamente clasificadas. Es muy útil para ver dónde se equivoca el modelo (por ejemplo, si confunde a menudo Iris-versicolor con Iris-virginica).

El árbol de confusión da algo como esto:
```text
  a   b  c   <-- classified as
  49  1  0 |  a = Iris-setosa
  0  47  3 |  b = Iris-versicolor
  0  2  48 |  c = Iris-virginica
```

En la lista de resultados (Result list) da clic derecho y selecciona (Visualize tree)

## formato artff

```text
@RELATION iris

@ATTRIBUTE sepallength	REAL
@ATTRIBUTE sepalwidth 	REAL
@ATTRIBUTE petallength 	REAL
@ATTRIBUTE petalwidth	REAL
@ATTRIBUTE class 	{Iris-setosa,Iris-versicolor,Iris-virginica}

@DATA
5.1,3.5,1.4,0.2,Iris-setosa
4.9,3.0,1.4,0.2,Iris-setosa
4.7,3.2,1.3,0.2,Iris-setosa
4.6,3.1,1.5,0.2,Iris-setosa
5.0,3.6,1.4,0.2,Iris-setosa
...
```

## Actividad

### introducción

El archivo vote.arff es uno de los conjuntos de datos clásicos que vienen incluidos con Weka. Se trata de un conjunto de datos del mundo real muy interesante sobre el Congreso de los Estados Unidos. Registra las votaciones de 435 congresistas de EE. UU. sobre 16 temas de actualidad en la década de 1980. El objetivo principal es predecir la afiliación política de un congresista (Demócrata o Republicano) basándose en su patrón de votación.

Su estructura: Es un conjunto de datos de 435 instancias (congresistas) y 17 atributos. 16 de esos atributos son las votaciones sobre diferentes propuestas de ley, y el atributo class es la etiqueta que indica el partido al que pertenece el congresista.

Un detalle importante: Al ser datos de votaciones reales, el conjunto contiene valores faltantes, representados con un ? en el archivo, ya que no todos los congresistas votaron en todas las propuestas.

Clasificación: queremos entrenar para que aprenda a clasificar a un congresista como Demócrata o Republicano a partir de su historial de votos. Es una buena muestra para ver cómo los patrones de voto se alinean con la ideología del partido.

Queremos encontrar reglas de Asociación como: encontrar relaciones frecuentes, como: "Si un congresista vota 'sí' a la propuesta A y 'no' a la propuesta B, entonces es Republicano".

### Actividades

Aplica J48 a este conjunto de datos.

## Entregables:

* haz una presentacion donde se vea los pasos que seguiste para la ejecución de este ejercicio, en la última diapositiva pon una conclusión sobre tu exsperiencia y lo que aprendiste al usar este software para aplicar árboles de decisión.
* carga esta presentación en formato pdf en una carpeta de tu repositorio en GitHub y envia la liga al profesor cuando se te indique.

