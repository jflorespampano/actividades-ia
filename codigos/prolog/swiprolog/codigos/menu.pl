% Menú básico con opciones numéricas
% ejecucion, en una consola de bash escriba: swipl -s este archivo.pl
% escribir: menu.
menu :-
    write('===================================='), nl,
    write('          MENU PRINCIPAL'), nl,
    write('===================================='), nl,
    write('1. Listar todas las personas'), nl,
    write('2. Buscar persona por nombre'), nl,
    write('3. Listar amigos de una persona'), nl,
    write('4. Salir'), nl,
    write('===================================='), nl,
    write('Seleccione una opcion: '),
    read(Opcion),
    procesar_opcion(Opcion).

procesar_opcion(1) :-
    write('Lista de personas:'), nl,
    listar_personas,
    menu.  % Volver al menú

procesar_opcion(2) :-
    write('Ingrese el nombre: '),
    read(Nombre),
    buscar_persona(Nombre),
    menu.

procesar_opcion(3) :-
    write('Ingrese el nombre: '),
    read(Nombre),
    listar_amigos(Nombre),
    menu.

procesar_opcion(4) :-
    write('Fin'), nl,
    halt.

procesar_opcion(_) :-
    write('Opción no valida. Intente de nuevo.'), nl,
    menu.

% Predicados auxiliares
% CORRECTO: Todas las acciones agrupadas en un solo argumento
listar_personas :-
    forall(persona(N, E, P),
           ( write('  '),
             write(N),
             write(' - '),
             write(E),
             write(' años - '),
             write(P),
             nl
           )).
           

buscar_persona(Nombre) :-
    (   persona(Nombre, Edad, Profesion)
    ->  write('Nombre: '), write(Nombre), nl,
        write('Edad: '), write(Edad), nl,
        write('Profesion: '), write(Profesion), nl
    ;   write('Persona no encontrada.'), nl
    ).

listar_amigos(Nombre) :-
    (   findall(Amigo, amigo(Nombre, Amigo), Amigos),
        Amigos \= []
    ->  write('Amigos de '), write(Nombre), write(':'), nl,
        forall(member(A, Amigos), (write('  '), write(A), nl))
    ;   write('Persona no encontrada o sin amigos.'), nl
    ).

% Base de conocimiento de ejemplo
persona(juan, 30, programador).
persona(maria, 25, disenadora).
persona(carlos, 35, ingeniero).
persona(ana, 28, analista).
persona(luis, 40, gerente).

amigo(juan, maria).
amigo(juan, carlos).
amigo(maria, ana).
amigo(carlos, luis).
amigo(ana, juan).