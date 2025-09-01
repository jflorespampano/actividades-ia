const swipl = require('node-swipl');

const engine = new swipl.Engine();
const resultado = engine.call('member(X, [1,2,3])');
console.log(resultado.X); // Imprime 1, 2, 3 (en iteraciones)