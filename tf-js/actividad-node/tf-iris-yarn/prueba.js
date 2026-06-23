import * as tf from '@tensorflow/tfjs';

function prueba(){
    console.log("node ")
    //Crear tensores
    //crea tensor de rango 2 (matriz) desde un arreglo multidimensional
    const a = tf.tensor([[1, 2], [3, 4]]);
    // muestra la forma del tensor
    console.log('shape:', a.shape);
    // imprime el tensor
    a.print();
    
    //o puede crear el tensor desde un arreglo plano y especificar el
    // shape (la forma).
    const shape = [2, 2];
    const b = tf.tensor([1, 2, 3, 4], shape);
    console.log('shape:', b.shape);
    b.print();

    //Operaciones con tensores
    const c = tf.add(a, b);
    console.log('Resultado de la suma:');
    c.print();
    // Multiplicación de tensores
    const d = tf.mul(a, b);
    console.log('Resultado de la multiplicación:');
    d.print();
    // Transposición de un tensor
    const e = tf.transpose(a);
    console.log('Transposición del tensor a:');
    e.print();
    // Reducción (suma de todos los elementos)
    const f = tf.sum(a);
    console.log('Suma de todos los elementos del tensor a:');
    f.print();
    // Indexación y corte (slicing)
    const g = a.slice([0, 0], [1, 2]);
    console.log('Corte del tensor a (primera fila):');
    g.print();

    
    // Reshape (cambio de forma)
    const h = a.reshape([4, 1]);
    console.log('Tensor a con nueva forma [4, 1]:');
    h.print();
    // Operación asincrónica para obtener los datos del tensor
    a.data().then(data => {
        console.log('Datos del tensor a:', data);
    });

    // Nota: En un entorno real, considere usar tf.tidy() para manejar la memoria automáticamente.
    // tf.tidy(() => {
    //     // operaciones con tensores aquí
    // });
    // Fin de la prueba
    // obtenr datos de un tensor de forma sincrona
    const dataSync = b.dataSync();
    console.log('Datos del tensor b (sincrono):', dataSync);
    // Liberar memoria
    // a.dispose();
    // b.dispose();
    // c.dispose();
    // d.dispose();
    // e.dispose();
    // f.dispose();
    // g.dispose();
    // h.dispose();
}

function main(){
    tf.tidy(() => {
        prueba();
    });
}

// prueba();
main();
