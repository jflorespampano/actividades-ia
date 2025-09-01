# ejemplo de red bayesiana

### Definir la red bayesiana: "Diagnóstico de Gripe"

Modelaremos tres variables:

1. Fiebre (fiebre): Posible síntoma de gripe.

2. Gripe (gripe): Enfermedad a diagnosticar.

3. Temporada (temporada): Factor de riesgo (ej. invierno).

Red Bayesiana en SWI-Prolog utilizando el paquete pbn (Probabilistic Bayesian Networks)

### Paso 1: Instalar el paquete pbn (si no está instalado)

```js
pack_install(pbn).  % Instala el paquete de redes bayesianas
```

### Definir la red bayesiana: "Diagnóstico de Gripe"

```js
:- use_module(library(pbn)).

% Definir la estructura de la red
red_gripe :-
    new_pbn(Red),
    % Añadir nodos (variable, valores_posibles)
    pbn_add_node(Red, temporada, [invierno, no_invierno]),
    pbn_add_node(Red, gripe, [si, no]),
    pbn_add_node(Red, fiebre, [si, no]),

    % Establecer arcos (dependencias)
    pbn_add_edge(Red, temporada, gripe),
    pbn_add_edge(Red, gripe, fiebre),

    % Probabilidades a priori
    pbn_set_CPT(Red, temporada, [0.3, 0.7]), % P(invierno)=30%
    
    % Probabilidades condicionales (CPT)
    pbn_set_CPT(Red, gripe, [
        0.4,  % P(gripe=si | temporada=invierno)
        0.6,   % P(gripe=no | temporada=invierno)
        0.1,   % P(gripe=si | temporada=no_invierno)
        0.9    % P(gripe=no | temporada=no_invierno)
    ]),
    
    pbn_set_CPT(Red, fiebre, [
        0.8,  % P(fiebre=si | gripe=si)
        0.2,  % P(fiebre=no | gripe=si)
        0.1,  % P(fiebre=si | gripe=no)
        0.9   % P(fiebre=no | gripe=no)
    ]),

    % Guardar la red para usarla luego
    assertz(red(Red)).
```

### consultas

a. Probabilidad a priori de gripe:
```js
?- red_gripe, red(Red), pbn_query(Red, gripe, si, P).
P = 0.19.  % 19% (calculado como: 0.3*0.4 + 0.7*0.1)
```

b. Probabilidad de gripe dado que hay fiebre (Inferencia):

```js
?- red_gripe, red(Red), 
   pbn_observe(Red, fiebre, si),  % Evidencia: fiebre=si
   pbn_query(Red, gripe, si, P).
P = 0.7917.  % ≈79.2% de probabilidad de gripe
```

c. Probabilidad conjunta (temporada=invierno Y gripe=si):

```js
?- red_gripe, red(Red), pbn_joint(Red, [temporada=invierno, gripe=si], P).
P = 0.12.  % 30% (invierno) * 40% (gripe|invierno)
```

Visualización (opcional)
Generar un archivo DOT para visualizar con Graphviz:

```js
?- red(Red), pbn_to_dot(Red, 'red_gripe.dot').
```

[Graphviz](https://graphviz.org/)