padre(juan, maria).
padre(juan, pedro).
madre(luisa, maria).

hermano(X, Y) :-
    padre(Z, X),
    padre(Z, Y),
    X \= Y.