/*
 * Servidor.pl
 *
 * Ejemplo de servidor web en Prolog usando SWI-Prolog.
 *
 * Para ejecutar este servidor, asegúrate de tener SWI-Prolog instalado y
 * ejecuta uno de los siguientes opciones
 * a) comando en la terminal:
 * swipl -s server.pl
 *
 * b) 
 * Ejecutando el comando en la consola:
 * menu/file/consult/ elije el archivo server.pl/enter
 * 
 * Luego, abre tu navegador web y visita http://localhost:8080/home para ver
 * la página de inicio.
 * Cierra el servidor con el comando en la consola:
 * http_stop_server(8080, []).
 * halt.
 */

:- use_module(library(http/http_server)).
:- initialization http_server([port(8080)]).
:- http_handler(root(.), home_page, []). % cuando vayan a la raiz redirecciona a home_page
:- http_handler(root(home), home_page, []).

home_page(_Request) :-
    reply_html_page(
        title('Servidor.pl Ejemplo'),
        [ h1('Hola mundo!') ]
    ).