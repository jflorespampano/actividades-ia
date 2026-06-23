const tf=require('./bibliotecas/tf.js');

const a = tf.tensor([[1, 2], [3, 4]]);
console.log('a shape:', a.shape);
a.print();
