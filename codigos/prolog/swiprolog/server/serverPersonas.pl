% Ejemplo de una base de conocimiento en Prolog con un servidor web que expone una API REST y vistas HTML.
% Para ejecutar este servidor, asegúrate de tener SWI-Prolog instalado y para ejecutarlo:
% ejecutar: swipl -s este archivo.pl
% mostrara una consola con el servidor corriendo en el puerto 8080
% abrir: http://localhost:8080/home
% detener el servidor, desde la cosola abierta: http_stop_server(8080, []).
% en la consola poner: halt.
%

% ================================================
% Base de conocimiento de ejemplo 
% ================================================
persona(juan, 30, programador).
persona(maria, 25, disenadora).
persona(carlos, 35, ingeniero).
persona(ana, 28, analista).
persona(luis, 40, gerente).

% Relaciones de amistad
amigo(juan, maria).
amigo(juan, carlos).
amigo(maria, ana).
amigo(carlos, luis).
amigo(ana, juan).

% Reglas
edad(X, Edad) :- persona(X, Edad, _).
profesion(X, Prof) :- persona(X, _, Prof).
amigos_de(X, Amigos) :- findall(Y, amigo(X, Y), Amigos).

% ================================================
% server
% ================================================

:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(json)).
% antes la biblioteca json estaba en: :- use_module(library(http/json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).

% Inicializar el servidor
:- initialization http_server([port(8080)]).

% Definir los manejadores de rutas
:- http_handler(root(.), home_page, []).
:- http_handler(root(home), home_page, []).
:- http_handler(root(api/personas), api_personas, []).
:- http_handler(root(api/persona), api_persona, []).
:- http_handler(root(api/amigos), api_amigos, []).
:- http_handler(root(api/buscar), api_buscar, []).
:- http_handler(root(html/personas), html_personas, []).


% ================================================
% RUTA: Página de inicio
% ================================================
home_page(_Request) :-
    reply_html_page(
        title('Servidor Prolog con Base de Conocimiento'),
        [
            h1('Bienvenido al Servidor Prolog'),
            p('Este servidor tiene una base de conocimiento sobre personas y sus relaciones.'),
            h2('Endpoints disponibles:'),
            ul([
                li('GET /api/personas - Listar todas las personas'),
                li('GET /api/persona?nombre=juan - Obtener datos de una persona'),
                li('GET /api/amigos?nombre=juan - Listar amigos de una persona'),
                li('GET /api/buscar?profesion=programador - Buscar por profesion'),
                li('GET /html/personas - Vista HTML de todas las personas')
            ])
        ]
    ).

% ================================================
% RUTA: API para listar todas las personas
% ================================================
api_personas(_Request) :-
    % Obtener todas las personas
    findall(
         _{nombre: Nombre, edad: Edad, profesion: Profesion},  % <-- DICCIONARIO JSON
        persona(Nombre, Edad, Profesion),
        Personas
    ),
    % Convertir a JSON y responder
    reply_json_dict(Personas).

% ================================================
% RUTA: API para obtener datos de una persona específica
% ================================================
api_persona(Request) :-
    % Extraer el parámetro 'nombre' de la URL
    http_parameters(Request, [
        nombre(Nombre, [])
    ]),
    % Buscar la persona
    (   persona(Nombre, Edad, Profesion)
    ->  reply_json_dict(_{nombre: Nombre, edad: Edad, profesion: Profesion})
    ;   reply_json_dict(_{error: 'Persona no encontrada'}, [status(404)])
    ).

% ================================================
% RUTA: API para listar amigos de una persona
% ================================================
api_amigos(Request) :-
    http_parameters(Request, [
        nombre(Nombre, [])
    ]),
    (   findall(Amigo, amigo(Nombre, Amigo), Amigos),
        Amigos \= []
    ->  reply_json_dict(_{nombre: Nombre, amigos: Amigos})
    ;   reply_json_dict(_{error: 'Persona no encontrada o sin amigos'}, [status(404)])
    ).

% ================================================
% RUTA: API para buscar por profesión
% ================================================
api_buscar(Request) :-
    http_parameters(Request, [
        profesion(Profesion, [])
    ]),
    findall(
        _{nombre: Nombre, edad: Edad},
        persona(Nombre, Edad, Profesion),
        Personas
    ),
    reply_json_dict(_{profesion: Profesion, personas: Personas}).

% ================================================
% RUTA: Vista HTML de todas las personas
% ================================================
html_personas(_Request) :-
    findall(persona(Nombre, Edad, Profesion), persona(Nombre, Edad, Profesion), Personas),
    reply_html_page(
        title('Lista de Personas'),
        [
            h1('Personas Registradas'),
            table(
                [
                    tr([th('Nombre'), th('Edad'), th('Profesion')]),
                    \personas_filas(Personas)  % <-- Usando la regla DCG
                ]
            )
        ]
    ).

% Predicado auxiliar DCG para generar filas HTML
personas_filas([]) --> [].
personas_filas([persona(N, E, P)|Rest]) -->
    html(tr([td(N), td(E), td(P)])),
    personas_filas(Rest).

