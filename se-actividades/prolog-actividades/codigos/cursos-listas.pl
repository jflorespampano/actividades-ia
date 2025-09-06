% verificar si puede llevar una materia
% ['/trabajo2025/materialDidactico/progAvanzada-ia/codigos/gnuProlog/cursos.pl'].
materia(matematicas1).
materia(matematicas2).
materia(matematicas3).
materia(fisica1).
materia(fisica2). 

antecedente(matematicas1, matematicas2).
antecedente(matematicas2, matematicas3).

antecedente(fisica1, fisica2).

aprobo(ana,matematicas1).

puede_llevar(Alumno,Materia):-
    materia(Materia),
    aprobo(Alumno,Antecedente),
    antecedente(Antecedente,Materia).