% Hechos y reglas para manejar las calificaciones de estudiantes 
% en diferentes temas:
% (funcional, logico, objetos)
% si la lista tiene mas de una nota significa que recurso la materia)


% hechos
notas(pepito, funcional, [2, 9]).
notas(pepito, logico, [10]).
notas(pepito, objetos, [9]).
notas(juanita, funcional, [10]).
notas(juanita, logico, [8]).
notas(juanita, objetos, [10]).
notas(tito, funcional, [2, 6]).
notas(tito, logico, [4, 8]).

% reglas
% buscamos ultima nota del estudiante
ultimaNota(Estudiante, Tema, Nota):-
  notas(Estudiante, Tema, Notas),
  last(Notas, Nota).

% buscamos cuantas veces curso la materia
vecesQueCurso(Estudiante, Tema, Veces):-
  notas(Estudiante, Tema, Notas),
  length(Notas, Veces).
