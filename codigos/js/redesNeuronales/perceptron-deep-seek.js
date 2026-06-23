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