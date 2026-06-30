# ejecutar

Desde la consola de swi-prolog:
1. menu/file/consult/elegir archivo
2. [ruta/script.pl].

Desde consola:
```bash
swipl -s script.pl
```

Con un objetivo

```prolog
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
```

``bash
swipl -g "exportar_json." -t "halt." exportar_json.pl
```
