Un perceptrón es una de las formas más simples de una red neuronal artificial, y es la base para entender modelos más complejos. A continuación te muestro cómo implementar un perceptrón simple en JavaScript.

### Implementación de un Perceptrón en JavaScript

```javascript
class Perceptron {
    constructor(numInputs, learningRate = 0.1) {
        this.weights = new Array(numInputs);
        this.learningRate = learningRate;

        // Inicializar los pesos con valores aleatorios
        for (let i = 0; i < this.weights.length; i++) {
            this.weights[i] = Math.random() * 2 - 1; // Valores entre -1 y 1
        }
    }

    // Función de activación (en este caso, la función signo)
    activate(sum) {
        return sum >= 0 ? 1 : -1;
    }

    // Realizar una predicción
    predict(inputs) {
        let sum = 0;
        for (let i = 0; i < this.weights.length; i++) {
            sum += inputs[i] * this.weights[i];
        }
        return this.activate(sum);
    }

    // Entrenar el perceptrón
    train(inputs, target) {
        const prediction = this.predict(inputs);
        const error = target - prediction;

        // Ajustar los pesos
        for (let i = 0; i < this.weights.length; i++) {
            this.weights[i] += this.learningRate * error * inputs[i];
        }
    }
}

// Ejemplo de uso
const perceptron = new Perceptron(2); // Perceptrón con 2 entradas

// Datos de entrenamiento (OR gate)
const trainingData = [
    { inputs: [1, 1], target: 1 },
    { inputs: [1, -1], target: 1 },
    { inputs: [-1, 1], target: 1 },
    { inputs: [-1, -1], target: -1 }
];

// Entrenar el perceptrón
for (let i = 0; i < 1000; i++) {
    trainingData.forEach(data => {
        perceptron.train(data.inputs, data.target);
    });
}

// Probar el perceptrón
console.log(perceptron.predict([1, 1]));   // Debería ser 1
console.log(perceptron.predict([1, -1]));  // Debería ser 1
console.log(perceptron.predict([-1, 1]));  // Debería ser 1
console.log(perceptron.predict([-1, -1])); // Debería ser -1
```

### Explicación del Código

1. **Inicialización de Pesos**: Los pesos se inicializan con valores aleatorios entre -1 y 1. Estos pesos se ajustarán durante el entrenamiento.

2. **Función de Activación**: En este caso, se utiliza la función signo (`activate`), que devuelve 1 si la suma ponderada es mayor o igual a 0, y -1 en caso contrario.

3. **Predicción**: El método `predict` calcula la suma ponderada de las entradas y los pesos, y luego aplica la función de activación para obtener la salida.

4. **Entrenamiento**: El método `train` ajusta los pesos en función del error entre la predicción y el valor objetivo. El error se multiplica por la tasa de aprendizaje (`learningRate`) y las entradas para actualizar los pesos.

5. **Ejemplo de Uso**: Se entrena el perceptrón con un conjunto de datos que representa la función lógica OR. Después del entrenamiento, el perceptrón debería ser capaz de predecir correctamente las salidas para las entradas dadas.

### Consideraciones

- Este perceptrón es muy básico y solo puede aprender funciones linealmente separables.
- Para problemas más complejos, se necesitarían redes neuronales más avanzadas, como las redes multicapa o las redes neuronales convolucionales.

Este código es un buen punto de partida para entender cómo funciona un perceptrón y cómo se puede implementar en JavaScript.