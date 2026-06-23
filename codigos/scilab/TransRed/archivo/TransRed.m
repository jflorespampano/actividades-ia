function [vsopXmas, vsopXmenos, Tiempo]=TransRed(Xmas,Xmenos,cuantos,idEntrena,figura,txtTpo)
% este archivo es llamado desde preprocesa.m
% jafh: Recibe como entrada los dos conjuntos de trabajo y el numero
% de vectores de soporte solicitados, devuelve los vectores de soporte
% la funcion de mapeo utilizada es: fi(u)=(u1^2,sqrt(2*u1*u2),u2^2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(figura)
hold on
%cla
%grid;
title('En amarillo los vectores de entrenamiento segun Trans Red');
%xlabel('azul clase 1, negro clase 2');

fprintf('\nIniciando transRed ');

%resp=GraficaPuntos(Xmas, Xmenos);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcular el centro de la hiperesfera
% =  fi(xc)=1/N * Sumatoria(fi(xi))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TiempoInicial=cputime;
hCXmas=[0 0 0];
hCXmenos=[0 0 0];
hCXmas=hiperCentro(Xmas);
hCXmenos=hiperCentro(Xmenos);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcular d+-, la distancia entre los centros de las esferas
%dmasmenos^2=abs(fi(xc+)-fi(xc-))=K(xc+,xc+)-2K(xc+,xc-)+K(xc-,xc-)
% ademas K(xc+,xc-)=1/((N-)(N+))*Sumatoria(Sumatoria(K(xi,xj)))
%la funcion Kdexcixcj, realiza lo anterior
temporal=Kdexcixcj(Xmas,Xmas)-2*Kdexcixcj(Xmas,Xmenos)+Kdexcixcj(Xmenos,Xmenos);
dmasmenos=sqrt(temporal);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%centro de la esfera rmas en dos dimensiones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cmas=[0 0];
for i=1:length(Xmas)
   Cmas(1)=Cmas(1)+Xmas(i,1);
   Cmas(2)=Cmas(2)+Xmas(i,2);
end
Cmas(1)=Cmas(1) / length(Xmas);
Cmas(2)=Cmas(2) / length(Xmas);
%graficar el centro de la esfera
%plot(Cmas(1),Cmas(2),'k+','LineWidth',4)
%calcular el radio de la esfera para Xmas
rmas=0;
aux=0;
for i=1:length(Xmas)
   aux1=Cmas(1)*Cmas(1)+Cmas(2)*Cmas(2);
   aux2=-2*(Cmas(1)*Xmas(i,1)+Cmas(2)*Xmas(i,2));
   aux3=Xmas(i,1)*Xmas(i,1)+Xmas(i,2)*Xmas(i,2);
   aux=aux1+aux2+aux3;
   if aux>rmas
      rmas=aux;
   end
end
rmas=sqrt(rmas);
%poner el circulo para Smas
a=0;
b=0;
for i=1:360
   a=rmas*sin(i);
   b=rmas*cos(i);
   plot(Cmas(1)+b,Cmas(2)+a,'y.','LineWidth',1)
end
%centro de la esfera Xmenos
Cmenos=[0 0];
for i=1:length(Xmenos)
   Cmenos(1)=Cmenos(1)+Xmenos(i,1);
   Cmenos(2)=Cmenos(2)+Xmenos(i,2);
end
Cmenos(1)=Cmenos(1) / length(Xmas);
Cmenos(2)=Cmenos(2) / length(Xmas);
%graficar el centro de la esfera
%plot(Cmenos(1),Cmenos(2),'k+','LineWidth',4)
%calcular el radio de la esfera para Xmenos
rmenos=0;
aux=0;
for i=1:length(Xmas)
   aux1=Cmenos(1)*Cmenos(1)+Cmenos(2)*Cmenos(2);
   aux2=-2*(Cmenos(1)*Xmenos(i,1)+Cmenos(2)*Xmenos(i,2));
   aux3=Xmenos(i,1)*Xmenos(i,1)+Xmenos(i,2)*Xmenos(i,2);
   aux=aux1+aux2+aux3;
   if aux>rmenos
      rmenos=aux;
   end
end
rmenos=sqrt(rmenos);
%poner el circulo para Smenos
a=0;
b=0;
for i=1:360
   a=rmenos*sin(i);
   b=rmenos*cos(i);
   plot(Cmenos(1)+b,Cmenos(2)+a,'y.','LineWidth',1)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcular el radio de las hiperesferas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rhXmas=0;
for i=1:length(Xmas)
   aux=kernel(Cmas,Cmas)-2*kernel(Cmas,Xmas(i,:))+kernel(Xmas(i,:),Xmas(i,:));
   if aux>rhXmas
      rhXmas=aux;
   end
end
rhXmas=sqrt(rhXmas);
% para la hiperesfera Xmenos
rhXmenos=0;
for i=1:length(Xmenos)
   aux=kernel(Cmenos,Cmenos)-2*kernel(Cmenos,Xmenos(i,:))+kernel(Xmenos(i,:),Xmenos(i,:));
   if aux>rhXmenos
      rhXmenos=aux;
   end
end
rhXmenos=sqrt(rhXmenos);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcular m+, m-, la distancia entre el plano y el 
%centro de las calses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mmas=(dmasmenos + (rhXmas - rhXmenos)) / 2;
%Mmas=(dmasmenos)/2;
Mmenos=dmasmenos - Mmas;
%calculando las distancias de los vectores Xmas al hiperplano
distXmas=zeros(length(Xmas),1);
dmxi=zeros(length(Xmas),1);
%b+0= (K(xc+, xc+)-K(xc+,xc-))/d+-
bias=(Kdexcixcj(Xmas,Xmas)-Kdexcixcj(Xmas,Xmenos))/dmasmenos;
% la distancia a este plano se puede escribir como
for i=1:length(Xmas)
   %d de M+<->x de a
   distXmas(i)=(1/dmasmenos*(kernel(Cmas,Xmas(i,:))-kernel(Cmenos,Xmas(i,:))))+bias;
   aux1=distXmas(i)-Mmas;
   %calculando la norma
   dmxi(i)=sqrt(aux1*aux1);
end
%ordenar los resultados
Maux1=Xmas;
[Y1, I]=sort(dmxi);
for i=1:length(I)
   dmxi(I(i));
   Maux1(i,:)=Xmas(I(i),:);
end

%los primeros de la lista seran el primer conjunto de entrenamiento
%
%calculando la distancia de los vectores Xmenos al hiperplano
distXmenos=zeros(length(Xmenos),1);
dmxi2=zeros(length(Xmenos),1);
%bias es el misnmo
for i=1:length(Xmas)
   distXmenos(i)=(1/dmasmenos*(kernel(Cmas,Xmenos(i,:))-kernel(Cmenos,Xmenos(i,:))))+bias;
   aux1=distXmenos(i)-Mmenos;
   %calculando la norma
   dmxi2(i)=sqrt(aux1*aux1);
end
%ordenar los resultados
Maux2=Xmenos;
[Y1, I]=sort(dmxi2);
for i=1:length(I)
   dmxi2(I(i));
   Maux2(i,:)=Xmenos(I(i),:);
end
%esto a veces
aveces=1;
if (aveces==1)
	Maux=Maux2;
	l=length(Maux2);
	for i=1:l
   	Maux(i,:)=Maux2((l+1)-i,:);
	end
   Maux2=Maux;
end
%hasta aqui a veces
vAux=[1:cuantos; 1:cuantos];
vsopXmas=vAux';
vsopXmenos=vAux';
TiempoFinal=cputime;
Tiempo=TiempoFinal-TiempoInicial;
fprintf('\nTiempo en TransRed %3.2f',Tiempo);
set (txtTpo,'String',Tiempo)
%vectores de entrenamiento
for i=1:cuantos
   %plot(Maux1(length(Maux1)-i,1),Maux1(length(Maux1)-i,2),'r*','LineWidth',4);
   plot(Maux1(i,1),Maux1(i,2),'y*','LineWidth',4);
   vsopXmas(i,1)=Maux1(i,1);
   vsopXmas(i,2)=Maux1(i,2);
   %plot(Maux2(length(Maux2)-i,1),Maux2(length(Maux2)-i,2),'rx','LineWidth',4);
   plot(Maux2(i,1),Maux2(i,2),'yx','LineWidth',4);
   vsopXmenos(i,1)=Maux2(i,1);
   vsopXmenos(i,2)=Maux2(i,2);
end
hold off
set (idEntrena,'Enable','on') %activa opcion del menu de entrena
%Fin de TransRed