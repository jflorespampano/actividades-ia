export class Neural {
    constructor(inputNodes) {
      this.inputNodes = inputNodes;
      this.output = 0;
  
      // Inicializar pesos y sesgos
      this.weights = this.randomArray(this.inputNodes);
      this.bias = Math.random() * 2 - 1;
      this.learningRate = 0.1;
    }
    /**
     * Genera una matriz de rows*cols con valores aleatotorios
     * @param {*} rows 
     * @param {*} cols 
     * @returns 
     */
    randomArray(cols) {
        Array.from({ length: cols }, () => Math.random() * 2 - 1)
    }
    // Función de propagación hacia adelante
    forward = (x) => {
        const sum = w[0] * x[0] + w[1] * x[1] + b;
        return sum > 0 ? 1 : 0;
    };
    train(){
        // Entrenamiento
        for (let i = 0; i < X.length; i++) {
            const y_pred = forward(X[i]);
            const e = y[i] - y_pred;
            w[0] = w[0] + eta * e * X[i][0];
            w[1] = w[1] + eta * e * X[i][1];
            b = b + eta * e;
        }
    }
}

console.log(Math.random() * 2 - 1)
console.log(Math.random())