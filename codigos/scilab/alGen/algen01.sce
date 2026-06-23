//////////////////////////////////////////////////
// octubre 2016 Alejandro Flores
// este programa requiere la ejecución previa del archivo funciones.sci
// longitud del cromosoma 4
// conjnto de elementos de cromosoma {0,1}
// individuos en la población 2
// para la primera generacion probabilidad del elemento 0 >0.5
// probabilidad del elemento 1 <=0.5
// probabilidad de cruza 0.7
// probabilidad de mutación 0.3
// Refrerencia: http://jarroba.com/algoritmos-geneticos-ejemplo/
// Referencia: http://eddyalfaro.galeon.com/geneticos.html 
// Referencia: https://www.nebrija.es/~cmalagon/ia/apuntes/algoritmosgeneticos.pdf
mprintf("Inicio--------->\nGeneracion inicial\n");
//inicializacion
in_n=8; //tamaño de la poblacion
in_p_cruza=0.7;
in_p_mutacion=0.3;

//mostrar funcion
graficaFuncion();
mi=generaIndividuos(in_n);
//iterar generaciones
for i=1:56
    mprintf("Generacion %d\n",i);
    //paso 1 evaluamos los individuos con la funcion de aptitud
    sumatoria_aptitud=0;
    fm=zeros(in_n);
    xm=zeros(in_n);
    for j=1:in_n
        //fm -> funcion evaluada en el valor m(i)
        xm(j)=evaluaFuncion(binario_decimal(mi(j,:)));
        fm(j)=xm(j);
        sumatoria_aptitud=sumatoria_aptitud+fm(j);
    end
    mprintf("Sumatoria de aptitud=%f\n",sumatoria_aptitud);
    //paso 2 aplicamos seleccion
    //calculamos el % de aptitud por individuo
    porcen_aptitud_indiv=zeros(in_n);
    for j=1:in_n
        porcen_aptitud_indiv(j)=fm(j)/sumatoria_aptitud;
    end
    ruleta=seleccion_x_ruleta(mi,porcen_aptitud_indiv);
    //Datos actuales
    mprintf("x (binario),x , aptitud = f(x), probabilidad de cruza\n");    
    disp([mi,xm,fm,porcen_aptitud_indiv]);
    //mprintf("Despues de aplicar selección por ruleta");
    //disp(ruleta);
    //nueva población despues de la seleccion
    mi=ruleta;
    //paso 3 aplicamos cruza
    ya=ones(in_n,1);
    por_cruzar=find(ya==1);
    nn=length(por_cruzar(1,:));
    while nn>=2
        //mprintf("Por cruzar");
        //disp(por_cruzar);
        //selecciona una pareja aleatoria
        p1=modulo(int((rand()*100)),nn)+1;
        p2=modulo(int((rand()*100)),nn)+1;
        while p1==p2
             p2=modulo(int((rand()*100)),in_n)+1;
        end
        //cruzar m(1,:)=v
        [h1,h2]=cruza(mi(p1,:),mi(p2,:));
        m(p1,:)=h1;
        m(p2,:)=h2;
        ya(p1)=0;
        ya(p2)=0;
        por_cruzar=find(ya==1);
        nn=length(por_cruzar(1,:));
        //aplicar mutación 
        //mprintf("Renglon mutado");
        for j=1:in_n
            rm=mutacion(mi(j,:),in_p_mutacion);    
            mi(j,:)=rm;
        end
    end
    //mprintf("Despues de la cruza....");
    //disp(mi);
end


