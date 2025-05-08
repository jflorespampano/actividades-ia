# tensorFlow

TensorFlow.js es una biblioteca web ML de código abierto que puede ejecutarse en cualquier lugar donde JavaScript pueda hacerlo. Se basa en la biblioteca TensorFlow original escrita en Python y tiene como objetivo recrear esta experiencia de desarrollador y un conjunto de API para el ecosistema de JavaScript.

El nombre de Tensorflow se deriva directamente de su marco central: Tensor. En Tensorflow, todos los cálculos involucran tensores. Un tensor es un vector o matriz de n dimensiones que representa todo tipo de datos. Todos los valores de un tensor contienen tipos de datos idénticos. La forma de los datos es la dimensionalidad de la matriz.

En Machine Learning, los modelos se alimentan con una lista de objetos llamados vectores de características. Un vector de características puede ser de cualquier tipo de datos. El vector de características suele ser la entrada principal para un tensor. Estos valores fluirán hacia un nodo de operación a través del tensor y el resultado de esta operación/cálculo creará un nuevo tensor que a su vez se utilizará en una nueva operación.

## tensores

Un tensor es la generalización de un vector o matriz en altas dimensiones. La unidad central de datos en TF son los tf.Tensor que es un conjunto de valores conformado en un arreglo de 1 o más dimensiones. Un tf.Tensor puede contener las siguientes propiedades:
•	rank define cuantas dimensiones tiene el tensor.
•	shape define el tamaño de cada dimensión de los datos.
•	dtype define el tipo de datos del tensor

```js
//Crear tensores
//crea tensor de rango 2 (matriz) desde un arreglo multidimensional
const a = tf.tensor([[1, 2], [3, 4]]);
console.log('shape:', a.shape);
a.print();

//o puede crear el tensor desde un arreglo plano y especificar el
// shape (la forma).
const shape = [2, 2];
const b = tf.tensor([1, 2, 3, 4], shape);
console.log('shape:', b.shape);
b.print();
```

Por default tf.Tensor tendrá un dtype de float32, sin embargo puede ser creado con los tipos: bool, int32, complex64 y string.Tensorflow además provee un conjunto de métodos para crear tensores aleatorios, o rellenos con valor particular o con un HTMLImageElement.

El número de elementos de un tensor es el producto de los tamaños en su Shape, A veces se requiere de múltiples formas de un tensor con el mismo tamaño, esto se logra con reshape:

```js
const a = tf.tensor([[1, 2], [3, 4]]);
console.log('a shape:', a.shape);
a.print();

const b = a.reshape([4, 1]);
console.log('b shape:', b.shape);
b.print();

```

Puede obtener los valores de un tensor usando Tensor.array() y Tensor.data()

```js
const a = tf.tensor([[1, 2], [3, 4]]);
 // Retorna un arreglo multi dimensional de valores.
 a.array().then(array => console.log(array));
 // Retorna los datos planos del tensor.
 a.data().then(data => console.log(data));
```

Provee versiones síncronas para algunas funciones que podrían causar problemas de rendimiento

```js
const a = tf.tensor([[1, 2], [3, 4]]);
// Returns the multi dimensional array of values.
console.log(a.arraySync());
// Returns the flattened data that backs the tensor.
console.log(a.dataSync());
```

## operciones con tensores

```js
const x = tf.tensor([1, 2, 3, 4]);
const y = x.square();  // equivalent to tf.square(x)
y.print();
//suma de tensores
const a = tf.tensor([1, 2, 3, 4]);
const b = tf.tensor([10, 20, 30, 40]);
const y = a.add(b);  // equivalent to tf.add(a, b)
y.print();

```

## memoria

Cuando se utiliza el backend de WebGL, la memoria del tf.Tensor se debe administrar explícitamente (no es suficiente para que un tf.Tensor salga del alcance de su memoria).
Para destruir un tensor puede usar:

```js
const a = tf.tensor([[1, 2], [3, 4]]);
a.dispose(); // Equivalent to tf.dispose(a)

```

Es muy común encadenar múltiples operaciones en una aplicación. Mantener una referencia a todas las variables intermedias para eliminarlas puede reducir la legibilidad del código. Para resolver este problema, TensorFlow.js proporciona un método tf.tidy () que limpia todos los tf.Tensores que no devuelve una función después de ejecutarla, similar a la forma en que se limpian las variables locales cuando se ejecuta una función:

```js
const a = tf.tensor([[1, 2], [3, 4]]);
const y = tf.tidy(() => {
  const result = a.square().log().neg();
  return result;
});

```

En este ejemplo, el resultado de square () y log () se eliminará automáticamente. El resultado de neg () no se eliminará ya que es el valor de retorno de tf.tidy ().

## modelos y capas

En el aprendizaje automático, un modelo es una función con parámetros que el modelo debe aprender y que mapea una entrada a una salida. Los parámetros óptimos se obtienen entrenando el modelo con datos. Un modelo bien entrenado proporcionará un mapeo preciso desde la entrada a la salida deseada.
En TensorFlow.js hay dos formas de crear un modelo de aprendizaje automático:

•	usando la API de capas donde construyes un modelo usando capas.
•	utilizando la API Core con operaciones de nivel inferior como tf.matMul (), tf.add (), etc.
Primero, veremos la API de capas, que es una API de nivel superior para construir modelos. Luego, le mostraremos cómo construir el mismo modelo usando la API Core.

## mdelos con capas

El modelo más común es el secuencial que consta de una pila de capas donde las entradas fluyen directamente a las salidas, puedes crear un modelo secuencial, pasando una lista de capas a la función secuencial.

```js
const model = tf.sequential({
 layers: [
   tf.layers.dense({inputShape: [784], units: 32, activation: 'relu'}),
   tf.layers.dense({units: 10, activation: 'softmax'}),
 ]
});
```

O usando el método add()

```js
const model = tf.sequential();
model.add(tf.layers.dense({inputShape: [784], units: 32, activation: 'relu'}));
model.add(tf.layers.dense({units: 10, activation: 'softmax'}));

```

**IMPORTANTE:** La primera capa en el modelo necesita una inputShape. Asegúrese de excluir el tamaño del lote cuando proporcione la entrada. Por ejemplo, si planea alimentar los tensores del modelo de forma [B, 784], donde B puede tener cualquier tamaño de lote, especifique inputShape como [784] al crear el modelo.

Puede acceder a las capas del modelo a través de model.layers, y más específicamente model.inputLayers y model.outputLayers.

Aquí hay un fragmento de código que define el mismo modelo anterior utilizando la API tf.model ():

```js
// Crea un  grafico de capas, connectandolas
// via el método apply()
const input = tf.input({shape: [784]});
const dense1 = tf.layers.dense({units: 32, activation: 'relu'}).apply(input);
const dense2 = tf.layers.dense({units: 10, activation: 'softmax'}).apply(dense1);
const model = tf.model({inputs: input, outputs: dense2});

```

Llamamos a apply () en cada capa para conectarla a la salida de otra capa. El resultado de apply () en este caso es un sensor simbólico, que actúa como un tensor, pero sin valores concretos.
Tenga en cuenta que, a diferencia del modelo secuencial, creamos un SymbolicTensor mediante tf.input () en lugar de proporcionar una inputShape a la primera capa.

apply () también puede obtener un Tensor concreto, si le pasas un Tensor concreto:

```js
const t = tf.tensor([-2, 1, 0, 5]);
const o = tf.layers.activation({activation: 'relu'}).apply(t);
o.print(); // [0, 1, 0, 5]

```


## entrenando modelos

Un modelo de aprendizaje automático es una función con parámetros aprendibles que mapea una entrada a un resultado deseado. Los parámetros óptimos se obtienen entrenando el modelo en datos.

El entrenamiento implica varios pasos:

•	Obteniendo un lote de datos al modelo.
•	Preguntando al modelo para hacer una predicción.
•	Comparando esa predicción con el valor "verdadero".
•	Decidir cuánto cambiar cada parámetro para que el modelo pueda hacer una mejor predicción en el futuro para ese lote.
Un modelo bien entrenado proporcionará un mapeo preciso desde la entrada hasta la salida deseada.

Vamos a definir un modelo simple de 2 capas usando la API Layer:

```js
const model = tf.sequential({
 layers: [
   tf.layers.dense({inputShape: [784], units: 32, activation: 'relu'}),
   tf.layers.dense({units: 10, activation: 'softmax'}),
 ]
});

```

Los modelos tienen parámetros (a menudo denominados pesos) que se pueden aprender mediante la capacitación en datos. Imprimamos los nombres de los pesos asociados con este modelo y sus formas:

```js
model.weights.forEach(w => {
 console.log(w.name, w.shape);
});
//se obtiene:
//> dense_Dense1/kernel [784, 32]
//> dense_Dense1/bias [32]
//> dense_Dense2/kernel [32, 10]
//> dense_Dense2/bias [10]

```

Hay 4 pesos en total, 2 por capa densa. Esto se espera ya que las capas densas representan una función que mapea el tensor de entrada x a un tensor de salida y a través de la ecuación y = Ax + b donde A (el núcleo) y b (el sesgo) son parámetros de la capa densa.

NOTA: De forma predeterminada, las capas densas incluyen un sesgo, pero puede excluirlas especificando {useBias: false} en las opciones al crear una capa densa.

model.summary () es un método útil si desea obtener una visión general de su modelo y ver el número total de parámetros:
Layer (type)	Output shape	Param #
dense_Dense1 (Dense)	[null,32]	25120
dense_Dense2 (Dense)	[null,10]	330
Total params: 25450
Trainable params: 25450
Non-trainable params: 0

Cada peso en el modelo está respaldado por un objeto Variable. En TensorFlow.js, una variable es un tensor de punto flotante con un método adicional assign () utilizado para actualizar sus valores. La API de capas inicializa automáticamente los pesos utilizando las mejores prácticas. En aras de la demostración, podríamos sobrescribir los pesos al llamar a asignar() en las variables subyacentes:

```js
model.weights.forEach(w => {
  const newVals = tf.randomNormal(w.shape);
  // w.val is an instance of tf.Variable
  w.val.assign(newVals);
});

```

## optimizador, pérdida y métrica

Antes de realizar cualquier entrenamiento, debe decidir tres cosas:
1.	Un optimizador. El trabajo del optimizador es decidir cuánto cambiar cada parámetro en el modelo, dada la predicción del modelo actual. Cuando se utiliza la API de capas, puede proporcionar un identificador de cadena de un optimizador existente (como 'sgd' o 'adam'), o una instancia de la clase de optimizador.
2.	Una función de pérdida. Un objetivo que el modelo intentará minimizar. Su objetivo es dar un número único para "qué tan equivocada" fue la predicción del modelo. La pérdida se calcula en cada lote de datos para que el modelo pueda actualizar sus ponderaciones. Al usar la API de capas, puede proporcionar un identificador de cadena de una función de pérdida existente (como 'categoricalCrossentropy'), o cualquier función que tome un valor predicho y verdadero y devuelva una pérdida. Vea una lista de pérdidas disponibles en nuestros documentos API.
3.	Lista de métricas. Al igual que en las pérdidas, las métricas calculan un solo número y resumen qué tan bien está nuestro modelo. Las métricas se calculan generalmente en todos los datos al final de cada época. Como mínimo, queremos controlar que nuestra pérdida vaya disminuyendo con el tiempo. Sin embargo, a menudo queremos una métrica más amigable para el ser humano, como la precisión. Al usar la API de capas, puede proporcionar un identificador de cadena de una métrica existente (como 'precisión'), o cualquier función que tome un valor predicho y verdadero y devuelva una puntuación. Vea una lista de métricas disponibles en nuestros documentos API.
Cuando haya decidido, compile un LayersModel llamando a model.compile () con las opciones proporcionadas:

```js
model.compile({
  optimizer: 'sgd',
  loss: 'categoricalCrossentropy',
  metrics: ['accuracy']
});

```

Durante la compilación, el modelo realizará una validación para asegurarse de que las opciones que elija sean compatibles entre sí.

## Entrenamiento

Hay dos formas de entrenar un LayersModel:
•	Usar model.fit () y proporcionar los datos como un gran tensor.
•	Utilizando model.fitDataset () y proporcionando los datos a través de un objeto Dataset.

Si su conjunto de datos cabe en la memoria principal y está disponible como un solo tensor, puede entrenar un modelo llamando al método fit ():

```js
// Generate dummy data.
const data = tf.randomNormal([100, 784]);
const labels = tf.randomUniform([100, 10]);

function onBatchEnd(batch, logs) {
  console.log('Accuracy', logs.acc);
}

// Train for 5 epochs with batch size of 32.
model.fit(data, labels, {
   epochs: 5,
   batchSize: 32,
   callbacks: {onBatchEnd}
 }).then(info => {
   console.log('Final accuracy', info.history.acc);
 });

```

Debajo del capó, model.fit () puede hacer mucho por nosotros:
•	Divide los datos en un conjunto de entrenamiento y validación, y usa el conjunto de validación para medir el progreso durante el entrenamiento.
•	Baraja los datos, pero solo después de la división. Para estar seguro, debe mezclar previamente los datos antes de pasarlos a fit ().
•	Divide el tensor de datos grandes en tensores más pequeños de tamaño batchSize.
•	Llama a optimizer.minimize () mientras calcula la pérdida del modelo con respecto al lote de datos.
•	Puede notificarle sobre el inicio y el final de cada época o lote. En nuestro caso, se nos notifica al final de cada lote utilizando callbacks.onBatchEndoption. Otras opciones incluyen: onTrainBegin, onTrainEnd, onEpochBegin, onEpochEnd y onBatchBegin.
•	Se cede al hilo principal para garantizar que las tareas en cola en el bucle de eventos JS se puedan manejar de manera oportuna.
Para obtener más información, consulte la documentación de fit (). Tenga en cuenta que, si elige usar la API Core, tendrá que implementar esta lógica usted mismo.

## Prediciendo nuevos datos
Una vez que el modelo ha sido entrenado, puede llamar a model.predict () para hacer predicciones sobre datos no vistos:

```js
// Predict 3 random samples.
const prediction = model.predict(tf.randomNormal([3, 784]));
prediction.print();

```


## cargar biblioteca tensor flow

```js
<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs"></script>
```

# usar la biblioteca
```js
<script>
  const model = tf.sequential();
  model.add(tf.layers.dense({units: 1, inputShape: }));
  model.compile({loss: 'meanSquaredError', optimizer: 'sgd'});
</script>
```

## ejemplo de regresión lineal

La regresión lineal es una técnica de análisis de datos que predice el valor de datos desconocidos mediante el uso de otro valor de datos relacionado y conocido. Modela matemáticamente la variable desconocida o dependiente y la variable conocida o independiente como una ecuación lineal. Por ejemplo, supongamos que tiene datos sobre sus gastos e ingresos del año pasado. Las técnicas de regresión lineal analizan estos datos y determinan que tus gastos son la mitad de tus ingresos. Luego calculan un gasto futuro desconocido al reducir a la mitad un ingreso conocido futuro.

En esencia, una técnica de regresión lineal simple intenta trazar un gráfico lineal entre dos variables de datos, x e y. Como variable independiente, x se traza a lo largo del eje horizontal. Las variables independientes también se denominan variables explicativas o variables predictivas. La variable dependiente, y, se traza en el eje vertical. También puede hacer referencia a los valores y como variables de respuesta o variables pronosticadas.

Ejemplo:

Para los valores:
```js
let misDatos=[
    [1,1],[2,3],[3,5],[4,7]
];
```

Entrenar una red neuronal para ajusta una recta a estos valores:

```js

      // Define un modelo para regresión lineal.
      const model = tf.sequential();
      model.add(tf.layers.dense({units: 1, inputShape: [1]}));
      // Prepara el modelo para entrenamiento especificando: la perdida (loss) y la optimización(optimizer).
      model.compile({loss: 'meanSquaredError', optimizer: 'sgd'});
      // Ponemos los datos y etiquetas para entrenamiento
      const xs = tf.tensor2d([1, 2, 3, 4], [4, 1]);
      const ys = tf.tensor2d([1, 3, 5, 7], [4, 1]);
      // entrenamos el modelo usando los datos
      model.fit(xs, ys, {epochs: 100}).then(() => {
        // Usamos el modelo para hacer inferencias sobre un punto de datos que el modelo no haya visto antes:
        //aqui por ejemplo sobre el dato 3.5
        // Abra la consola en las herramientas de desarrollo del navegador para ver el resultado
        console.log("predicción para el dato 5:")
        model.predict(tf.tensor2d([3.5], [1, 1])).print();
      });
    
```
El código anterior lo puede ver en el archivo: "tf-regresionLineal-basico-html"

## Exlpicació básica del código: 

### la sentencia: const model = tf.sequential();

Esta línea de código crea un modelo secuencial de red neuronal usando TensorFlow.js. 

¿Qué es un modelo secuencial?
Definición: Un modelo secuencial es una pila lineal de capas de red neuronal donde:

a. El flujo de datos es secuencial (de una capa a la siguiente en orden)

b. Cada capa tiene exactamente un tensor de entrada y un tensor de salida

Analogía: Imagina un ensamble de filtros donde los datos pasan por cada uno en orden:

Entrada → Capa 1 → Capa 2 → ... → Capa N → Salida
Partes del código:
tf: El objeto principal de TensorFlow.js

sequential(): Método que crea un modelo secuencial


### la sentencia: model.add(tf.layers.dense({units: 1, inputShape: [1]}));

1. model.add(): Método para añadir una capa al modelo secuencial.
2. tf.layers.dense(): Crea una capa densa, donde cada neurona está conectada a todas las neuronas de la capa anterior, por defecto incluye un sesgo (bias) y función de activación lineal

Opciones de configuración:

1. units: 1: Especifica que la capa tendrá 1 neurona (output de dimensión 1)
2. inputShape: [1]: Define que la capa espera un input de forma [1] (un valor escalar)

### La sentencia: model.compile({loss: 'meanSquaredError', optimizer: 'sgd'});

Esta línea configura el modelo para el entrenamiento definiendo dos aspectos críticos:

1. Función de Pérdida (loss: 'meanSquaredError')
Qué es: La métrica que el modelo intentará minimizar durante el entrenamiento

Mean Squared Error (MSE):

Calcula el promedio de los cuadrados de las diferencias entre valores predichos y reales

Fórmula: MSE = 1/n * Σ(y_real - y_pred)^2

Usos típicos:

Problemas de regresión (predecir valores continuos)

Cuando los errores grandes deben penalizarse más que los pequeños (por el cuadrado)

2. Optimizador (optimizer: 'sgd')
Qué es: El algoritmo que ajusta los pesos de la red para minimizar la función de pérdida

Stochastic Gradient Descent (SGD):

Versión básica del descenso de gradiente

Ajusta pesos en dirección opuesta al gradiente de la pérdida

Parámetros clave (que aquí usan valores por defecto):

learningRate: Tamaño de los pasos de ajuste (por defecto: 0.01)

momentum: Para evitar oscilaciones (0 por defecto)

### la sentencia: model.fit(xs, ys, {epochs: 100}).then(() => {})

entrena el modelo con 100 epocas

## versión con graficación

El mismo entrenamiento para la red anterior agregando una mejor interfaz lo puede ver en
el archivo: "tf-regresionLineal-ok-html"

abra este archivo con su navegador, a continuación:

1. verá un gráfico con los valores de los datos de la variable misDatos
2. el código entrenara un red neuronal para predecir valores futuros
3. con el botón "Mostrar ayuda" verá una ayuda que le ayudara a entender el programa.
4. siga esas instrucciones
5. comente sus dudas con el profesor

## ejemplo red neuronal para las salidas del or


### Creamos tensores para los valores de los atributos y las etiquetas
```js
var epocas=500
// Datos de entrada (x1, x2) y salidas esperadas (OR)
const trainingData = tf.tensor2d([
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1]
]);
const outputData = tf.tensor2d([
    [0],
    [1],
    [1],
    [1]
]);
```

### creamos el modelo y lo entrenamos

```js
// Crear el modelo
const model = tf.sequential();
model.add(tf.layers.dense({
    inputShape: [2], // Dos entradas (x1, x2)
    units: 1,        // Una salida
    activation: 'sigmoid' // Activación sigmoide para clasificación binaria
}));

//Compilar el modelo
model.compile({
    optimizer: tf.train.adam(),
    loss: 'binaryCrossentropy',
    metrics: ['accuracy']
});

// Entrenar el modelo
async function trainModel() {
    let avance=0
    const result = await model.fit(trainingData, outputData, {
        epochs: epocas, // Número de iteraciones
        shuffle: true
    });
    document.getElementById('output').innerText = 
        `Entrenamiento completado. Precisión: ${result.history.acc[result.history.acc.length - 1]}
        
        Salida:
    `;
}
```

### hacer predicciones

```js
// Predecir con el modelo entrenado
async function predictOR() {
    const entradas = [
        [0, 0],
        [0, 1],
        [1, 0],
        [1, 1]
    ]
    
    let salida=''
    entradas.forEach((elem, index) => {
        const prediction = model.predict(tf.tensor2d([entradas[index]]));
        
        prediction.data().then(data => {
            const x1=entradas[index][0]?' 1':'-1'
            const x2=entradas[index][1]?' 1':'-1'
            
            salida = `[${x1},${x2}] : ` + data[0].toFixed(2);
            document.getElementById('output').innerText += `
            ${salida}`
        })
    });
}
```