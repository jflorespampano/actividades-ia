## actividad 

Ejercicios en SciLab

1. crear un arreglo de 1 renglon x 4 columnas: a=[1,2,3,4]
2. crear un arreglo de 4 x 1: a=[1;2;3;4]
3. crear un arreglo de 2 x 3: b=[1,2,3;4,5,6]
4. crear un arreglo de 1 x 3 llamado c: c=[1,2,3]
5. crear un aarreglo de 2 x 3 duplicando el arreglo c: repmat(c,2,1)
6. multiplique los arreglos siguientes A[2,3], b[2,3]:

A=
1,2,3
3,4,5

B=
4,5,6
7,8,9

R= No se pueden multiplicar directamente, sin embargo si se puede A'*B

7. Multiplique el arrglo a por el escalar 2: A*2
8. Sume 1 a cada elmento del arreglo B: B+1
9. Genere un conjunto de trabajo de 20 puntos aleatorios clasificados en 2 clases.
10. crear los arreglos A=[1,2,3,4,5,6], b=[1,1,3,4,5,9]
11. pruebe las sentencias: "find(A~=B)" Y "find(A==B)", dedezca su funcionamiento.
12. prueba el archivo "perceptronOR2022.sce" que clasifica las salidas del or

13. El siguiente código genera un conjunto de 20 datos clasificcados en 2 clases y los grafica, pruebelo y expliquelo en una presentación ppt y convierta a pdf. 

```m
nct=20; //tamaño del conjunto de trabajo
x=2*rand(2,nct)-1; //me da un conjunto de valores + y - aleatorios
x1=x(1,:);//Arreglo x1 contiene coordenadas x
y1=x(2,:);//Arreglo y1 contiene coordenadas y
plot(x1,y1,'*');

//Graficamos una linea arbitraria y-2x=0 f(x): y=2x
//Salvamos los coheficientes de x y y en el arreglo F
F=[1;-2];
//la función hipotesis es g(x,y)=w1*x+w2*y 
//pesos iniciales son w1=0 and w2=0
w=[0;0];

//mostramos área de trabajo para fines visuaes solamente
x2=linspace(-1,1,100);
for i=1:100
    y2(i)=2*x2(i);
end
plot(x2,y2,'r') //trazamos una línea roja

//Clasificamos los puntos a la derecha e izquierda de la linea
//los puntos tienen la misma x, solo hay que calcular la y de la recta
//y la y del punto y restar,
//clasificamos segun el resultado
for i=1:nct
    //y del punto: y=2*x(1) y la y de la recta: y1(i)
    l(i)=-F(2)*x1(i)-y1(i);//l(i)=F(2)*y1(i)+F(1)*x1(i);
    class_F(i)=sign(l(i));  
end

for i=1:nct
        if class_F(i)==1 then
            plot(x1(i),y1(i),'gre*');
        else
            plot(x1(i),y1(i),'blu*');    
        end
end
```

14. Pruebe el archivo persimple_cn_GenAleat_de_CTok.sce

Expliquelo en una presentacion ppt y convierta a pdf

Entregaables:
1. Archivo pdf con el código que genera 20 puntos clasificados.
2. Funcionamiento explicado del archivo "persimple_cn_GenAleat_de_CTok.sce"

Suba ambos pdf a su repositorio y avie al profesor para ser evaluados.