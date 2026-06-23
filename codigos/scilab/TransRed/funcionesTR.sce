//funciones para algoritmo TransRed//JAFH feb 2016

//lee un archivo de texto con 3 números por renglon
//2 para las coordenadas del vector en r2 y un valor 1 o -1
//que indica a que clase pertenece el vector, separa los vectores en dos clases
//devuelve X matriz con todos los datos, Xmas y Xmenos y Y(i)=vector de clasificacion
//Xmas y Xmenos arreglos de 2 dimenciones, clasificados segun Y a partir de X
function [X,Y,Xmas,Xmenos]=leeConjuntoTrabajo(archivo)
      m=read(archivo,40,3);
      X=m(:,1:2);
      Y=m(:,3);
      tamXmas=0;
      tamXmenos=0;
      for i=1:length(Y)
          if (Y(i)==1)
              tamXmas=tamXmas+1;
          else
              tamXmenos=tamXmenos+1;
          end
      end
      //Xmas, Xmanos son los dos conjuntos de trabajo ie, las dos clases
      //aqui separamos el conjunto inical en sus dos clases en Xmas, Xmenos
      Xmas=zeros(tamXmas,2);
      Xmenos=zeros(tamXmenos,2);
      j=1;
      k=1;
      for i=1:length(Y)
          if (Y(i)==1)
              Xmas(j,1)=X(i,1);
              Xmas(j,2)=X(i,2);
              j=j+1;
          else
              Xmenos(k,1)=X(i,1);
              Xmenos(k,2)=X(i,2);
              k=k+1;
          end
      end  
endfunction

//Grafica los punos de Xmas y Xmenos
//recibe dos matrices de n renglones x 2 columnas
//cada renglon representa las 2 coordenadas de un vector en 2 dimenciones
function resp=graficaPuntos(Xmas,Xmenos)
    for i=1:length(Xmas(:,1))
        plot(Xmas(i,1),Xmas(i,2),'red.')
    end
    for i=1:length(Xmenos(:,1))
        plot(Xmenos(i,1),Xmenos(i,2),'blu.')
    end
    resp=1;
endfunction

//calcula el centro de una esfera en R2 para los vectores de la matriz Xm
//Xm es una matriz de n x 2 con cada renglos las coordenadas de un vector en r2
function centro=centroEsfera(Xm)
    centro=[0,0];
    for i=1:length(Xm(:,1))
        centro(1)=centro(1)+Xm(i,1);
        centro(2)=centro(2)+Xm(i,2);
    end
    centro(1)=centro(1)/length(Xm(:,1));
    centro(2)=centro(2)/length(Xm(:,1));
endfunction

//calcula el radio de la eresfera en R2 recibe el centro de la hiperesfera
//y la matriz con los vecores
//devuelve el radio
function rmas=radioEsfera(Cmas,Xm)
    rmas=0;
    aux=0;
    for i=1:length(Xm(:,1))
        aux1=Cmas(1)*Cmas(1)+Cmas(2)*Cmas(2);
        aux2=-2*(Cmas(1)*Xm(i,1)+Cmas(2)*Xm(i,2));
        aux3=Xm(i,1)*Xm(i,1)+Xm(i,2)*Xm(i,2);
        aux=aux1+aux2+aux3;
        if aux>rmas then
            rmas=aux
        end
    end
endfunction

//grafica la eresfera
function graficaEsfera(centro,radio)
    a=0;
    b=0;
    for i=1:360
        a=radio*sin(i);
        b=radio*cos(i);
        plot(centro(1)+b,centro(2)+a,'gre.')
    end
endfunction

//grafica las esferas los cenros y los puntos de X+ y X-

function [cxmas,cxmenos]=graficaesferas_y_Datos(Xmas,Xmenos)
    //centro hiperesfera Xmas
    cxmas=centroEsfera(Xmas);
    plot(cxmas(1),cxmas(2),'gre.')
    //centreo hiperesfera Xmas
    cxmenos=centroEsfera(Xmenos);
    plot(cxmenos(1),cxmenos(2),'gre.')
    //radios de las hiperesferas
    rmas=radioEsfera(cxmas,Xmas);
    rmenos=radioEsfera(cxmenos,Xmenos);
    //grafica
    graficaEsfera(cxmas,rmas);
    graficaEsfera(cxmenos,rmenos);
    //grafica puntos
    resp=graficaPuntos(Xmas,Xmenos);
endfunction

//////////////// otras funciones//////////////////////
//
//////////////////////////////////////////////////////
//lee un archivo txt con formato:
//cada renglon del archivo tiene 3 números separados por espacios
//y correspondes a las 2 coordenadas del vector mas un valor de 1
//o -1 indicando la clase a la que pertenece el vector, devuelve
//una matriz con los valores leidos
function m=leeArchivo(archivo)
    m=read(archivo,40,3);
endfunction

//kernel
function kdeuv=mi_kernel(u,v)
    kdeuv=(u(1)*v(1))^2+2*u(1)*u(2)*v(1)*v(2)+(u(2)*v(2))^2;
endfunction

///////////////////////////////////////////////////////////////
//calcular d+-, la distancia entre los centros de las esferas
//dmasmenos^2=abs(fi(xc+)-fi(xc-))=K(xc+,xc+)-2K(xc+,xc-)+K(xc-,xc-)
// ademas K(xc+,xc-)=1/((N-)(N+))*Sumatoria(Sumatoria(K(xi,xj)))
//la funcion Kdexcixcj, realiza lo anterior
function Kxcxc=Kdexcixcj(Xmenos,Xmas)
    Kxcxc=0;
    for j=1:length(Xmenos(:,1))
        for i=1:length(Xmas(:,1))
            Kxcxc=Kxcxc+mi_kernel(Xmas([i],:),Xmenos([j],:));
        end
    end
    Kxcxc=Kxcxc/(length(Xmenos)*length(Xmas));
endfunction

//calcula el radio de la hiperesfera, recibe el conjunto de vectores  y elcentro de la esfera en R2
function rhe=radioHiperEsfera(X,centro)
    rhe=0;
    for i=1:length(X(:,1))
        aux=mi_kernel(centro,centro)-2*mi_kernel(centro,X(i,:))+mi_kernel(X(i,:),X(i,:));
        if aux>rhe
            rhe=aux;
        end
    end
    rhe=sqrt(rhe);
endfunction
//
//calculando la distancia de losvectores X al hiperplano
function [distXmas,dmxi]=ditanciaXalHiperplano(Xmas,Xmenos,dmasmenos,Mmas,bias)
    distXmas=zeros(length(Xmas(:,1)),1);
    dmxi=zeros(length(Xmas(:,1)),1);
    //b+0= (K(xc+, xc+)-K(xc+,xc-))/d+-
    //bias=(Kdexcixcj(Xmas,Xmas)-Kdexcixcj(Xmas,Xmenos))/dmasmenos;
    // la distancia a este plano se puede escribir como
    for i=1:length(Xmas(:,1))
        //d de M+<->x de a
        distXmas(i)=(1/dmasmenos*(mi_kernel(cxmas,Xmas(i,:))-mi_kernel(cxmenos,Xmas(i,:))))+bias;
        aux1=distXmas(i)-Mmas;
        //calculando la norma
        dmxi(i)=sqrt(aux1*aux1);
    end
endfunction


