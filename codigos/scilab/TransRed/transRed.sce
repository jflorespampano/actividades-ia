//Algoritmo TransRed para preprocesamiento de SVM
//JAFH Feb 2016
//este algoritmo usa las funciones definidas en el archivo funciones.sce
//SE REQUIERE EJECUTAR funcionesTR.sci ANTES DE TRABAJAR CON ESTE CÓDIGO

//clear
//
archivo="C:\trabajo\colegiado\docencia\misCursos\progAvanzada\codigos\sciLab\TransRed\datos01.txt";
[X,Y,Xmas,Xmenos]=leeConjuntoTrabajo(archivo);
/////// grafica las esferas y los puntos en R2
[cxmas,cxmenos]=graficaesferas_y_Datos(Xmas,Xmenos);
//encontrar los vectores de entrenamiento en el hiperespacio
numVecEnt=3; //numero de vectores a buscar
[Maux1,Maux2]=aplicaTransRed(Xmas,Xmenos,cxmas,cxmenos,numVecEnt);


