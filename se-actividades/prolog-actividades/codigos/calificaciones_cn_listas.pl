% Hechos y reglas para manejar las calificaciones de estudiantes 
% en diferentes temas:
% temas programación (funcional, logico, objetos)
% si la lista tiene mas de una nota significa que recurso la materia


% hechos
% pepito, saco 2 en programacion funcional, luego curso y saco 9
notas(pepito, funcional, [2, 9]).
notas(pepito, logico, [10]).
notas(pepito, objetos, [9]).
notas(juanita, funcional, [10]).
notas(juanita, logico, [8]).
notas(juanita, objetos, [10]).
notas(tito, funcional, [2, 4, 6]).
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

% Contar elementos menores que 6
contar_menores_6(Lista, Count) :-
    findall(X, (member(X, Lista), X < 6), Menores),
    length(Menores, Count).

% veces que reprobo
veces_que_reprobo(Estudiante, Tema, Veces):-notas(Estudiante,Tema,Lista), contar_menores_6(Lista, Veces).