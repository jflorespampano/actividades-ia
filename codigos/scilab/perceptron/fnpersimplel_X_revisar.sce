//hay que revisarla
function [x1,y1,class_F]=leeArchivo(archivo)
      m=read(archivo,40,3);
      x1=m(:,1:2);
      y1=m(:,1:2);
      class_F=m(:,3);  
endfunction
//
//Genera un conjunto de números aleatorios 
//distribuidos dentro del cuadrado en el plano XY
//con esquinas (-1,1),(1,1),(1,-1),(-1,-1)
function escribeArchivo(archivo)
    x=2*rand(2,20)-1;
    x1=x(1,:);//Array x1 con las coordenadas x de los puntos
    y1=x(2,:);//Array y1 con las coordenadas y de los puntos
    //Trazamos una línea arbitraria linea y-2x=0 f(x): y-2x=0
    //Guardamos los coefficients de the x y y en el arreglo F
    F=[1;-2];
    //para disponer de un conjunto de puntos clasificados para el
    //entrenamiento
    //Classificamos primeros 10 puntos a la derecha o a la izquierda de la linea
    for i=1:20
        l(i)=F(2)*y1(i)+F(1)*x1(i);
        class_F(i)=sign(l(i));
    end
    M=[x1;y1;class_F'];
    //archivo="C:\trabajo\gestoriaLI\materialYcursos\progAvanzada\sciLab\TransRed\datosA01.txt";
    write(archivo,M');
endfunction

//aplica perceptron simple recibe nombre del archivo con 3 columna
// x1,y1, clase
//devueleve las ws
function w=perceptronSimple(archivo)
    nct=10; //tamaño del conjunto de trabajo
    //archivo="C:\trabajo\gestoriaLI\materialYcursos\progAvanzada\sciLab\TransRed\datosA01.txt";
    m=read(archivo,nct,3);
    x1=m(:,1);
    y1=m(:,2);
    class_F=m(:,3);
    w=[0;0];
    for i=1:nct
        if class_F(i)==1 then
            plot(x1(i),y1(i),'gre*');
        else
            plot(x1(i),y1(i),'blu*');    
        end
    end
    //Calculate the sign of the hypothesis : g(x):w1*x1+w2*y1
    for i=1:10
        g(i)=sign(w(2)*y1(i)+w(1)*x1(i));
    end
    
    //Iteration del algoritmo de aprendizaje
    ind = find(class_F ~= g); // Find the indices where temp is not equal to f
    iter = 1;
    while ~isempty(ind)
        for i=1:nct
            //operador .* es multiplicación de matrices elemento a elemento
            w(1) = w(1) + class_F(ind(1)).*x1(ind(1)); 
            w(2) = w(2) + class_F(ind(1)).*y1(ind(1));
        end
        //temp = sign(w'*x);
        for i=1:nct
             temp(i)=sign(w(2)*y1(i)+w(1)*x1(i));
        end
        ind = find(temp ~= class_F);
        iter = iter + 1;
        if iter>6000 then
            break;
        end
    end
    printf('\niteraciones: %d.\n',iter);
    x2=linspace(-1,1,100);
    for i=1:100
        y3(i)=-(w(2)/w(1))*x2(i);
    end
    
    plot(x2,y3,'r');
endfunction

