% Declarar predicados como dinámicos
% No es necesario y no lo soporta IchibanProlog, pero se incluye para ilustrar la idea de hechos dinámicos.
% :- dynamic padre/2.
% :- dynamic madre/2.
% :- dynamic edad/2.

%
% Hechos sobre relaciones familiares
padre(juan, maria).
padre(juan, carlos).
padre(carlos, luis).
madre(ana, maria).
madre(ana, carlos).
madre(luisa, luis).

% Regla: abuelo(X, Y) si X es padre/madre de Z y Z es padre/madre de Y
abuelo(X, Y) :- padre(X, Z), padre(Z, Y).
abuelo(X, Y) :- padre(X, Z), madre(Z, Y).
abuelo(X, Y) :- madre(X, Z), padre(Z, Y).
abuelo(X, Y) :- madre(X, Z), madre(Z, Y).