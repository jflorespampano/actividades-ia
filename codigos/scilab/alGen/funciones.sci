//funciones para algoritmos geneticos
function m=generaIndividuos(cuantos)
    m=modulo(int(rand(cuantos,4)*100),2);
endfunction

function [ind1,ind2]=cruza(padre1,padre2)
    corte=modulo(int(rand()*100),3)+1;
    ind1=[padre1(1:corte),padre2(corte+1:4)]
    ind2=[padre2(1:corte),padre1(corte+1:4)]
endfunction

function r=mutacion(individuo,prob_mutar)
    matProv=rand(1,4);
    //matProv=[0.2, 0.8, 0.2, 0.9];
    for i=1:4
        if(matProv(i)<=prob_mutar) then 
            individuo(i)=abs(individuo(i)-1)
        end
    end
    r=individuo
endfunction

function graficaFuncion()
    //mostrar funcion
    x=linspace(0,15,500);
    y=abs((x-5)/2+sin(x));
    plot(x,y);
endfunction

function y=evaluaFuncion(x)
    y=abs((x-5)/2+sin(x));
endfunction

function valor=binario_decimal(b)
    n=length(b)
    valor=0;
    for i=n:-1:1
        valor=valor+b(i)*(2^(n-i));
    end
endfunction


//m=[1,2,3;4,5,6]
//m2=zeros(2,3)
//v=m(1,:)
//m2(1,:)=v
//no funciona revisar
//se busca formar parejas para torneo
function resp=seleccion_x_ruleta(m,pa)
    //crear ruleta
    panterior=0;
    pacumulado=0;
    pacumulado=0;
    for i=1:length(m(:,1))
        pacumulado=pacumulado+pa(i)
        ruleta(i,1)=i;
        ruleta(i,2)=panterior;
        ruleta(i,3)=pacumulado;
        panterior=pacumulado;
    end
    //seleccionados
    seleccionados=zeros(length(m(:,1)),4);
    for i=1:length(m(:,1))
        p=rand();
        pos=0;
        for j=1:length(m(:,1))
            if (p>=ruleta(j,2)) & (p<ruleta(j,3)) then
                pos=j;
                v1=m(j,:);
                seleccionados(i,:)=v1;
                break;
            end       
        end
        //mprintf("\nindice %d\n",j);   
    end
    resp=seleccionados;
endfunction
