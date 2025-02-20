m=read("datos1.txt",20,3)
x=m(:,1)
y=m(:,2)
clase=m(:,3)
for i=1:20
    if(clase(i)==1)
        plot(x(i),y(i),'r*')
     else
         plot(x(i),y(i),'b*')
    end
end
