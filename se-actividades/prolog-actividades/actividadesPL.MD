# actividades de prolog

## prolog

Prolog (abreviatura de Programmation en Logique) es un lenguaje de programación lógico diseñado para resolver problemas mediante razonamiento automatizado y manipulación de reglas lógicas. A diferencia de lenguajes imperativos (como Python o Java), en Prolog tú defines qué quieres resolver (no cómo hacerlo).

En la carpeta `ia\sistemasExpertos\pdf` estudia el archivo:
* 1-sistemasExpertosBasadosEnReglas(referencia).pdf

En la subcarpeta de esta carpeta `prolog-actividades/pdf` Revisa los archivos:
* '1-instalarSwiProlog.pdf'
* '3-Introduccion Prolog-2.pdf'
* '4-GuiaProlog.pdf'
* Realiza el ejemplo: 'ejemploBCenprolog.pdf'
* Realiza el ejemplo: '5-ejemploPrologHabilidProg.pdf'

## Introducción

### Conceptos

#### Base de conocimiento

Es un conjunto de hechos y reglas que describen información sobre un dominio específico. Prolog usa esta base para hacer inferencias y responder preguntas

### Hechos (Facts)

Los hechos son afirmaciones verdaderas e incondicionales. Se definen con un predicado seguido de argumentos entre paréntesis y terminan con punto (.).

Ejemplo:
```pl
% Hechos sobre relaciones familiares
% juan es padre de maria
padre(juan, ana).
padre(juan, carlos).
padre(luis, juan).
madre(maria, ana).
% maria en madre de carlos
madre(maria, carlos).

% Hechos sobre mascotas
% perro es un animal
animal(perro).
animal(gato).
mascota(ana, perro).
mascota(carlos, gato).

% Hechos con multiples argumentos
% juan estudia programación
estudia(juan, programacion).
estudia(ana, matematicas).
```

#### Reglas (Rules)
Las reglas definen relaciones condicionales. Tienen una cabeza (conclusión) y un cuerpo (condiciones) separados por :-.

Ejemplos:
```pl
% Regla: X es abuelo de Y si es padre de alguien que es padre de Y
abuelo(X, Y) :-
    padre(X, Z),
    padre(Z, Y).

% Regla: X es madre de Y si es mujer y padre de Y
madre(X, Y) :-
    mujer(X),
    padre(X, Y).

% Regla con multiples condiciones
hermano(X, Y) :-
    padre(P, X),
    padre(P, Y),
    madre(M, X),
    madre(M, Y),
    X \= Y.  % X y Y son diferentes

% Regla: X y Y son familiares si comparten un padre
familiar(X, Y) :-
    padre(P, X),
    padre(P, Y),
    X \= Y.
```

## Cracaterísticas de Prolog:

1. Programación Declarativa:
2. Describes hechos y reglas, y el motor de Prolog encuentra soluciones automáticamente.
3. Unificación y Backtracking: Prolog prueba todas las combinaciones posibles (backtracking) hasta encontrar soluciones que cumplan las reglas.
4. Sintaxis Basada en Predicados:
5. Todo son relaciones (ej: padre/2, hermano/2).
6. [referencia prolog](https://www.swi-prolog.org/pldoc/man?section=overview)

### Ejemplo de base de conocimiento(BC):

```pl
% Hechos
% juan es padre de maria
padre(juan, maria).
% juan es padre de luis
padre(juan, luis).

% Regla
% X , Y son hermanos si (Z es padre de Y) y (Z es padre de X) y el valor de X es diferente del de Y
hermano(X, Y) :- padre(Z, X), padre(Z, Y), X \= Y.
```

### Ejemplo de consultas a la BC

En una cosola de swi-prolog haz la siguiente consulta:
```bash
# Al preguntar en la consola de Swi-Prolog
hermano(maria, luis).
# Prolog responde true.
```

### Ejemplo rutas de un grafo
```pl
% Definición de rutas en un grafo
camino(a, b).
camino(b, c).
camino(X, Z) :- camino(X, Y), camino(Y, Z).

```

```bash
?- camino(a, c).  % ¿Hay ruta de 'a' a 'c'? → true
```

## swi-prolog

SWI-Prolog es uno de los intérpretes más populares y completos para el lenguaje de programación Prolog. Desarrollado activamente desde 1987, es ampliamente utilizado en investigación, educación y aplicaciones industriales gracias a su robustez, bibliotecas extensivas y herramientas integradas.

[Descarga el instalador desde:](www.swi-prolog.org)

## Ejemplo relaciones de familia

1. revisa la explicación del archivo `codigos/familia.md`
2. abre swi-prolog, te llevar a la cosola `?-`
3. para hacer consultas, debes cargar una base de cponocimiento (archivo .pl) en memoria, puedes hacerlo de 3 formas.
   1. clic en el menu: 'file/consult' buscar el archivo a consultar.
   2. en la consola escribe `consult('actividades-ia\se-actividades\prolog-actividades\codigos\familia.pl')`
   3. en la consola escribe `[actividades-ia\se-actividades\prolog-actividades\codigos\familia.pl]`
4. en VSCode, carga el archivo: `actividades-ia\se-actividades\prolog-actividades\codigos\familia.pl`, ahora puedes editarlo.
5. si modificate el archivo y quieres volver a cargarlo, en la consola de prolog ecribe: `make.` 
6. en la consola, realiza las consultas
   1. ¿de quien es padre juan?: `padre(juan,X).`, responderá: `X = maria ;` presiona tecla tab y mostrará: `X = pedro.`, cuando veas el punto, ha terminado.
   2. ¿quien es tio de pedro?: `tio(X,pedro).`, responderá: `X = roberto.`

## Ejemplo calificaciones con listas

Para representar un conjunto de hechos y reglas para manejar las calificaciones de estudiantes en diferentes temas de la materia de programación, donde los temas sonprogramación: (funcional, logico, objetos), usando listas, si la lista tiene mas de una nota significa que recurso la materia, ejmplo:

Hechos
```pl
% pepito, saco 2 en programacion funcional, luego recurso y saco 9
notas(pepito, funcional, [2, 9]).
```

Reglas
```pl
% buscamos ultima nota del estudiante
ultimaNota(Estudiante, Tema, Nota):-
  notas(Estudiante, Tema, Notas),
  last(Notas, Nota).

% buscamos cuantas veces curso la materia
vecesQueCurso(Estudiante, Tema, Veces):-
  notas(Estudiante, Tema, Notas),
  length(Notas, Veces).

% Contar elementos menores que 6
contar_menores_6(Lista, Count) :-
    findall(X, (member(X, Lista), X < 6), Menores),
    length(Menores, Count).

% veces que reprobo
veces_que_reprobo(Estudiante, Tema, Veces):-notas(Estudiante,Tema,Lista), contar_menores_6(Lista, Veces).
```

1. abre swi-prolog, te llevar a la cosola `?-`
2. Carga el archivo en memoria el archivo .pl:
   * en la consola escribe `[actividades-ia\se-actividades\prolog-actividades\codigos\calificaciones_cn_listas.pl]`
3. en VSCode, carga el archivo: `actividades-ia\se-actividades\prolog-actividades\codigos\calificaciones_cn_listas.pl`, ahora puedes editarlo.
4. si modificate el archivo y quieres volver a cargarlo, en la consola ecribe: `make.` 
5. en la consola, realiza las consultas
   1. ¿Que calificaciones ha obtenido pepito en funcional?: `notas(pepito, funcional, L).`, responderá: `L = [2, 9].`
   2. ¿Cuantas veces ha cursado peito funcional?: `vecesQueCurso(pepito, funcional, V).`, reponderá: `V = 2.`
   3. ¿Cuantas veces reprobo tito, funcional?: `veces_que_reprobo(tito, funcional, Veces).`, reponderá: `V = 2.`

## Tau prolog

En esta misma carpeta, en la subcarpeta `tauprolog`:
    * revisa el archivo `tauProlog.md`

## Go/Ichiban

De la carpeta `\ia\GoLang` estudia los archivos
    * `introduccionGo.md`
    * `prologconGo.md`

## Actividades:

1. revisar en clase los conceptos principales de prolog
2. instalar swi-prolog apoyate en '1-instalarSwiProlog.pdf'
3. implementa los ejercicios: 'ejemploBCenprolog.pdf', '5-ejemploPrologHabilidProg.pdf'
4. realiza los ejercicios siguientes:
    * asistente medico
    * gestor de proyectos
    * implementar una red bayesiana
    * ayudante de chef
    * proyecto final del profesor
    * programa el asistente médico en Go con Ichiban
    * programa el asistente médico en TauProlog
    * programa el gestor de proyectos en Go con Ichiban
    * programa el gestor de proyectos en Tauprolog


## entregables

En tu repositorio GitHub, en una subcarpeta llamada prolog de la carpera se, agrega

1. ejercicios de los puntos 3,4 en GitHub.
