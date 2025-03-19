## Actividad tarea: 

- instale SciLab/Octave, VsCode, opcionlmente (Copilot de Microsoft)

## Instroducción aprendizaje automático

- Aprendizaje automático(machine learning), es una rama de la inteligencia artificial que se enfoca en el desarrollo de algoritmos que permiten a las computadoras aprender y mejorar a partir de la experiencia sin ser explícitamente programadas.En esencia, las máquinas analizan grandes cantidades de datos para encontrar patrones y hacer predicciones. Aquí hay algunas técnicas clave de aprendizaje automático:

1. **Aprendizaje supervisado**: La máquina se entrena con un conjunto de datos etiquetados. Por ejemplo, un modelo puede aprender a reconocer correos electrónicos de spam a partir de ejemplos etiquetados como "spam" o "no spam".
2. **Aprendizaje no supervisado**: Aquí, la máquina trabaja con datos no etiquetados y trata de encontrar estructuras ocultas. Un ejemplo es el análisis de agrupamiento, donde se agrupan datos similares sin saber de antemano las categorías.
3. **Aprendizaje por refuerzo**: La máquina aprende a través de la interacción con su entorno, recibiendo recompensas o castigos en función de sus acciones. Este enfoque es común en robótica y en el desarrollo de videojuegos.
4. **Aprendizaje semisupervisado**: Combina una pequeña cantidad de datos etiquetados con una gran cantidad de datos no etiquetados. Esto es útil cuando el etiquetado de datos es costoso o difícil.
El aprendizaje automático tiene aplicaciones en una amplia gama de áreas, como el reconocimiento de voz, la traducción automática, la detección de fraudes, la personalización de recomendaciones, entre otros.

## Máquina de aprendizaje
- ![Máquina de aprendizaje](ma.jpg)

- Durante la etapa de aprendizaje, una máquina de aprendizaje (MA) observa las parejas de entrenamiento o ejemplos etiquetados (x, y) {donde x es el vector de caracteristicas y y es la etiqueta}: 

- En la etapa de aprendizaje o entrenamiento, las caracteríticas x se alimentan al supercisor S y a la máquina de aprendizaje MA, comparando las repuestas dadas por S (y = la correcta) y la dada por MA (y' ), 

- si existen discrepancias entre y y y' , es decir si (y-y') es diferente de 0 se hacen ajustes en MA y se sigue el entrenamiento hasta que (y-y' =0 o un valor lo suficientemente pequeño) en cuyo caso decimos que la MA ya esta entrenada.

- Después del entrenamiento la MA es capaz de, para un vector de entrada x (aunque x no haya sido parte del conjunto de datos de entrenamiento), dar una respuesta y’ (y prima) que este cerca de la respuesta y del supervisor. 

- El supervisor es como el profesor que sabe la respuesta correcta y, y MA es el alumno que a partir de la entrada x nos da la respuesta y´, y si el alumno ya aprendió corractamente y'=y o almenos la respuesta y' del alumno estará lo bastante cerca de la respuesta coprrecta y. 

- Para escoger la mejor aproximación posible a la respuesta del supervisor, se mide la discrepancia entre la respuesta del supervisor y la de la máquina ( y-y´ ), el objetivo es encontrar una función que minimice la funcion de riesgo (que es el valor esperado de la discrepancia ( y-y' )). 

## Ejemplo

- Etiqueta: es el valor que estamos prediciendo. 

Ejemplos:(el precio del dolar dentro de 2 meses, la inflación acumulada para el año 2020), el precio de una casa en un lugar dado.

- Atributo: una variable o un vector de entrada, x=(x1, x2, x3, ...,xn), con xi las características que describen la entrada.

Imagine que queremos crear un detector de spam, La etiqueta será un valor booleano: cierto o falso que nos indique si el correo que estoy revisando es spam o no. La entrada es un correo electrónico con un vector de atributos o caracteristícas, puede ser: x=(x1, x2, x3, x4), donde:

x1= dirección del remitente

x2=palabras clave en el texto

x3= presencia de la frase "un truco increible" en el correo

x4=hora en que se envió.

- **Ejemplo**: Un ejemplo es una instancia de datos en particular.

puede haber ejemplos etiquetados y no etiquetados, un ejemplo etiquetado es aquel del que ya se tiene la respuesta (etiqueta), estos ejemplos son usados para entrenamiento.

- Ejemplo etiquetado: (x, y)

- Ejemplo no etiquetado: (x,?).

## actividad.

1. Lee el archivo archivo: "practicaSeparaPuntos.pdf". 
2. Carga el archivo separa_puntos_ej1.html, modofica los valores w0 y w1 para encontrar una recta que separe los puntos azules y rojos.
3. repite el punto 2 para el archivo: separa_puntos_ej1.html