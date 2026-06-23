---
categoría: ia
tipo: prolog
---
## Explicar en Prolog conceptos

### Hechos

En Prolog un hecho es una declaración que establece una relación o propiedad verdadera entre objetos, formando la base de conocimiento del programa. Los hechos son el tipo más sencillo de cláusula y se utilizan para declarar valores que son verdaderos para un predicado. Un hecho se compone de un predicado seguido de uno o más argumentos entre paréntesis, separados por comas, y termina con un punto. Por ejemplo,

```prolog
persona(juan,27).
```

es un hecho que representa una relación entre Juan y su edad

### Operador :-

El operador **`:-`** en Prolog corresponde a la **implicación lógica inversa** (o "si") en la lógica de predicados. Su significado formal es:

```
  Conclusión:-Condición
```

Que se lee como: _"La Conclusión es verdadera si la Condición es verdadera"_

Equivalente a Condición→Conclusión en lógica matemática estándar:

```
  Conclusión←Condición
```

### **Relación con la Implicación**

- En lógica clásica:
    
    A→B(A implica B) equivale a B←A (B si A).
    
- Prolog invierte la sintaxis para priorizar la **conclusión** (head) sobre las **condiciones** (body).
    

### Regla

Es una **cláusula que define una relación o predicado basándose en condiciones que deben cumplirse para que el predicado sea verdadero**

Está compuesta por una cabeza y un cuerpo, y se escribe en la forma:

```prolog
Cabeza :- Cuerpo.
```

La cabeza representa el hecho que se quiere probar, mientras que el cuerpo contiene una serie de objetivos o predicados que deben ser verdaderos para que la cabeza lo sea. Esta estructura se interpreta como "la cabeza es verdadera si el cuerpo es verdadero".

El cuerpo de una regla consiste en llamadas a predicados, que son los objetivos a los que se debe satisfacer.

Estos objetivos se separan con comas, lo que denota una conjunción (y), y el operador ;/2 se utiliza para representar una disyunción (o), aunque esta última no es un operador básico sino que está meta-programado.

Las reglas permiten definir relaciones entre objetos de forma general, como en el caso de que un coche tenga ruedas, donde se puede usar una variable para generalizar el hecho. Además, las reglas pueden ser recursivas, lo que permite resolver problemas complejos como la definición de relaciones genealógicas.

### negación

```prolog
% "Un animal es exótico si NO es doméstico"
exotico(Animal) :-
    \+ domestico(Animal).

domestico(perro).
domestico(gato).
```

### Variables

En Prolog, las **variables** son elementos fundamentales para la unificación y el razonamiento lógico. A diferencia de los lenguajes imperativos, no son "contenedores de valores" sino **incógnitas** que se instancian mediante patrones.

### **Sintaxis y Características**

1. **Representación** de variables:
    - Comienzan con **mayúscula** o subraya (**`_`**):
        
        ```prolog
        X, Resultado, _var_anonima
        ```
    - **No se declaran**: Surgen durante la ejecución.
        
2. **Ámbito (Scope)**:
    - Son **locales a la cláusula** donde aparecen.
    - Ejemplo:
        ```prolog
        padre(X, Y) :- hijo(Y, X).  % X y Y solo existen en esta regla.
        ```
### **Unificación: El Corazón de las Variables**

En Prolog, **unificar** es el proceso de hacer que dos términos (variables, átomos, estructuras, etc.) sean **idénticos** asignando valores a las variables involucradas. Es el mecanismo central para resolver consultas y ejecutar reglas lógicas.

- Prolog intenta **unificar** variables con términos para hacer verdaderas las consultas.
- Ejemplo:
    
    ```prolog
    % Consulta: ?- X = 5.
    % X es una variable libre, se une al átomo 5.
    X = 5.  % Éxito: X ahora vale 5.
    
    % Consulta: ?- X = Y, Y = gato.
    X = Y, Y = gato.  
    % Primero X se une a Y (ambas variables libres), luego Y se une a 'gato'.
    % Resultado final: X = gato, Y = gato.
    
    % Consulta: ?- f(X, b) = f(a, Y).
    % Para que la unificación tenga éxito:
    %   1. El functor 'f' y la aridad (2) coinciden.
    %   2. Se unifican los argumentos: X = a, b = Y.
    X = a, Y = b.  % Éxito.
    
    % Consulta: ?- f(X, b) = g(X, b).
    % Fallo: Los functores 'f' y 'g' son distintos.
    false.
    
    % Consulta: ?- f(X) = f(X, Y).
    % Fallo: Distinta aridad (1 vs 2).
    false.
    
    % Consulta: ?- [X, Y, Z] = [1, 2, 3].
    X = 1, Y = 2, Z = 3.  % Éxito.
    
    % Consulta: ?- [X|Xs] = [1, 2, 3].
    X = 1, Xs = [2, 3].    % Éxito (notación de cabeza-cola).
    ```


### **Reglas Básicas de Unificación**

1. **Una variable libre** se une a cualquier término (incluyendo otra variable libre).
2. **Átomos** solo se unifican si son idénticos.
3. **Estructuras** (como **`f(X, Y)`**) se unifican si:
    - Tienen el mismo functor y aridad.
    - Sus argumentos se unifican **recursivamente**.

### **Tipos de Variables**

1. **Libres (No instanciadas)**:
    
    - No están vinculadas a ningún valor.
    - Ejemplo:
        
        ```prolog
        ?- padre(juan, X).  % X es libre.
        ```
        
2. **Instanciadas**:
    
    - Toman un valor concreto durante la unificación.
    - Ejemplo:
        
        ```prolog
        ?- X = 5, write(X).  % X instanciada a 5.
        ```
        
3. **Anónimas (`_`)**
    
    - Variables "descartables". Cada **`_`** es única.
    - Ejemplo:
        ```prolog
        ?- padre(_, maria).  % "¿Existe alguien que sea padre de María?"
        ```

### Predicado write

```prolog
?- write([a, b, c]).
[a,b,c]
true.

?- write(padre(juan, maria)).
padre(juan,maria)
true.

%
?- X = 5, write('El valor de X es: '), write(X).
El valor de X es: 5
true.

%% ejemplo con format
?- format('~w ~w ~n', ['Hola', 'Mundo']).
Hola Mundo
true.

% ~w: Imprime el término tal cual. ~n: Salto de línea.
```

## Ejemplo de base de conocimiento hechos + reglas

```prolog
% Hechos: Datos concretos sobre una familia
hombre(juan).
hombre(pedro).
hombre(carlos).
mujer(maria).
mujer(ana).
mujer(lucia).

% Relaciones de parentesco
padre(juan, pedro).  % Juan es padre de Pedro
padre(juan, ana).
madre(maria, pedro).
madre(maria, ana).
padre(carlos, lucia).

%% reglas
% Regla 1: X es hijo de Y si Y es padre o madre de X
hijo(X, Y) :- (padre(Y, X) ; madre(Y, X)).

% Regla 2: X y Y son hermanos si comparten al menos un padre/madre
hermano(X, Y) :- 
    (padre(P, X), padre(P, Y) ; madre(M, X), madre(M, Y)),
    X \\= Y.  % Evitar que X sea hermano de sí mismo

% Regla 3: X es abuelo de Y si X es padre de Z y Z es padre/madre de Y
abuelo(X, Y) :- 
    (padre(X, Z) ; madre(X, Z)), 
    (padre(Z, Y) ; madre(Z, Y)).

% Regla 4: X es tío de Y si X es hermano de Z y Z es padre/madre de Y
tio(X, Y) :- 
    hermano(X, Z), 
    (padre(Z, Y) ; madre(Z, Y)).
```

```prolog
%% Listas en prolog
[1, 2, 3, 4]          % Lista de números
[rojo, verde, azul]   % Lista de átomos
[[a, b], [c, d]]      % Lista de listas
[]                    % Lista vacía (caso base)
```

- [ ] hechos y listas

```prolog
pelicula(1, "El Padrino", [drama, crimen]).
pelicula(2, "Interestelar", [ciencia_ficcion, aventura]).
pelicula(3, "Toy Story", [animacion, comedia, familia]).
pelicula(4, "El Señor de los Anillos", [aventura, fantasia]).
pelicula(5, "Parasitos", [drama, thriller]).
```

- [ ] reglas y listas

```prolog
prefiere(juan, [drama, crimen]).
prefiere(maria, [animacion, fantasia]).
prefiere(carlos, [ciencia_ficcion, aventura]).
```

- [ ] subraya _ es una variable anónima, sirve para ignorar valores en unificación, por ejemplo:

```prolog
% Ignorar el segundo elemento de una tupla
primer_elemento(X) :- tiene_tupla(X, _).

tiene_tupla(juan, 25).

%%%%%%%%%%%%%%%%%%%%%%
% Verificar si una lista tiene al menos 2 elementos
tiene_dos_elementos([_, _]).

%%%%%%%%%%%%%%%%%%%%%
% Contar personas sin importar sus atributos
total_personas(N) :-
    findall(_, persona(_, _, _), Lista),
    length(Lista, N).
```

## Recursión

La recursión es el corazón de la programación en Prolog. A diferencia de los lenguajes imperativos (como Python o Java), en Prolog **no hay bucles** tradicionales (**`for`**, **`while`**), por lo que la recursión es la técnica fundamental para repetir operaciones y procesar estructuras como listas o árboles.

Una regla recursiva tiene:

1. **Caso base**: Condición de salida que detiene la recursión.
2. **Caso recursivo**: Llamada a la misma regla con un problema más pequeño.

## Ejemplo recursión

```prolog
% Caso base: factorial de 0 es 1
factorial(0, 1).
% Caso recursivo: factorial(N, F) = N * factorial(N-1, F1)
factorial(N, F) :-
N > 0,
N1 is N - 1,
factorial(N1, F1),
F is N * F1.
```

- [ ] member El predicado **`member/2`** es uno de los más utilizados en Prolog para **verificar si un elemento pertenece a una lista** o para **generar elementos de una lista** mediante backtracking. Es una herramienta fundamental para trabajar con estructuras de datos recursivas.

```prolog
?- member(manzana, [pera, manzana, uva]).
true.
?- member(X, [a, b, c]).
X = a ;
X = b ;
X = c.
% ¿Hay algún número par en la lista?
?- member(X, [1, 3, 4, 5]), 0 is X mod 2.
X = 4.
```

- [ ] subset El predicado **`subset/2`** verifica si **todos los elementos de una lista están contenidos en otra lista** (es decir, si una lista es subconjunto de otra). Es una herramienta clave para operaciones con conjuntos en Prolog.

```prolog
?- subset([a, b], [a, b, c, d]).
true.

?- subset([a, e], [a, b, c]).
false.  % 'e' no está en la segunda lista
```
