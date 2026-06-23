# gnu prolog

[sitio gnuprolog](http://www.gprolog.org/)
[descargar](http://www.gprolog.org/#download)
[manual](http://www.gprolog.org/manual/gprolog.pdf)

La consola: 'C:\GNU-Prolog\bin\gprolog.exe'

##  consultas

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

## cargar y ejecutar consultas

### Ejecutar archivo directamente
```bash
# Carga 'mi_programa.pl' y luego ejecuta el objetivo 'mi_consulta.'
gprolog --consult-file mi_programa.pl --query-goal "mi_consulta."

# Nota: para salir del intérprete después de la consulta, puedes usar el flag --no-top-level
gprolog --consult-file mi_programa.pl --query-goal "mi_consulta." --no-top-level
```

### Usando el interprete interactivo
```bash
# 1. Inicia el intérprete
$ gprolog
GNU Prolog 1.4.5 ...
| ?-

# 2. Dentro del intérprete, carga tu archivo (la extensión .pl es común)
| ?- consult('mi_programa.pl').
# o usa el atajo:
| ?- [mi_programa].

# 3. Ejecuta una consulta, por ejemplo, si tu programa define un predicado 'saludo/1'
| ?- saludo(mundo).
Hola mundo
true ? 

# 4. Para salir del intérprete, usa el objetivo `halt.`
| ?- halt.
$
```

Ejemplo:

Carga y consuta
```bash
?- consult('familia.pl').
# o
?- ['familia.pl'].
```

Consultas
```sh
?- hermano(maria, pedro).
yes
```