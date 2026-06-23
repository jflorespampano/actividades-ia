//ensure the same starting point each time
rand('seed',0);
//network def
//2 neuronas de entrada 2 ocultas 1 de salida
N = [2,2,1]
//entradas
x=[0.8900, 0.7916;
    0.8544, 0.7470;
    0.8482, 0.7297;
    1.0000, 1.0000;
    0.0411, 0.0746;
    0.0380, 0.0240;
    0.0247, 0.0190;
    0.0193, 0.0102;
    0.0086, 0.0053;
    0.0061, 0.0026;
    0.0044, 0.0009;
    0.0000, 0.0000;]';
    
    //salidas 1 clase A 0 clase B
    t=[1 1 1 1 0 0 0 0 0 0 0 0 ];
    //tasa de aprendizaje
    lp=[0.1, 0];
    
    W= ann_FF_init(N);
    //epocas
    T = 400;
    
    W= ann_FF_Std_online(x,t,N,W,lp,T);
    //x entrenametno
    //t salidas W pesos inicializados, N la arquitectura NN
    //lp tasa de entrenamiento
    //T iteraciones
    
    //full run
    predicciones=ann_FF_run(x,N,W);
    
    disp(predicciones);
