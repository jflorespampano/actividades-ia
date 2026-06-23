# explicacion familia.pl

Archivo con una BC que describe las relaciones familiares.

## Hechos

Si tenemos los siguiente hechos:

```text
ejemplo de relaciones familiares
juan es padre de maria y pedro
luisa es madre de maria
carlos es padre de juan y roberto

```

```pl
% Representaremos así:
% juan es padre de maría
padre(juan, maria).
padre(juan, pedro).
% luisa es madre de maría
madre(luisa, maria).
% carlos es padre de juan y roberto
padre(carlos, juan).
padre(carlos, roberto).
```

## Reglas

Recuede que las variables empiezan con mayuscula.

X es hermano de Y si tienen el mismo padre y no son la misma persona.

```pl
hermano(X, Y) :-
    padre(Z, X),
    padre(Z, Y),
    X \= Y.
```

X es tio de Y si X es hermano de Z y Z es padre de Y

```pl
tio(X, Y) :-
    padre(Z, Y),
    hermano(X, Z).
```
