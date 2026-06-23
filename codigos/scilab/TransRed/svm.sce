//SVM JAFH - feb 2016
//para este código:
//SE REQUIERE EJECUTAR funcionesSVM.sce ANTES DE TRABAJAR CON ESTE CÓDIGO
//Buscar los multiplicadores de Lagrange para clasificar el conjunto de puntos
//Entrada conjunto de vectores Xi y un conjunto de etiquetas Yi para X
//Salida: Multiplicadores de lagrange para los vectores de X
//Basado en lña implementación de [Gun98]
//adaptación: Jesús Alejandro Flores Hernández
///////////////////////////////////////////////////////////////////////////////
archivo="C:\trabajo\gestoriaLI\materialYcursos\progAvanzada\sciLab\TransRed\datos01.txt";
[X,Y,Xmas,Xmenos]=leeConjuntoTrabajo(archivo);


//intercala los vectores de la clase 1 y -1
nc1=length(find(Y == 1));
ncm1=length(find(Y == -1));
ni=min(nc1,ncm1);
for i=2:2:ni
   j=ncm1+i;
   Xaux=X(j,:);
   Yaux=Y(j);
   X(j,:)=X(i,:);
   Y(j)=Y(i);
   X(i,:)=Xaux;
   Y(i)=Yaux;
end
//numero de datos de entrebnamiento}
n=size (X,1);
//Establece el tamaño de los subproblemas (chunking)
B=4;
//tamaño del iincremento de cada subproblema
dB=2;
C=%inf; //infinito
c=5; // valor de tolerancia
k=2; //grado del polinomio //no usado ahora

epsilon=0.001;
alfa=zeros(n,1);
//ciclo de trabajo
ban=1;
ciclos=0;

///////// en revision//////////////////////////////////////////////////////////
//while (ban == 1)
   ciclos=ciclos+1;
   printf('\nIteración número %d.\n',ciclos);
   // Construye el hessiano para el subproblema de Programación Cuadrática.
   //recordadndo que lagrangiano dual es (si a =alfa)
   //Suma(ai)-1/2*Suma(ai*aj*yi*yj*K(xi*xj) con
   //Hesiano Hij=yi*yj*K(xi*xj)
   Hm=zeros(B,B);
   for i=1:B
      for j=1:B
         Hm(i,j)=Y(i)*Y(j)*mi_kernel(X(i,:),X(j,:));//svkernela(ker,p,X(i,:),X(j,:));
      end
   end
   Hm = Hm+ (1e-10) * eye(length(Hm(:,1)),length(Hm(:,1)));//eye(size(Hm)); // Cantidad de regularización por si está mal condicionado. 
   // Estas constantes son para hacer positivo el término sum(alfas).
   c=-ones(B,1);
   // Establece las cotas de los multiplicadores de Lagrange.
   lagransup=C*ones(B,1);
   lagraninf=zeros(B,1);
   // Este el punto de arranque del método.
   x0=zeros(B,1);
   // Establece el número de restricciones de igualdad.
   nresigual=1;
   // Establece la restricción de igualdad Aeq(x)=beq.
   Ya=zeros(B,1);
   for i=1:B
      Ya(i)=Y(i);
   end
   Aeq=Ya';
   beq=0;
   // Establece la restricción de desigualdad A(x)<=b0.
   A=-eye(B,B);
   b0=zeros(B,1);
   // Resuelve el subproblema de Programación Cuadrática.
   //en SCILAB
   A
   Aeq
   A2=[Aeq;A];
   b2=[beq;b0];
   [malfa bias how]=qpsolve(Hm, c, A2, b2, lagraninf, lagransup, 1);
   
   //*************************************************aqui me quede************************************
   //**************************************************************************************************
   // Modifica las alfas para no tener menores a cero.
   for i=1:length(malfa)
      if (malfa(i) < 0)
         malfa(i)=0;
      end
   end
   // Copia los valores encontrados en el subproblema al vector de alfas total.
   for i=1:B
      alfa(i)=malfa(i);
   end
   // Extrae los Vectores de Soporte.
   posVS=find(malfa > epsilon);
   nvs=length(posVS);
   pvs=100*nvs/n;
   printf('\nVectores de Soporte: %d (%3.2f%%).\n',nvs,pvs);
   for i=1:nvs
       printf('VS[%2d]: (%3.2f,%3.2f). alfa: %3.10f. clase: %2d.\n',posVS(i),X(posVS(i),1),X(posVS(i),2),malfa(posVS(i)),Y(posVS(i)));
   end
   // Calcula el sesgo óptimo.
   svj = find( malfa > epsilon & malfa < (C - epsilon));
   if length(svj) > 0
      b =  (1/length(svj))*sum(Y(svj)-Hm(svj,posVS)*malfa(posVS).*Y(svj));
   else 
      printf('\nNo se encontraron Vectores de Soporte: imposible calcular el sesgo.\n');
      b=0;
   end
   // Cálculo de la F.O. y margen...
   w2 = -0.5*(malfa'*Hm*malfa)+sum(malfa);
   printf('Función Objetivo Optima: %f\n',w2);

   // Visualización en caso necesario...
   // Calcula los valores de g(i)*Y(i) para todos los vectores.
   g=zeros(n,1);
   G=zeros(n,1);
   for i=1:length(Y)
      for s=1:length(Y)
         g(i)=g(i)+alfa(s)*Y(s)*mi_kernel(X(s,:),X(i,:));
      end
      G(i)=(g(i)+b)*Y(i);
   end
   // Determina cuales de los vectores saldrá del subproblema.
   enmargen=[];
   sal=[];
   salen=0;
   for j=1:B
      if (G(j) > 1+epsilon)
         sal=[sal; G(j) j];
         salen=salen+1;
      end
   end
   // Determina cuales de los vectores entrarán al subproblema.
   ent=[];
   ban=0;
   entran=0;
   for j=B+1:n
      if (alfa(j) == 0 & G(j) < algo+epsilon)
         ent=[ent; G(j) j];
         entran=entran+1;
         ban=1;
      end
      if (alfa(j) == C & G(j) > 1)
         ent=[ent; G(j) j];
         entran=entran+1;
         ban=1;
      end
      if (alfa(j) > 0 & alfa(j) < C & G(j) ~= 1)
         ent=[ent; G(j) j];
         entran=entran+1;
         ban=1;
      end
      if (G(j) >= 0 & G(j) <= 1+epsilon)
         enmargen=[enmargen; G(j) j];
      end
   end
   // Si hay vector(es) candidato(s) a entrar se hará(n) el(los) intercambio(s).
   if (ban == 1)
      // Ordena los arreglos de g(i)*Y(i) para tomarlos en el orden adecuado.
      sal=sortrows(sal);
      ent=sortrows(ent);
      // Determina cuantos cambios se van a hacer.
      cambios=min(entran,salen);
      if (cambios == 0)
         if (salen == 0)
            B=B+dB;
            printf('Aumenta el tamaño del subproblema a %d.\n',B);
         else
             ban=0;
         end
      else
         // Efectúa los cambios necesarios.
         printf('Se efectuarán %d cambios.\n',cambios);
         contae=1;
         contas=salen;
         while (cambios > 0)
            Xaux=X(ent(contae,2),:);
            Yaux=Y(ent(contae,2));
            X(ent(contae,2),:)=X(sal(contas,2),:);
            Y(ent(contae,2))=Y(sal(contas,2));
            X(sal(contas,2),:)=Xaux;
            Y(sal(contas,2))=Yaux;
            contae=contae+1;
            contas=contas-1;
            cambios=cambios-1;
         end
      end
   end
//end
alfa
///////// fin de enrevision////////////////////////////////////////////////////
graficaRegion(alfa,X,Y,b)
