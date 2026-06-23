# Swi prolog

[instalar desde:](https://www.swi-prolog.org/)
1. ve a download
2. elije *stable release*
3. selecciona la versionde tu SO (en mi caso Windows 64)
4. Ejecuta el instalador

## introducción

SWI-Prolog es una implementación libre y de código abierto del lenguaje de programación Prolog (PROgramming in LOGic), mantenida activamente desde 1987 por la Universidad de Ámsterdam y una comunidad global de desarrolladores.

Al arrancar swiprolog verá una consola con el promp `?-` ahi puede empezar a trabajar con prolog.

## Crear base de conocimiento

En un editor como VsCode escriba:

Archivo: familia.pl
```prolog
% Esto es un comentario (empieza con %)

% ============================================
% HECHOS (hechos básicos sobre el mundo)
% ============================================

hombre(juan).
hombre(carlos).
hombre(pedro).

mujer(ana).
mujer(maria).
mujer(laura).

padre(juan, ana).    % Juan es padre de Ana
padre(carlos, juan). % Carlos es padre de Juan
madre(ana, pedro).   % Ana es madre de Pedro

% ============================================
% REGLAS (relaciones derivadas)
% ============================================

% X es padre/madre de Y
progenitor(X, Y) :- padre(X, Y).
progenitor(X, Y) :- madre(X, Y).

% X es abuelo/a de Y
abuelo(X, Y) :- progenitor(X, Z), progenitor(Z, Y).

% X y Y son hermanos
hermano(X, Y) :- progenitor(Z, X), progenitor(Z, Y), X \= Y.
```


Cargar y Ejecutar

Cargar desde la interfaz:
* Abre SWI-Prolog
* Ve al menú File → Consult... (o presiona Ctrl + L)
* Navega hasta tu archivo familia.pl y selecciónalo
* Verás un mensaje como true si se cargó correctamente

Desde la consola:
```bash
% Cargar el archivo (cambia la ruta según tu sistema)
?- [familia].
% o con ruta completa:
?- ['C:/mis_proyectos/familia.pl'].

% En Windows, también puedes usar:
?- working_directory(_, 'C:/mis_proyectos').
?- [familia].

% En Linux/Mac:
?- working_directory(_, '/home/usuario/prolog/').
?- [familia].
```

Cargar usando Consult
```bash
?- consult('familia.pl').
% o
?- consult('C:/mis_proyectos/familia.pl').
```
