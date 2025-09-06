% previo a ejecución:
% ?- pack_list(pbn).   % verifica si existe el paquete
% pack_install(pbn).  % Instala el paquete de redes bayesianas
% :- use_module(library(pbn)).
% Probar: Probabilidad a priori de gripe:
% ?- red_gripe, red(Red), pbn_query(Red, gripe, si, P).
% Probar: Probabilidad de gripe dado que hay fiebre (Inferencia):
/* ?- red_gripe, red(Red),
   pbn_observe(Red, fiebre, si),  % Evidencia: fiebre=si
   pbn_query(Red, gripe, si, P).
*/

% probar: Probabilidad conjunta (temporada=invierno Y gripe=si)
% ?- red_gripe, red(Red), pbn_joint(Red, [temporada=invierno, gripe=si], P).
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
