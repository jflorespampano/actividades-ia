% ejemplo de relaciones familiares en Prolog
% juan es padre de maria y pedro
% luisa es madre de maria
padre(juan, maria).
padre(juan, pedro).
% carlos es padre de juan y roberto
padre(carlos, juan).
padre(carlos, roberto).
madre(luisa, maria).

% reglas
% X es hermano de Y si tienen el mismo padre y no son la misma persona
hermano(X, Y) :-
    padre(Z, X),
    padre(Z, Y),
    X \= Y.

% X es tio de Y si X es hermano de Z y Z es padre de Y
tio(X, Y) :-
    padre(Z, Y),
    hermano(X, Z).
