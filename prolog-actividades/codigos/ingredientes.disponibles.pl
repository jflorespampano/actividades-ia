% ingredientes disponibles
% ['/trabajo2025/materialDidactico/progAvanzada-ia/codigos/gnuProlog/ingredientes.disponibles.pl'].
% hay([leche,pan,jamon,queso,lechuga,tomate,aceite]).
hay([leche,pan,jamon,lechuga,tomate,aceite]).

lleva(sopa,[leche,pan]).
lleva(ensalada,[lechuga,tomate,aceite]).
lleva(sandwich,[pan,jamon,queso]).
 
gusta(juan,sopa).
gusta(juan,sandwich).
gusta(maria,ensalada).
gusta(maria,sopa).

% Verifica que todos los elementos de Lista1 estén en Lista2
todos_elementos_en(Lista1, Lista2) :-
    forall(member(X, Lista1), member(X, Lista2)).

hay_ingredientes_para(X) :-
    lleva(X, Ingredientes),
    hay(Disponibles),
    todos_elementos_en(Ingredientes, Disponibles).

% Elementos que están en Lista1 pero NO en Lista2
% findall(Template, Goal, List). Goal=consulta a ejecutar, List=lista resultado
elementos_faltantes(Lista1, Lista2, Faltantes) :-
    findall(X, 
            (member(X, Lista1), \+ member(X, Lista2)), 
            Faltantes).

faltan_ingredientes_para(X, Faltantes) :-
    lleva(X, Ingredientes),
    hay(Disponibles),
    elementos_faltantes(Ingredientes, Disponibles, Faltantes).

% Consultas de ejemplo:
% ?- hay_ingredientes_para(sopa).
% ?- faltan_ingredientes_para(sandwich, Faltantes).