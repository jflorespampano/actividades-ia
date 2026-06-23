function [fixc]=hiperCentro(X)
fixc=[0 0 0];
temp=[0 0 0];
for i=1:length(X)
   %fi=[0 0 0];
	%fi(1)=X(i,1)^2;
	%fi(2)=sqrt(2*X(i,1)*X(i,2));
	%fi(3)=X(i,2)^2;
   temp=temp+fi(X(i,:));
end
fixc(1)=temp(1)/length(X);
fixc(2)=temp(2)/length(X);
fixc(3)=temp(3)/length(X);
