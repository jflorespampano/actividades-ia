%hechos
nivel(ana,tecnico).
nivel(juan,pasante).
nivel(luis,tuitulado).
nivel(rosa,maestria).
certificado_en(ana,c).
certificado_en(rosa,php).
certificado_en(ana,js).
certificado_en(juan,c).
%reglas
certificado(X):-certificado_en(X,Y).
programadorjr(X):-nivel(X,tecnico);nivel(X,pasante).
programadorsr(X):-nivel(X,titulado);nivel(X,pasante),certificado(X).
lider(X):-nivel(X,maestria).

% REGLA CORREGIDA - Ahora devuelve X e Y
puede_proyecto1(X, Y) :- programadorjr(X), programadorsr(Y), X \= Y.
puede_proyecto2(X, Y) :- programadorsr(X), programadorsr(Y), X \= Y.
puede_proyecto3(X, Y) :- lider(X), programadorsr(Y), X \= Y.