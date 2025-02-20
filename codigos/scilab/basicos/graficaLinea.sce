x=linspace(0, 100, 100);
w0=3;
w1=0.5;
for i=1:100
    y(i)=w1*x(i)+w0;
end
plot(x,y,'r');
