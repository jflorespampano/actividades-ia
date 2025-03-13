//crea archivo de trabajo
//x=2*rand(2,20)-1;
np=20;
x=round(rand(2,np,'uniform')*100);
x1=x(1,:);//Arreglo x1 con las coordenadas x
y1=x(2,:);//Arreglo y1 con las coordenadas y
//plot(x1,y1,'b*');

//Trazamos una linea en y-x=0 f(x)=x
//coheficientes en F
F=[1;-1];

x2=linspace(0,100,100);
for i=1:100
    y2(i)=x2(i);
end

plot(x2,y2,'r');


//Clasificamos los puntos a la izq o der de la linea
for i=1:np
    l(i)=F(2)*y1(i)+F(1)*x1(i);
    class_F(i)=sign(l(i));
end

for i=1:np
    if(class_F(i)==1)
        plot(x1(i),y1(i),'r*')
     else
         plot(x1(i),y1(i),'b*')
    end
end

M=[x1',y1',class_F];
write('datos1.txt',M);
