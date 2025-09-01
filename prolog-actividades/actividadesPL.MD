# actividades de prolog

## prolog

Prolog (abreviatura de Programmation en Logique) es un lenguaje de programación lógico diseñado para resolver problemas mediante razonamiento automatizado y manipulación de reglas lógicas. A diferencia de lenguajes imperativos (como Python o Java), en Prolog tú defines qué quieres resolver (no cómo hacerlo). Aquí está su esencia:

### Conceptos Clave

1. Programación Declarativa:

2. Describes hechos y reglas, y el motor de Prolog encuentra soluciones automáticamente.

Ejemplo:

```js
% Hechos
padre(juan, maria).
padre(juan, luis).

% Regla
hermano(X, Y) :- padre(Z, X), padre(Z, Y), X \= Y.
Al preguntar ?- hermano(maria, luis)., Prolog responde true.

```

Ejemplo rutas de un grafo
```js
% Definición de rutas en un grafo
camino(a, b).
camino(b, c).
camino(X, Z) :- camino(X, Y), camino(Y, Z).

?- camino(a, c).  % ¿Hay ruta de 'a' a 'c'? → true
```

3. Unificación y Backtracking:

Prolog prueba todas las combinaciones posibles (backtracking) hasta encontrar soluciones que cumplan las reglas.

4. Sintaxis Basada en Predicados:

5. Todo son relaciones (ej: padre/2, hermano/2).

6. [referencia prolog](https://www.swi-prolog.org/pldoc/man?section=overview)

## swi-prolog

SWI-Prolog es uno de los intérpretes y compiladores más populares y completos para el lenguaje de programación Prolog. Desarrollado activamente desde 1987, es ampliamente utilizado en investigación, educación y aplicaciones industriales gracias a su robustez, bibliotecas extensivas y herramientas integradas.

[Descarga el instalador desde:](www.swi-prolog.org)

## Actividades:

1. instalar swi-prolog apoyate en '1-instalarSwiProlog.pdf'
2. revisa los archivos '3-Introduccion Prolog-2.pdf' y '4-GuiaProlog.pdf'
3. implementa el ejercicio del archivo: '5-ejemploPrologHabilidProg.pdf'
4. revisar en clase los conceptos principales de prolog
5. realiza los ejercicios siguientes:
    * asistente medico
    * gestor de proyectos
    * implementar una red bayesiana
    * ayudante de chef
    * proyecto final del profesor


## referencias

[repositorio de redes bayesianas](https://www.bnlearn.com/bnrepository/)

## entregables

1. ejercicios del punto 5 en GitHub.



