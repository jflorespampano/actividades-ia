//tensor desde arreglo de 2*2 (2 renglones, 2 columnas)
const a = tf.tensor([[1, 2], [3, 4]]);
console.log('shape:', a.shape);
a.print();
//tensor desde arreglo de 1*9 con forma (chape) de 3*3
const b = tf.tensor([1, 2, 3, 4, 5 , 6, 7, 8, 9], [3, 3]);
console.log('shape:', b.shape);
b.print();

const c=b.reshape([9,1]);
c.print();
//
// Retorna un arreglo multideminecional a partir del tensor
console.log(a.arraySync());
// Retorna los datos planos del tensor.
console.log(a.dataSync());
//
const a1 = tf.tensor([1, 2, 3, 4]);
const b1 = tf.tensor([10, 20, 30, 40]);
const y1 = a1.add(b1); // equivale a tf.add(a, b)
y1.print();
//
//para eliminar resultador intermedios tidy
const a2 = tf.tensor([[1, 2], [3, 4]]);
const y2 = tf.tidy(() => {
    const result = a.square().log().neg();
    return result;
});