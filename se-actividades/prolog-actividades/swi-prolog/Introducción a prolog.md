---
categoría: ia
tipo: prolog
---
## Introducción

Para probar nuestro código usaremos:

- **Swi-Prolog** (interprete de Prolog que debe instalar en su equipo)
- Una herramienta para experimentar en línea para Prolog llamada **Swish**
- Actividad curso:
- [ ] Liga para probar en línea swish: [liga](https://swish.swi-prolog.org/p/fgRDDSpC.swinb)
- [ ] Para **instalar Swi-Prolog**, ver archivo ‘1-instalar-swi-prolog.pdf’ en la carpeta ‘prolog-actividades’
- [ ] Explicar: Para crear nuevo archivo en con un ejemplo swish:

## Usando Swish

1. clic en **‘open a new tab’** (botón + [de color azul con fondo blanco])
2. en el cuadro de dialogo **‘create a’** , seleccione **‘program’**
3. capture sus predicados

Ejemplo de predicados:
```prolog
padre(juan,maria).
padre(luis,pedro).

abuelo(X,Y):-padre(X,Z),padre(Z,Y).
```

En la consola de lado inferior derecho, ejecute las consultas:

```prolog
padre(X,maria).

padre(X,Y).
```

- [ ] **Tarea:** probar código: ‘Ejemplo swi-prolog-2019-habilidades-prog.pdf’ en la carpeta ‘prolog-actividades’

### Predicados en Prolog

- [ ] Definir Predicado.- En matemáticas, un **predicado** es una función o relación que toma uno o más argumentos y devuelve un valor de **verdad** (**`verdadero`** o **`falso`**). Es un concepto fundamental en lógica matemática, teoría de conjuntos y álgebra, y sirve para expresar propiedades o relaciones entre elementos.

### **Tipos de Predicados**

- [ ] **1 Hechos (Facts)**
    
    Predicados que son universalmente verdaderos:
    ```prolog
    padre(juan, maria).  % "Juan es padre de María"
    ```
    
- [ ] **2 Reglas (Rules)**
    
    Predicados condicionales que dependen de otros predicados:
    ```prolog
    abuelo(X, Y) :- padre(X, Z), padre(Z, Y).  % "X es abuelo de Y si X es padre de Z y Z es padre de Y"
    ```
    
- [ ] **3 Metas (Goals)**
    
    Predicados que se consultan para obtener respuestas:
    ```prolog
    ?- padre(juan, X).  % "¿De quién es padre Juan?"
    ```
    
- [ ] **Modus Ponendo Tollens (MPT).-** Es una regla que establece: _"Si ‘A o B’ es verdadero y ‘A’ es falso, entonces ‘B’ debe ser verdadero"_
    

Ejemplo (MPT) en Prolog

```prolog
% Base de conocimiento
% enfermedad1 o enfermedad2 tiene sintoma de fiebre
sintoma(fiebre) :- enfermedad1 ; enfermedad2.

% Regla MPT: Si hay fiebre y no es enfermedad1, entonces es enfermedad2
diagnostico(enfermedad2) :-
sintoma(fiebre),
\\+ enfermedad1,
enfermedad2.

% Hechos (simulando escenarios)
enfermedad1 :- fail. % ¬enfermedad1
enfermedad2.         % enfermedad2 existe

% Consulta
?- diagnostico(X).
X = enfermedad2.     % MPT aplicado correctamente
```

- [ ] El **Modus Tollendo Tollens** (MTT) es una regla de inferencia en lógica que dice:

_Si P implica Q, y Q es falso, entonces P es falso._

```prolog
% Definimos las implicaciones (P → Q)
implica(p, q).  % "Si P entonces Q"

% Definimos que Q es falso (¬Q)
falso(q).       % "Q es falso"

% Regla Modus Tollendo Tollens: Si P implica Q y Q es falso, entonces ¬P.
negacion_p :-
implica(p, q),
falso(q),
write('¬P es verdadero porque Q es falso y P implica Q.'), nl.

% Consulta:
% ?- negacion_p.
% Salida esperada: "¬P es verdadero porque Q es falso y P implica Q."
```

- [ ] **Limitaciones de la negación en Prolog**
- La negación (**`\+`**) es _negación por fallo_, no lógica clásica. Solo significa _"no se puede probar A"_.
- Para lógica exacta, usar bibliotecas como **`library(clpb`** (Booleans) o sistemas de razonamiento externos.
- **`\+ Goal`** (o **`not(Goal)`** en algunas versiones) significa: _"Goal no puede ser probado como verdadero con el conocimiento actual"_ (no necesariamente que sea falso en un sentido lógico absoluto).