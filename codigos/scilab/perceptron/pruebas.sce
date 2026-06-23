function y=linea1(x)
    //y=w1*x1+w0
    y=3*x+0;  
endfunction
function grafica1()
    x=linspace(0,2,20);
    y=x;
    for i=1:1:length(x)
        y(i)=linea1(x(i))
    end
    plot(x,y,'b')
endfunction
grafica1;
