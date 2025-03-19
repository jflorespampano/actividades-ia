//Autor: Jflores
//marzo 2025
//red neuronal de 4 entradas 10 neuronas ocultas y 3 salidas
//para predecir salidas de las observaciones de la flor IRIS
//probado con 30 observaiones de IRIS
//Las salidas que pueden ser 3 valores (1,2,3) se toman como
//[1,0,0] paraa 1, [0,1,0] para 2 y [0,0,1] para 3 y se usa
//la función sigmoide en la salida de las neuronas. 

// Parámetros de la red
n_entradas = 4;  // Número de entradas
n_ocultas = 10;  // Neuronas en la capa oculta
n_salidas = 3;   // Neuronas en la capa de salida
n_num_dat_ent = 30 //numero de datos de entrenamiento

//% Función de activación sigmoide
function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
endfunction

//% Derivada de la sigmoide
function y = sigmoid_derivada(x)
    y = sigmoid(x) .* (1 - sigmoid(x));
endfunction


// Inicializar pesos y sesgos aleatoriamente
W1 = rand(n_entradas, n_ocultas);  // Pesos capa oculta
b1 = rand(1, n_ocultas);           // Sesgos capa oculta
W2 = rand(n_ocultas, n_salidas);   // Pesos capa salida
b2 = rand(1, n_salidas);           // Sesgos capa salida


//30 datos de las observaciones IRIS y sus etiquetas
IRIS_DATA=[
[5.1,3.5,1.4,0.2];[4.9,3,1.4,0.2];[4.7,3.2,1.3,0.2];[4.6,3.1,1.5,0.2];[5,3.6,1.4,0.2];
[5.4,3.9,1.7,0.4];[4.6,3.4,1.4,0.3];[5,3.4,1.5,0.2];[4.4,2.9,1.4,0.2];[4.9,3.1,1.5,0.1];
[6.4,3.2,4.5,1.5];[6.9,3.1,4.9,1.5];[5.5,2.3,4,1.3];[6.5,2.8,4.6,1.5];[5.7,2.8,4.5,1.3];
[6.3,3.3,4.7,1.6];[4.9,2.4,3.3,1];[6.6,2.9,4.6,1.3];[5.2,2.7,3.9,1.4];[5,2,3.5,1];
[6,3,4.8,1.8];[6.9,3.1,5.4,2.1];[6.7,3.1,5.6,2.4];[6.9,3.1,5.1,2.3];[5.8,2.7,5.1,1.9];
[6.8,3.2,5.9,2.3];[6.7,3.3,5.7,2.5];[6.7,3,5.2,2.3];[6.3,2.5,5,1.9];[6.5,3,5.2,2]
];
Y_DATA=[
[1,0,0];[1,0,0];[1,0,0];[1,0,0];[1,0,0];[1,0,0];[1,0,0];[1,0,0];[1,0,0];[1,0,0];
[0,1,0];[0,1,0];[0,1,0];[0,1,0];[0,1,0];[0,1,0];[0,1,0];[0,1,0];[0,1,0];[0,1,0];
[0,0,1];[0,0,1];[0,0,1];[0,0,1];[0,0,1];[0,0,1];[0,0,1];[0,0,1];[0,0,1];[0,0,1]
];
// Datos de entrenamiento (ejemplo)
//X = rand(n_num_dat_ent, n_entradas);  // 100 muestras, 4 características
//Y = rand(n_num_dat_ent, n_salidas);   //% 100 etiquetas, 3 salidas

X=IRIS_DATA;
Y=Y_DATA;
//mostrar entradas
disp("Datos de entrada")
disp(cat(2,X,Y))

// entrenamiento
disp("Entrenamiento:")
//% Hiperparámetros
tasa_aprendizaje = 0.1;
max_iter = 1000;

//% Entrenamiento
for iter = 1:max_iter
    //% Propagación hacia adelante
    b1_expanded = repmat(b1, n_num_dat_ent,1);
    //Expande b1[1,10] para que sea [30,10]
    //para sumar a esto:  X * W1 = [30,4]*[4,10]=[30,10]
    //suma de las entradas ponederadas + los sesgos
    Z1 = X * W1 + b1_expanded
    //A1 salidas de la capa oculta
    A1 = sigmoid(Z1);
    //A2 salidas de la capa de salida
    b2_expanded = repmat(b2, n_num_dat_ent,1);
    Z2 = A1 * W2 + b2_expanded;
    A2 = sigmoid(Z2);

    //Cálculo del error
    error = Y - A2;

    //Retropropagación
    dZ2 = error .* sigmoid_derivada(Z2);
    dW2 = A1' * dZ2;
    db2 = sum(dZ2, 1);

    dZ1 = (dZ2 * W2') .* sigmoid_derivada(Z1);
    dW1 = X' * dZ1;
    db1 = sum(dZ1, 1);

    //% Actualizar pesos y sesgos
    W2 = W2 + tasa_aprendizaje * dW2;
    b2 = b2 + tasa_aprendizaje * db2;
    W1 = W1 + tasa_aprendizaje * dW1;
    b1 = b1 + tasa_aprendizaje * db1;
end

//Probar la red
b1_exp=repmat(b1,n_num_dat_ent,1)
b2_exp=repmat(b2,n_num_dat_ent,1)
Y_pred = sigmoid(sigmoid(X * W1 + b1_exp) * W2 + b2_exp);
disp("Predicciones:");
disp(cat(2,X,fix(Y_pred+0.5)));
//disp(Y_pred);
