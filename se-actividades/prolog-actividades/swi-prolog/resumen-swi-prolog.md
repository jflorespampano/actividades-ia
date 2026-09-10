# Swi-prolog

En **SWI-Prolog**, una base de conocimiento se construye  mediante **hechos** y **reglas**, y se consulta mediante **preguntas (queries)**. La idea central es describir conocimiento de forma lógica y dejar que Prolog haga las inferencias.

## 1. Estructura básica

Una base de conocimiento puede verse así:

```prolog
% HECHOS
padre(juan, pedro).
padre(juan, maria).
madre(ana, pedro).

% REGLAS
progenitor(X, Y) :- padre(X, Y).
progenitor(X, Y) :- madre(X, Y).
```

Aquí tenemos dos tipos de información:

* **Hechos:** información que consideramos verdadera.
* **Reglas:** relaciones que se pueden deducir a partir de los hechos u otras reglas.

---
## Crear base de conocimiento (BC)

* Puedes crear el archivo usando VSCode
* Tambien puedes crear el archivo en swi-prolog
    1. Abre swi-prolog
    2. Abre su editor de texto seleccionando en el menu(`File->New`), selecciona carpeta y nombre de archivo.

**Crea un archivo con nombre `ejemplo.pl`**

# 2. Hechos

Un hecho representa una afirmación, por ejemplo.

```prolog
persona(juan).
persona(maria).
persona(pedro).

edad(juan, 45).
edad(maria, 20).
edad(pedro, 15).
```

**Guarda estos hechos en tu archivo `ejemplo.pl`**

Podemos interpretar estos hechos como:

> Juan es una persona.

> María tiene 20 años.

> Pedro tiene 15 años.

Los nombres que comienzan con **minúscula** son constantes.

```prolog
juan
maria
pedro
```

Mientras que los nombres que comienzan con **mayúscula** son variables:

```prolog
X
Y
Persona
```


---

# 3. Consultar hechos

En la consola de `swi-prolog` (abre swi-prolog si no los has hecho), carga la base de conocimiento así:

```prolog
% moverse a la carpeta donde esta tu base de conocimiento (BC)
?-cd('c:/trabajo/prolog')
% cargar el archivo
?-consult('ejemplo.pl')
% tambien puedes cargar tu BC así:
?-[programa].
% la extención .pl se agrega automáticamente
```

Tambien puedes cargar tu BC en el menu: (`File->Consult->selecciona archivo`)

Después de cargar el archivo en SWI-Prolog, puedes hacer consultas así:

```prolog
?- persona(juan).
```

Prolog responde:

```text
true.
```

También podemos preguntar:

```prolog
?- persona(X).
```

Y Prolog busca todos los valores posibles de `X`:

```text
X = juan ;
X = maria ;
X = pedro.
```

El `;` permite solicitar otra solución.

>nota Puedes editar el archivo usando VSCode o en el menu de swi-prolog selecciona(`File->edit`)
---

# 4. Reglas

Las reglas permiten **deducir conocimiento nuevo**.

Por ejemplo:

```prolog
padre(juan, pedro).
padre(juan, maria).
padre(pedro, carlos).

abuelo(X, Y) :-
    padre(X, Z),
    padre(Z, Y).
```

Tenempos 3 hechos `padre(*,*)` y una regla.

La regla dice:

> X es abuelo de Y si X es padre de Z y Z es padre de Y.


Ahora podemos preguntar:

```prolog
?- abuelo(juan, carlos).
```

Resultado:

```text
true.
```

Prolog realizó el razonamiento:

```text
padre(juan, pedro)
        +
padre(pedro, carlos)
        ↓
abuelo(juan, carlos)
```

---

# 5. Variables y unificación

Uno de los conceptos más importantes de Prolog es la **unificación**.

Supongamos:

```prolog
gusta(juan, pizza).
gusta(maria, pasta).
gusta(pedro, pizza).
```

Podemos preguntar:

```prolog
?- gusta(X, pizza).
```

Prolog encuentra:

```text
X = juan ;
X = pedro.
```

La variable `X` se **unifica** con los valores que hacen verdadera la consulta.

También podemos preguntar:

```prolog
?- gusta(juan, X).
```

Resultado:

```text
X = pizza.
```

---

# 6. Ejemplo de una pequeña base de conocimiento

Supongamos que queremos representar información sobre estudiantes.

```prolog
% Personas
estudiante(ana).
estudiante(juan).
estudiante(maria).

% Materias
materia(prolog).
materia(bases_datos).
materia(inteligencia_artificial).

% Inscripciones
inscrito(ana, prolog).
inscrito(ana, bases_datos).
inscrito(juan, prolog).
inscrito(maria, inteligencia_artificial).

% Calificaciones
calificacion(ana, prolog, 95).
calificacion(ana, bases_datos, 88).
calificacion(juan, prolog, 70).
calificacion(maria, inteligencia_artificial, 92).
```

Ahora podemos hacer consultas.

### ¿Ana es estudiante?

```prolog
?- estudiante(ana).
```

```text
true.
```

### ¿En qué materias está inscrita Ana?

```prolog
?- inscrito(ana, X).
```

```text
X = prolog ;
X = bases_datos.
```

### ¿Quién está inscrito en Prolog?

```prolog
?- inscrito(X, prolog).
```

```text
X = ana ;
X = juan.
```

---

# 7. Reglas para obtener conocimiento nuevo

Podemos definir:

```prolog
aprobado(Estudiante, Materia) :-
    calificacion(Estudiante, Materia, Nota),
    Nota >= 70.
```


Ahora `aprobado/2` no necesita almacenarse como hecho. Prolog puede **deducirlo**.

Consulta:

```prolog
?- aprobado(ana, prolog).
```

Resultado:

```text
true.
```

Y:

```prolog
?- aprobado(juan, prolog).
```

También:

```text
true.
```

Pero podemos preguntar:

```prolog
?- aprobado(X, prolog).
```

Y obtener:

```text
X = ana ;
X = juan.
```

---

# 8. Reglas más complejas

Podemos definir cuándo un estudiante tiene un buen desempeño:

```prolog
buen_estudiante(Estudiante) :-
    calificacion(Estudiante, _, Nota),
    Nota >= 90.
```

El `_` significa:

> No me interesa conocer este valor.

Entonces:

```prolog
?- buen_estudiante(ana).
```

da:

```text
true.
```

Y:

```prolog
?- buen_estudiante(maria).
```

también:

```text
true.
```

---

# 9. Conjunción y disyunción

En Prolog:

```prolog
,
```

significa **AND**.

Por ejemplo:

```prolog
buen_estudiante(X) :-
    estudiante(X),
    calificacion(X, _, Nota),
    Nota >= 90.
```

Significa:

> X es estudiante **Y** tiene una nota **Y** esa nota ≥ 90.

El operador:

```prolog
;
```

representa **OR**.

Por ejemplo:

```prolog
progenitor(X, Y) :-
    padre(X, Y);
    madre(X, Y).
```

Significa:

> X es progenitor de Y si X es padre **O** madre de Y.

---

# 10. Recursividad

La recursividad es especialmente importante en Prolog.

Por ejemplo, podemos representar una relación de descendencia.

```prolog
padre(juan, pedro).
padre(pedro, carlos).
padre(carlos, diego).
```

Definimos:

```prolog
ancestro(X, Y) :-
    padre(X, Y).

ancestro(X, Y) :-
    padre(X, Z),
    ancestro(Z, Y).
```

Ahora:

```prolog
?- ancestro(juan, diego).
```

Produce:

```text
true.
```

Porque Prolog puede recorrer:

```text
juan
 ↓
pedro
 ↓
carlos
 ↓
diego
```

---

# 11. Arquitectura conceptual

Una base de conocimiento en Prolog puede visualizarse así:

```text
             BASE DE CONOCIMIENTO
                     │
          ┌──────────┴──────────┐
          │                     │
        HECHOS                REGLAS
          │                     │
     ┌────┴────┐           ┌────┴────┐
     │         │           │         │
  padre()   edad()      abuelo()  aprobado()
     │         │           │         │
     └─────────┴───────────┴─────────┘
                     │
                     ▼
                  CONSULTAS
                     │
                     ▼
                  PROLOG
                     │
                     ▼
              RESPUESTAS / INFERENCIAS
```

---

## 12. El ciclo de trabajo

En SWI-Prolog normalmente trabajamos así:

### 1. Crear el archivo

Por ejemplo:

```text
escuela.pl
```

### 2. Escribir hechos y reglas

```prolog
estudiante(ana).
estudiante(juan).

calificacion(ana, prolog, 95).
calificacion(juan, prolog, 65).

aprobado(X, Materia) :-
    calificacion(X, Materia, Nota),
    Nota >= 70.
```

### 3. Cargarlo en SWI-Prolog

```prolog
?- [escuela].
```

o:

```prolog
?- consult('escuela.pl').
```

### 4. Hacer consultas

```prolog
?- estudiante(X).
```

```text
X = ana ;
X = juan.
```

Y:

```prolog
?- aprobado(X, prolog).
```

```text
X = ana.
```

---

# 13. Idea fundamental

La diferencia con un lenguaje tradicional como Python es importante.

En Python normalmente indicamos **cómo** realizar una operación:

```text
haz esto
después esto
después aquello
```

En Prolog describimos **qué sabemos**:

```prolog
padre(juan, pedro).
padre(pedro, carlos).
```

y **qué relaciones existen**:

```prolog
abuelo(X, Y) :-
    padre(X, Z),
    padre(Z, Y).
```

Después hacemos una pregunta:

```prolog
?- abuelo(juan, carlos).
```

y Prolog intenta demostrar si la afirmación es verdadera.

### En resumen

| Elemento     | Función                         | Ejemplo               |
| ------------ | ------------------------------- | --------------------- |
| Hecho        | Representa conocimiento         | `padre(juan, pedro).` |
| Regla        | Permite inferir conocimiento    | `abuelo(X,Y) :- ...`  |
| Variable     | Representa un valor desconocido | `X`                   |
| Constante    | Representa una entidad          | `juan`                |
| Consulta     | Hace una pregunta               | `?- padre(X,pedro).`  |
| Unificación  | Encuentra valores compatibles   | `X = juan`            |
| `,`          | AND                             | `A, B`                |
| `;`          | OR                              | `A ; B`               |
| `_`          | Variable anónima                | `padre(X, _)`         |
| Recursividad | Permite inferencias repetidas   | `ancestro/2`          |

Una base de conocimiento en SWI-Prolog es una colección de **hechos + reglas**, y el motor de Prolog utiliza **unificación, búsqueda y backtracking** para responder consultas y obtener conclusiones que no necesariamente estaban escritas explícitamente.

El backtracking (o retroceso) es el mecanismo fundamental que utiliza Prolog para encontrar soluciones a una consulta. Es lo que le permite explorar diferentes caminos cuando una elección no conduce al éxito. El backtracking es el proceso por el cual Prolog retrocede a un punto de decisión anterior cuando la rama que estaba explorando falla, para intentar una alternativa diferente.

En términos simples: cuando Prolog no puede satisfacer un objetivo con la elección actual, "deshace" esa decisión y prueba la siguiente opción disponible.
