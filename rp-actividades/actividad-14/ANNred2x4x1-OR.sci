//red neuronal para xor/or/and de 2x4x1
// Cargar la ANN Toolbox
//atomsLoad("ann");

// Crear la red neuronal
N = [2,4,1];
//net = ann_FF_init(N);

// Datos de entrada
X = [0 0; 0 1; 1 0; 1 1]';

//salida="XOR"
//Y = [0; 1; 1; 0]';

salida="OR"
Y = [0; 1; 1; 1]';

//salida="AND"
//Y = [0; 0; 0; 1]';

// Parámetros de entrenamiento
learning_rate = [0.1, 0];// 0.1;

W= ann_FF_init(N);
// no funciona esta linea W= ann_FF_init(N, 'sigmoid');

epochs = 500;

// Entrenar la red
/*
En el aprendizaje en línea, el modelo se actualiza incrementalmente 
con cada nuevo dato o pequeño lote de datos, 
en lugar de utilizar el lote completo
(como en el aprendizaje por lotes o batch learning).
En ann_FF_Std_online la funcion de activacion esta predefinida
como sigmoide para clasificacion binaria y
softmax para multiclase
*/

 W= ann_FF_Std_online(X,Y,N,W,learning_rate,epochs);

// Probar la red
predicciones = ann_FF_run(X,N,W);
// Mostrar las predicciones
disp("Predicciones:")
disp(predicciones);
//cambiar salidas a -1,1
AUX=sign(predicciones'-0.5)
//cambiar salidas a 0,1
P=(AUX+1)/2
disp("PREDICCIONES para: "+salida)
disp([X',P])

