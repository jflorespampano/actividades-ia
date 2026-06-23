---
categoría: ia
tipo: prolog
---
## Ejercicio

ejercicio prolog sistema del recomendación de películas

película(1, "El Padrino", [drama, crimen]). película(2, "Interestelar", [ciencia_ficcion, aventura]). recomendar(Usuario, Pelicula) :- gusta(Usuario, Genero), película(Pelicula, _, Generos), miembro(Genero, Generos).

## Solución

```prolog
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% BASE DE CONOCIMIENTOS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Películas: id, título, géneros.
pelicula(1, "El Padrino", [drama, crimen]).
pelicula(2, "Interestelar", [ciencia_ficcion, aventura]).
pelicula(3, "Toy Story", [animacion, comedia, familia]).
pelicula(4, "El Señor de los Anillos", [aventura, fantasia]).
pelicula(5, "Parasitos", [drama, thriller]).

% Usuarios y sus géneros preferidos.
prefiere(juan, [drama, crimen]).
prefiere(maria, [animacion, fantasia]).
prefiere(carlos, [ciencia_ficcion, aventura]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     REGLAS LÓGICAS    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Regla 1: Recomendar películas que coincidan con AL MENOS un género preferido.
recomendar(Usuario, Titulo) :-
    prefiere(Usuario, GenerosUsuario),
    pelicula(_, Titulo, GenerosPelicula),
    tiene_genero_comun(GenerosUsuario, GenerosPelicula).

% Regla auxiliar: Verifica si hay géneros en común.
tiene_genero_comun([Genero|_], GenerosPelicula) :-
    member(Genero, GenerosPelicula).
tiene_genero_comun([_|Resto], GenerosPelicula) :-
    tiene_genero_comun(Resto, GenerosPelicula).

% Regla 2: Recomendar películas con TODOS los géneros preferidos (opcional).
recomendar_exigente(Usuario, Titulo) :-
    prefiere(Usuario, GenerosUsuario),
    pelicula(_, Titulo, GenerosPelicula),
    subset(GenerosUsuario, GenerosPelicula).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     EJEMPLOS DE USO    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Consulta 1: ¿Qué películas recomendar a Juan?
% ?- recomendar(juan, Pelicula).
% Pelicula = "El Padrino" ;
% Pelicula = "Parasitos" ;
% Pelicula = "Interestelar" ; 
% Pelicula = "El Señor de los Anillos".

% Consulta 2: ¿Qué películas coinciden EXACTAMENTE con los gustos de María?
% ?- recomendar_exigente(maria, Pelicula).
% Pelicula = "Toy Story" (porque incluye "animacion" y "familia" está en sus preferencias).
```

Explicación de la regla:

```prolog
tiene_genero_comun([Genero|_], GenerosPelicula) :-
    member(Genero, GenerosPelicula).
```

### **Parte 1: Estructura de la Regla**

- **Cabeza (Head)**:
    
    **`tiene_genero_comun([Genero|_], GenerosPelicula)`**
    
    - **`[Genero|_]`**: Patrón de lista que separa el **primer elemento** (**`Genero`**) del resto (**`_`**, que se ignora).
    - **`GenerosPelicula`**: Lista de géneros de una película (ej: **`[drama, crimen]`**).
- **Cuerpo (Body)**:
    
    **`member(Genero, GenerosPelicula)`**
    
    - Verifica si **`Genero`** está en la lista **`GenerosPelicula`** (usando el predicado built-in **`member/2`**).

---

### **Parte 2: ¿Cómo Funciona?**

1. **Paso 1**: Prolog recibe una lista de géneros del usuario, ej: **`[drama, crimen]`**.
2. **Paso 2**: El patrón **`[Genero|_]`**:
    - Asigna el primer género (**`drama`**) a **`Genero`**.
    - Ignora el resto de la lista (**`_`**).
3. **Paso 3**: Verifica si **`Genero`** (ej: **`drama`**) es **`member`** de **`GenerosPelicula`** (ej: **`[aventura, fantasia]`**).
    - Si **sí**, la regla se cumple (hay coincidencia).
    - Si **no**, retrocede (**`backtracking`**) y prueba con otra película.

## Operador →

El operador **`->`** en Prolog es un **operador condicional** (llamado "si-entonces") que permite controlar el flujo de ejecución basado en condiciones.

### **Cómo Funciona**

1. **Si `Condición` es verdadera**:
    - Prolog ejecuta **`Acción`** y **ignora la `Alternativa`**.
    - Similar a un _"cut" implícito_: No se hace backtracking sobre **`Condición`**.
2. **Si `Condición` falla**:
    - Prolog ejecuta **`Alternativa`** (si existe).
    - Si no hay **`Alternativa`**, el predicado falla.

### sintaxis

```prolog
Condición -> Acción ; Alternativa.  % "Si Condición entonces Acción, sino Alternativa”
```

Ejemplo

```prolog
% Regla: "Si X es positivo, entonces Y es 1; sino Y es 0"
signo(X, Y) :-
(X > 0 -> Y = 1 ; Y = 0).
```

```prolog
% Consultas:
?- signo(5, Y).   % Y = 1.
?- signo(-3, Y).  % Y = 0.
```

Ejemplo 2

```prolog
% Regla: "Si X es un animal, entonces es un ser vivo; sino verifica si es un mineral"
clasificar(X) :-
(animal(X) -> writeln('Ser vivo') ; mineral(X) -> writeln('Mineral')).

% Hechos:
animal(perro).
mineral(roca).

% Consultas:
?- clasificar(perro).  % Imprime: "Ser vivo"
?- clasificar(roca).   % Imprime: "Mineral"
```

## Proyectos

1. diagnostico médico
2. buscar libros por titulo, autor o palabras clave
3. chat box ara horóscopos
4. diagnostico de fallas mecánicas

### 1 diagnostico medico

- **Objetivo**: Diagnosticar enfermedades basado en síntomas.
- **Características**:
    - Base de hechos: **`sintoma(paciente, fiebre).`**, **`enfermedad(gripe, [fiebre, tos]).`**
    - Reglas: **`diagnostico(Paciente, Enfermedad) :- sintomas_coincidentes(Paciente, Enfermedad).`**
    - Extensión: Añadir probabilidades usando bibliotecas como **`prob`** de SWI-Prolog.

### soluciones

### 2 búsqueda de libros

- **Objetivo**: Buscar libros por título, autor o palabras clave.
    
- **Base de datos**:
    
    prolog
    
    ```prolog
    libro(1, "El Principito", ["Saint-Exupéry", "fantasía"], 1943).
    ```
    
- **Reglas**:
    
    ```prolog
    **buscar_por_autor(Autor, Libro) :- libro(_, Libro, Autores, _), member(Autor, Autores).**
    ```
    

### 3 Horóscopos

- **Objetivo**: Responder preguntas sobre signos zodiacales.
- **Lógica**:
    - Hechos: **`signo(aries, fecha(21, 3), fecha(19, 4)).`**
    - Reglas interactivas: **`prediccion(Signo, "Hoy tendrás suerte en el amor").`**
    - Extensión: Conectar a Telegram con bibliotecas como **`library(http/http_client)`**.

### Recomendación de viajes

### **Sistema de Recomendación de Viajes**

- **Objetivo**: Sugerir destinos basados en preferencias.
    
- **Reglas**:
    
    prolog
    
    ```prolog
    recomendar(Usuario, Destino) :-
        prefiere(Usuario, playa),
        destino(Destino, clima(tropical)).
    ```
    
- **Dataset**: Ciudades con atributos (**`clima`**, **`actividades`**).
    
### 4 Diagnostico de fallas mecánicas

```prolog
% Síntomas comunes
sintoma(vehiculo_no_arranca).
sintoma(luces_apagadas).
sintoma(humo_escape).

% Reglas de diagnóstico
falla(bateria_descargada) :-
sintoma(vehiculo_no_arranca),
sintoma(luces_apagadas).
falla(inyector_obstruido) :-
sintoma(vehiculo_no_arranca),
sintoma(humo_escape).

% Soluciones
solucion(bateria_descargada, 'Recargar o reemplazar la batería').
solucion(inyector_obstruido, 'Limpiar inyectores o usar aditivo').
```

