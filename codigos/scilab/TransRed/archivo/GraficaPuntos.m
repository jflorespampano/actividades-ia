function [resp]=GraficaPuntos(Xmas, Xmenos)
%Esta funcion grafica los conjuntos de datos
% Xmas y Xmenos, Jafh regresa un 1
%grafica  el primer conjunto de datos
i=0;
for i=1:length(Xmas)
   plot(Xmas(i,1),Xmas(i,2),'bx','LineWidth',4);
end
%grafica el segundo conjunto de datos
for i=1:length(Xmenos)
   plot(Xmenos(i,1),Xmenos(i,2),'kx','LineWidth',4);
end
resp=1;

