# listas

## forall

forall/2 es un predicado de control que sirve para iterar sobre todas las soluciones de una condición y ejecutar una acción para cada una. Su sintaxis es:
```prolog
forall(Condicion, Accion)
```
Funcionamiento:
* Encuentra una solución para Condicion
* Ejecuta Accion usando esa solución
* Busca la siguiente solución de Condicion
* Repite hasta que no haya más soluciones

## fundall/3 

es un predicado de colección que se usa para recolectar todas las soluciones de una consulta en una lista. Su sintaxis es:

```prolog
findall(Termino, Consulta, Lista)
```
* Termino: Qué quieres guardar de cada solución
* Consulta: La condición que genera soluciones
* Lista: La lista donde se guardan todos los términos

Funcionamiento
* Encuentra todas las soluciones de Consulta
* Para cada solución, crea un Termino
* Guarda todos los términos en Lista

Siempre tiene éxito (incluso si no hay soluciones, devuelve [])

## varios
sum_list/2 es un predicado incorporado en SWI-Prolog que calcula la suma de todos los elementos de una lista numérica.

```prolog
sum_list(Lista, Suma)
```

length/2 calcula numero de elementos.
```prolog
length(Lista, Longitud)
```

```prolog
% min_list/2 - Mínimo
min_list([1,2,3], M).   
```

## listas

Una lista en Prolog es una colección ordenada de elementos. Puede contener cualquier tipo de datos (números, átomos, estructuras, otras listas).

```prolog
% Lista vacía
[].

% Lista con elementos
[1, 2, 3, 4, 5].
[manzana, pera, naranja].
[juan, 30, programador].  % Mezcla de tipos
[[1,2], [3,4], [5,6]].    % Lista de listas
```

### Estrcutura de una lista
```prolog
% Sintaxis con | (barra vertical)
[Cabeza | Cola]

% Ejemplo
?- [H | T] = [1, 2, 3, 4, 5].
H = 1,
T = [2, 3, 4, 5].

% Múltiples elementos en la cabeza
?- [A, B | Resto] = [1, 2, 3, 4, 5].
A = 1,
B = 2,
Resto = [3, 4, 5].
```

### operaciones básicas con listas

```prolog
% Usando length/2
?- length([1,2,3,4,5], Longitud).
Longitud = 5.

% Con tu base de conocimiento
?- findall(Nombre, persona(Nombre, _, _), Personas),
   length(Personas, Total).
Total = 5.
```

### Acceder a elementos

```prolog
% Primer elemento (cabeza)
?- [H | _] = [juan, maria, carlos].
H = juan.

% Último elemento
% (usando reverse)
?- reverse([1,2,3,4,5], [Ultimo | _]).
Ultimo = 5.

% Elemento en posición específica
?- nth0(2, [a,b,c,d,e], Elemento).  % 0-indexado
Elemento = c.

% Usando nth1 (1-indexado)
?- nth1(3, [a,b,c,d,e], Elemento).
Elemento = c.
```

### Unir listas

```prolog
% append/3 - Unir dos listas
?- append([1,2], [3,4,5], Resultado).
Resultado = [1,2,3,4,5].

% También se puede usar al revés para dividir
?- append([1,2], Resto, [1,2,3,4,5]).
Resto = [3,4,5].
```

### Pertenencia
```prolog
% member/2 - Verificar si un elemento está en la lista
?- member(3, [1,2,3,4,5]).
true.

?- member(6, [1,2,3,4,5]).
false.

% Usando member con tu base de conocimiento, verificar si existe juan
?- findall(Nombre, persona(Nombre, _, _), Personas),
   member(juan, Personas).
true.
```

### Estadisticas con listas

```prolog
% Obtener lista de edades
obtener_edades(Edades) :-
    findall(Edad, persona(_, Edad, _), Edades).

% Edad promedio usando listas
edad_promedio(Promedio) :-
    obtener_edades(Edades),
    sum_list(Edades, Suma),
    length(Edades, Cantidad),
    Promedio is Suma / Cantidad.

% Persona más joven
persona_mas_joven(Nombre, Edad) :-
    obtener_edades(Edades),
    min_list(Edades, Edad),
    persona(Nombre, Edad, _).

% Uso
?- persona_mas_joven(Nombre, Edad).
Nombre = maria,
Edad = 25.
```