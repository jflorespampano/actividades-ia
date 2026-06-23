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
