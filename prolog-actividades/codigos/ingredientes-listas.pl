% Prog avz. ago 2023 jflores
% Menu de un restaurante donde, se maneja un conjunto de hechos:
% 1 los ingredientes que hay en existencia,
% 2 tambien que lleva una comida para ser preparada,
% Tambien un conjunto de reglas:
% Una regla que me indique si no puedo coninar un platillo por falta de
% ingredientes.
% Una regla que me indique si hay todo lo necesario para un platillo
% Una regla que me indique que ingredientes hay en existencia
% Una regla que me indique cuantos ingredientes lleva un platillo
% Una regla que me indique la lista de ingredientes de un platillo.
%

% ***hechos***
hay(limon).
hay(lechuga).
hay(papa).
hay(pasta).
hay(mantequilla).
lleva(pure,papa).
lleva(pure,mantequilla).
lleva(sopa,pasta).
lleva(sopa,cebolla).
lleva(sopa,cilantro).

% ***reglas***
%ingredientes existentes con lista
que_hay(LI):-findall(I,hay(I),LI),write('hay: '),write(LI).
% ingredientes que faltan para un platillo
falta(P,X):-lleva(P,X),\+hay(X).
lista_faltantes(P):-findall(I,falta(P,I),LF),write(LF).
no_puedo_cocinar(P):-falta(P,X),write('falta '),write(X).

%no_puedo_cocinar(P):-lleva(P,X), \+hay(X).
% Hay todos los ingredientes para cocinar un platillo?
hay_todo(P,X):-not(falta(P,X)).
hay_todo_ver2(P):-not(falta(P,_)).

%  ***usando listas***
%Que ingredientes hay en existencia
que_hay:-findall(Ingrediente,hay(Ingrediente),Lista),write('hay estos ingredientes: '),write(Lista).
%cuantos ingredientes lleva X
cuantos_ingredientes_lleva(P,Cantidad):-findall(Ingrediente,lleva(P,Ingrediente),Ingredientes), length(Ingredientes,Cantidad), write('lleva: '),write(Cantidad),write(' ingredientes').
%que ingredientes lleva P
lista_ingredientes(P,Ingredientes):-findall(Ingrediente,lleva(P,Ingrediente),Ingredientes).
%que ingredientes necesitamos para todas las comida
ingredientes_todo_el_menu(Lista):-findall(Ing,lleva(_,Ing),Lista).
