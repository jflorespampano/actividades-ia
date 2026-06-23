//Jesus Alejandro Flores Hernandez 
//codigo en SCILAB
//Ejemplode perceptron simple
//Probado y revisado 22 sep 2016
//Funcion OR
//
function graficaLinea(miColor)
    for i=1:100
        if w(2)==0 then
            y3(i)=0
        else
            y3(i)=(-w(1)*x2(i)-w(3))/w(2);    
        end
    end
    plot(x2,y3,miColor);
endfunction

nct=4; //tamaÃ±o del conjunto de trabajo
y=[-1,-1,1,1;-1,1,-1,1]
x=y';
x1=x(:,1);//Arreglo x1 contiene coordenadas x
y1=x(:,2);//Arreglo y1 contiene coordenadas y
plot(x1,y1,'*');

//pesos iniciales son w1=0 and w2=0, w3 es el umbral
//w=[1;1;0.5];
w=[0;0;0.5];
class_F=[-1;-1;-1;1]; //salida de la funcion AND

mfprintf(6,'Perceptron para reconocer la tabla Or \n'); //escribe a consola
mfprintf(6,'Linea roja pesos iniciales\n'); //escribe a consola
mfprintf(6,'Linea verde iteraciones\n'); //escribe a consola
mfprintf(6,'Linea azul pesos finales:\n    x     y     or'); //escribe a consola
disp([x,class_F]);

//muestra las puntos clasificados
for i=1:nct
        if class_F(i)==1 then
            plot(x1(i),y1(i),'gre*');
        else
            plot(x1(i),y1(i),'blu*');    
        end
end
//
x2=linspace(-2,2,100);
for i=1:100
    y2(i)=2*x2(i);
end
//muestra la recta del perceptron con los pesos actuales
for i=1:100
    if w(2)==0 then
        y3(i)=0
    else
        y3(i)=(-w(1)*x2(i)-w(3))/w(2);    
    end
    
end
plot(x2,y3,'r');


//Calculamos la salida del perceptron con los pesos
//actuales para todos los puntos 
for i=1:nct
    g(i)=sign(w(2)*y1(i)+w(1)*x1(i)+w(3));
end
//~= operador relacionl es distonto que
//buscamos las salidas que no concuerdan con nuestra
//clasificaciÃ³n
ind = find(class_F ~= g);
iter=1;


while ~isempty(ind) //si es vacio => fin
    mfprintf(6,'iteracion %d salidas que no concuerdad:\n    real    g',iter);
    disp([class_F,g]);
    mfprintf(6,'vector de pesos:\n    w1    w2    w0=U');
    disp(w');
    //operador .* es multiplicaciÃ³n de matrices elemento a elemento
     w(1) = w(1) + (class_F(ind(1))-g(ind(1))).*x1(ind(1));  // 
     w(2) = w(2) + (class_F(ind(1))-g(ind(1))).*y1(ind(1));  // 
     w(3) = w(3) + (class_F(ind(1))-g(ind(1)));  //
    //calcular la salida del perceptron
    for i=1:nct
         temp(i)=sign(w(2)*y1(i)+w(1)*x1(i)+w(3));
    end
    //buscar salidas que no concuerdan
    ind = find(class_F ~= temp);
    g=temp;

    iter = iter + 1;
    if iter>600 then
        break;
    end
    graficaLinea('g');
end
mfprintf(6,'- - Al final de %d iteraciones\nvector de indices - - -',iter); //escribe a consola
disp(ind);
mfprintf(6,'vector de clasificación / vector salida: \nClass_F  g'); 
disp([class_F,g]);

mfprintf(6,'vector de pesos:\n    w1    w2    w0=U'); 
disp(w');

graficaLinea('b');

