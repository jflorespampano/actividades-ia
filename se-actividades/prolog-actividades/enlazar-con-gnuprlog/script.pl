% Predicado que lee una consulta desde STDIN, la evalúa y escribe el resultado.
:- initialization(main).

main :-
    read(Consulta),       % Lee la consulta desde Node.js
    call(Consulta),       % Ejecuta la consulta
    write('Éxito: '), write(Consulta), nl, halt.
main :- write('Error: fallo en la consulta'), nl, halt.