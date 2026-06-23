/*
este codigo fue provado con SWI-Prolog, al digitar una opcion DEBE de poner un punto despues
y enter
*/

/* pausa <- detiene la ejecucion del programa hasta que se pulse una tecla */
pausa :- nl,write('Pulsa <return> para continuar ').
%,skip(10).

/* borraPantalla <- borra la pantalla */
borraPantalla :- borraLinea(25).
borraLinea(1) :- !,nl.
borraLinea(N) :- nl,N1 is N-1,borraLinea(N1).

/*Escribe caracteres*/
escribe([]).
escribe([X|Y]):-put(X),
escribe(Y).

%-------------------------Muestra mensaje de error---------------------------------
error:-
borraPantalla,
escribe("No escribio un numero"), nl,
escribe("O el numero escrito no esta en el rango del menu"),
pausa.

%-------------------------Mensaje de Salida---------------------------------
% se puede sustituir escribe por write
salida:-
borraPantalla,
write("Gracias por usar el menu, hasta luego!"),nl,
escribe("|---------------------------------------------------|"),nl,
escribe("|--Universidad Latina de Costa Rica--|"),nl,
escribe("|-Facultad de Ingenieria en Sistemas-|"),nl,
escribe("|--------------Programacion IV--------------|"),nl,
escribe("|-------Eduardo Gonzalez Chinchilla-----|"),nl,
pausa,
halt.



%-------------------------Manejo de opciones Menu Principal---------------------------------
opciones(X):-
write("x es 1?"),
write(X =:= 1),
(
    (X =:= 1) -> write("Opcion 1"),nl,pausa
    ;
    (X =:= 2) -> write("Opcion 2"),nl,pausa
    ;
    (X =:= 3) -> write("Opcion 3"),nl,pausa
    ;
    (X =:= 4) -> salida
    ;
    error
).

%-------------------------Menu Principal---------------------------------

menu:-
write("-----------Menu principal--------------"),nl,
write("Digite su opcion:"),nl,
tab(10),write("1) Opcion 1"),nl,
tab(10),write("2) Opcion 2"),nl,
tab(10),write("3) Opcion 3"),nl,
tab(10),write("4) Salir"),nl,
write("Su opcion es: "), read(X),
opciones(X),
menu.

%----------------Carga el Menu Principal------------------
%?-menu.
