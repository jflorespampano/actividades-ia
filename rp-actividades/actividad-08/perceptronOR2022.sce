//Jesus Alejandro Flores Hernandez 
//codigo en SCILAB
//Ejemplode perceptron simple
//Probado y revisado 1 agosto 2022
//Funcion OR
//
function graficaLinea(miColor)
    for i=1:100
        if w(2)==0 then
            fx(i)=0
        else
            fx(i)=(-w(1)*p_eje_x(i)-w(3))/w(2);    
        end
    end
    plot(p_eje_x,fx,miColor);
endfunction
function muestraSalidaInicial()
    mfprintf(6,'Perceptron para reconocer la tabla Or \n'); //escribe a consola
    mfprintf(6,'Linea roja pesos iniciales\n'); //escribe a consola
    mfprintf(6,'Linea verde iteraciones\n'); //escribe a consola
    mfprintf(6,'Linea azul pesos finales:\n   x    y    or'); //escribe a consola
    disp([x,salida_ok]);
    
    //muestra en rojo la recta del perceptron con los pesos actuales
    graficaLinea('r');
    //muestra las puntos clasificados
    for i=1:nct
            if salida_ok(i)==1 then
                plot(x1(i),x2(i),'gre*');
            else
                plot(x1(i),x2(i),'blu*');    
            end
    end
endfunction

function  perceptron()
    nct=4; //tamanoo del conjunto de trabajo
    y=[-1,-1,1,1;-1,1,-1,1]
    x=y';
    x1=x(:,1);//Arreglo x1 contiene coordenadas x
    x2=x(:,2);//Arreglo y1 contiene coordenadas y
    //plot(x1,x2,'*');
    //pesos iniciales son w1=0 and w2=0, w3 es el umbral
    w=[0;0;0.5];
    salida_ok=[-1;1;1;1]; //salida de la función OR
    p_eje_x=linspace(-2,3,100);
    muestraSalidaInicial()
    //Calculamos la salida del perceptron con los pesos
    //actuales para todos los puntos 
    for i=1:nct
        salida_rn(i)=sign(w(2)*x2(i)+w(1)*x1(i)-w(3));
    end
    //~= operador relacional: es distonto que
    //buscamos las salidas que no concuerdan con nuestra
    //clasificacion
    ind = find(salida_ok ~= salida_rn);
    //ind contiene indices donde no coinciden los vectores salida red neuronal y salida correcta
    disp([salida_ok,salida_rn]);
    iter=1;
    while ~isempty(ind) //si es vacio => fin
        mfprintf(6,'iteracion %d salidas que no concuerdad:\n    real    g',iter);
        disp([salida_ok,salida_rn]);
        mfprintf(6,'vector de pesos:\n    w1    w2    w0=U');
        disp(w');
        //operador .* es multiplicacion de matrices elemento a elemento
         w(1) = w(1) + (salida_ok(ind(1))-salida_rn(ind(1))).*x1(ind(1));  // 
         w(2) = w(2) + (salida_ok(ind(1))-salida_rn(ind(1))).*x2(ind(1));  // 
         w(3) = w(3) + (salida_ok(ind(1))-salida_rn(ind(1)));  //
        //calcular la salida del perceptron
        for i=1:nct
             temp(i)=sign(w(2)*x2(i)+w(1)*x1(i)+w(3));
        end
        //buscar salidas que no concuerdan
        ind = find(salida_ok ~= temp);
        salida_rn=temp;
    
        iter = iter + 1;
        if iter>600 then
            break;
        end
        graficaLinea('g');
    end
    mfprintf(6,'- - Al final de %d iteraciones\nvector de indices - - -',iter); //escribe a consola
    disp(ind);
    mfprintf(6,'vector de clasificación / vector salida: \nClass_F  g'); 
    disp([salida_ok,salida_rn]);
    
    mfprintf(6,'vector de pesos:\n    w1    w2    w0=U'); 
    disp(w');
    
    graficaLinea('b');
endfunction

perceptron()
