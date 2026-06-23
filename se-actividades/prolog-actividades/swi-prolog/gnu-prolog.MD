# gnu prolog

[sitio gnuprolog](http://www.gprolog.org/)

instala una consola: 'C:\GNU-Prolog\bin\gprolog.exe'

##  cosnola gnu prolog

base de conocimiento: familia.pl
```prolog
padre(juan, maria).
padre(juan, pedro).
madre(luisa, maria).

hermano(X, Y) :-
    padre(Z, X),
    padre(Z, Y),
    X \= Y.
```

Carga y consuta
```prolog
?- consult('familia.pl').
# o
?- ['familia.pl'].
```

Consultas
```sh
?- hermano(maria, pedro).
yes
```