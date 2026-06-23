//funcio transred, recibe los puntos X+ y X- y los centros de las esferas
//en cxmas y cxmenos, numVecEnt es el número de vectores de entrebnamiento a
//graficar
//devuelve Maux1 y Maux2, arreglos con los vectores ordenados de menor a mayor 
//al hiperplano de separación
//Maux1 para Xmas y Maux2 para Xmenos
//grafica los vetores de soporte
/////////////////////////////////////////////////////////////////////////////// 
function [Maux1,Maux2]=aplicaTransRed(Xmas,Xmenos,cxmas,cxmenos,numVecEnt)
    //encontrar los vectores de entrenamiento en el hiperespacio
    ////////////////////////////////////////////////////////////
    //numVecEnt=3 //numero de vectores a buscar
    //calcular el radio de las hiperesferas
    rhXmas=radioHiperEsfera(Xmas,cxmas);
    rhXmenos=radioHiperEsfera(Xmenos,cxmenos);
    //calcular m+, m-, la distancia entre el plano y el centro de las clases
    temporal=Kdexcixcj(Xmas,Xmas)-2*Kdexcixcj(Xmas,Xmenos)+Kdexcixcj(Xmenos,Xmenos);
    dmasmenos=sqrt(temporal);
    Mmas=(dmasmenos + (rhXmas - rhXmenos)) / 2; //Mmas=(dmasmenos)/2;
    Mmenos=dmasmenos - Mmas;
    ////////////////////aplicando transRed//////////////////////////
    //calculando la distancia de losvectores Xmas al hiperplano
    bias=(Kdexcixcj(Xmas,Xmas)-Kdexcixcj(Xmas,Xmenos))/dmasmenos;
    [distXmas,dmxi]=ditanciaXalHiperplano(Xmas,Xmenos,dmasmenos,Mmas,bias)
    //ordenar los resultados
    Maux1=Xmas;
    [Y1, I]=gsort(dmxi,'g','i');
    for i=1:length(I)
       dmxi(I(i));
       Maux1(i,:)=Xmas(I(i),:);
    end
    //graficar los vectores de entrenamiento
    for i=1:numVecEnt
       plot(Maux1(i,1),Maux1(i,2),'bla*');
    end
    /////////////////////////////////////////////////////////////
    //calculando la distancia de losvectores Xmenos al hiperplano
    [distXmenos,dmxi2]=ditanciaXalHiperplano(Xmenos,Xmas,dmasmenos,Mmenos,bias)
    //ordenar los resultados *** ver por k me los ordena al reves arriba pongo 'i' y abajo 'd'
    Maux2=Xmenos;
    [Y1, I]=gsort(dmxi2,'g','d');
    for i=1:length(I)
       dmxi2(I(i));
       Maux2(i,:)=Xmenos(I(i),:);
    end
    //graficar los vectores de entrenamiento
    for i=1:numVecEnt
       plot(Maux2(i,1),Maux2(i,2),'blao');
    end
endfunction
