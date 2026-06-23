import * as tf from '@tensorflow/tfjs';
function prueba(){
    //cuadrado
    const x = tf.tensor([1, 2, 3, 4]);
    const y = x.square();  // equivalent to tf.square(x)
    y.print(); //[1, 4, 9, 16]
    

    //suma de tensores
    const a = tf.tensor([1, 2, 3, 4]);
    const b = tf.tensor([10, 20, 30, 40]);
    const ys = a.add(b);  // equivalent to tf.add(a, b)
    console.log('Resultado de la suma:');
    ys.print(); //[11, 22, 33, 44]

    //Suma de tensores
    const c = tf.add(a, b);
    console.log('Resultado de la suma:');
    c.print(); //[11, 22, 33, 44]

    // Multiplicación de tensores
    const d = tf.mul(a, b);
    console.log('Resultado de la multiplicación:');
    d.print(); //[10, 40, 90, 160]

    // Transposición de un tensor
    const m=tf.tensor([[1, 2],[3, 4]])
    const e = tf.transpose(m);
    console.log('Transposición del tensor a:');
    e.print(); //[[1, 3],[2, 4]]

    // Reducción (suma de todos los elementos)
    const f = tf.sum(a);
    console.log('Suma de todos los elementos del tensor a:');
    f.print(); //10

    
}


function main(){
    tf.tidy(() => {
        prueba();
    });
}

main();