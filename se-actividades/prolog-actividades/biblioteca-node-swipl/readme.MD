# notas

node-swipl funciona mejor con Node.js v14.x o v16.x. 

Si usas una versión más reciente deberas hacer:
1. usa: child_process:
2. Ejecuta SWI-Prolog como subproceso desde Node.js (sin node-swipl).

## Usando node-swipl

```sh
npm install node-swipl
```

```js
const swipl = require('node-swipl');
const engine = new swipl.Engine();
const resultado = engine.call('member(X, [1,2,3])');
console.log(resultado.X); // Imprime 1, 2, 3 (en iteraciones)
```