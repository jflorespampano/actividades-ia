/**
 * red neuronal
 * @param {number} inputNodes - # capa de entrada.
 * @param {number} hiddenNodes - # capa oculta.
 * @param {number} outputNodes - # capa de salida.
 */
export class NeuralNetwork {
    constructor(inputNodes, hiddenNodes, outputNodes) {
      this.inputNodes = inputNodes;
      this.hiddenNodes = hiddenNodes;
      this.outputNodes = outputNodes;
  
      // Inicializar pesos y sesgos
      this.weightsInputHidden = this.randomMatrix(this.hiddenNodes, this.inputNodes);
      this.weightsHiddenOutput = this.randomMatrix(this.outputNodes, this.hiddenNodes);
  
      this.biasHidden = this.randomMatrix(this.hiddenNodes, 1);
      this.biasOutput = this.randomMatrix(this.outputNodes, 1);
  
      this.learningRate = 0.1;
    }
  
    /**
     * Genera una matriz de rows*cols con valores aleatotorios
     * @param {*} rows 
     * @param {*} cols 
     * @returns 
     */
    randomMatrix(rows, cols) {
      return Array.from({ length: rows }, () =>
        Array.from({ length: cols }, () => Math.random() * 2 - 1)
      );
    }
  
    /**
     * funcion sigmoide de x; 1/(1+e**-x)
     * @param {*} x 
     * @returns 
     */
    sigmoid(x) {
      return 1 / (1 + Math.exp(-x));
    }
  
    /**
     * derivada de la funcion sigmoide de x
     * @param {*} x 
     * @returns 
     */
    sigmoidDerivative(x) {
      return x * (1 - x);
    }
  
    /**
     * Entrenamiento
     * recibe { inputs: [0, 0], targets: [0] }
     * @param {*} inputArray inputs: [0, 0]
     * @param {*} targetArray targets: [0]
     * @param {*} i para depuracion
     */
    train(inputArray, targetArray,i=11) {
      // Convertir arrays a matrices
      let inputs = this.transpose([inputArray]);
      let targets = this.transpose([targetArray]);
      if(i===1){
        console.log("entradas:",inputs)
        console.log("objetivos:",targets)
      }
      // Feedforward
      let hiddenInputs = this.multiply(this.weightsInputHidden, inputs);

      let hiddenOutputs = this.add(hiddenInputs, this.biasHidden);
      hiddenOutputs = this.map(hiddenOutputs, this.sigmoid);

      if(i===1){
        console.log("weightsInputHidden:",this.weightsInputHidden)
        console.log("inputs:",inputs)
        console.log("hiddenInputs(weightsInputHidden*inputs):",hiddenInputs)
        console.log("hiddenOutputs sigmoid:",hiddenOutputs)
 
      }
  
      let finalInputs = this.multiply(this.weightsHiddenOutput, hiddenOutputs);
      let finalOutputs = this.add(finalInputs, this.biasOutput);
      finalOutputs = this.map(finalOutputs, this.sigmoid);
  
      // Backpropagation (retropropagacion)
      let outputErrors = this.subtract(targets, finalOutputs);
      let outputGradients = this.map(finalOutputs, this.sigmoidDerivative);
      outputGradients = this.multiplyElementwise(outputGradients, outputErrors);
      outputGradients = this.multiplyScalar(outputGradients, this.learningRate);
  
      let hiddenOutputsT = this.transpose(hiddenOutputs);
      let weightsHiddenOutputDeltas = this.multiply(outputGradients, hiddenOutputsT);
  
      this.weightsHiddenOutput = this.add(this.weightsHiddenOutput, weightsHiddenOutputDeltas);
      this.biasOutput = this.add(this.biasOutput, outputGradients);
  
      let weightsHiddenOutputT = this.transpose(this.weightsHiddenOutput);
      let hiddenErrors = this.multiply(weightsHiddenOutputT, outputErrors);
      let hiddenGradients = this.map(hiddenOutputs, this.sigmoidDerivative);
      hiddenGradients = this.multiplyElementwise(hiddenGradients, hiddenErrors);
      hiddenGradients = this.multiplyScalar(hiddenGradients, this.learningRate);
  
      let inputsT = this.transpose(inputs);
      let weightsInputHiddenDeltas = this.multiply(hiddenGradients, inputsT);
  
      this.weightsInputHidden = this.add(this.weightsInputHidden, weightsInputHiddenDeltas);
      this.biasHidden = this.add(this.biasHidden, hiddenGradients);
    }
  
    predict(inputArray) {
      let inputs = this.transpose([inputArray]);
  
      let hiddenInputs = this.multiply(this.weightsInputHidden, inputs);
      let hiddenOutputs = this.add(hiddenInputs, this.biasHidden);
      hiddenOutputs = this.map(hiddenOutputs, this.sigmoid);
  
      let finalInputs = this.multiply(this.weightsHiddenOutput, hiddenOutputs);
      let finalOutputs = this.add(finalInputs, this.biasOutput);
      finalOutputs = this.map(finalOutputs, this.sigmoid);
  
      return finalOutputs;
    }
  
    // Funciones de utilidad para operaciones matriciales
    transpose(matrix) {
      return matrix[0].map((_, i) => matrix.map(row => row[i]));
    }
    /**
     * Multiplicar arreglos
     * @param {*} a arreglo A
     * @param {*} b arreglo B
     * @returns 
     */
    multiply(a, b) {
      let result = Array.from({ length: a.length }, () => Array.from({ length: b[0].length }, () => 0));
  
      for (let i = 0; i < a.length; i++) {
        for (let j = 0; j < b[0].length; j++) {
          for (let k = 0; k < a[0].length; k++) {
            result[i][j] += a[i][k] * b[k][j];
          }
        }
      }
  
      return result;
    }
  
    add(a, b) {
      return a.map((row, i) => row.map((val, j) => val + b[i][j]));
    }
  
    subtract(a, b) {
      return a.map((row, i) => row.map((val, j) => val - b[i][j]));
    }
  
    map(matrix, func) {
      return matrix.map(row => row.map(func));
    }
  
    multiplyElementwise(a, b) {
      return a.map((row, i) => row.map((val, j) => val * b[i][j]));
    }
  
    multiplyScalar(matrix, scalar) {
      return matrix.map(row => row.map(val => val * scalar));
    }
  } //fin de la clase