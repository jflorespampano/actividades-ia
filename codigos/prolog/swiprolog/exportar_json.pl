:- use_module(library(http/json)).

% Base de conocimiento
persona(juan, 30, programador).
persona(maria, 25, disenadora).
persona(carlos, 35, ingeniero).
persona(ana, 28, analista).
persona(luis, 40, gerente).

% Exportar a JSON (VERSIÓN CORREGIDA)
exportar_json :-
    % 1. Recolectar datos
    findall(_{nombre: N, edad: E, profesion: P},
        persona(N, E, P),
        Personas),
    
    % 2. Calcular longitud (fuera del JSON)
    length(Personas, Total),
    
    % 3. Crear estructura JSON con el valor calculado
    Data = _{personas: Personas, total: Total},
    
    % 4. Escribir a archivo
    open('personas.json', write, Stream),
    json_write(Stream, Data, [width(0)]),
    close(Stream),
    
    % 5. Mensaje de éxito
    format('Exportado a personas.json (~d personas)~n', [Total]).

/*
La sentencia: Data = _{personas: Personas, total: Total} crea un diccionario JSON que contiene dos claves: "personas" y "total".
- La clave "personas" contiene la lista de personas recolectadas.
- La clave "total" contiene el número total de personas.

En json_write(Stream, Data, [width(0)]),
width(0) es una opción que controla el ancho máximo de línea al escribir JSON, la opcion 0 indica sin limite de ancho, otra opcion podría ser width(80) para limitar el ancho a 80 caracteres.
*/