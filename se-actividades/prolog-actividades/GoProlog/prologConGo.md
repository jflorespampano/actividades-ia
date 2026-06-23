# Go lang

Go es un lenguaje, conciso, limpio y eficiente. Sus mecanismos de concurrencia facilitan la escritura de programas que aprovechan al máximo las máquinas multinúcleo y en red, su sistema de tipos permite la construcción de programas modulares y flexibles. Go compila rápidamente a código de máquina, tiene recolección basura. Es un lenguaje compilado rápido, tipificado estáticamente. Sin embargo, no es orientado a objetos ni orientado a la programación visual, es muy buen lenguaje para usar en el back end de un sistema, sus capacidades para programar servidores WEB son muy buenas, también ha dado muy buenos resultados en la programación aplicaciones de plataforma cruzada.

## Instalación

* [Instale Go desde:](https://go.dev/doc/install)
* [Puede apoyares en esta liga:](https://apuntes.de/golang/)
* [Introducción a go con ejemplos de código](https://gobyexample.com/)

Despues de instalar:

Verifique instalacion
```bash
go version
```

## VScode

Usaremos el editor VSCode. Agregue el complemento **Rich Go language support for Visual Studio Code**; esta extensión nos muestra ayudas en la sintaxis del lenguaje GO y completado de código.

## Compilar y ejecutar

Creamos un hola mundo en Go

En una nueva carpeta, de preferencia en una ruta así:
`go/src/tu_usuario.github.com/nuevacarpeta` crea un archivo:

Archivo: main.go
```go
package main

import "fmt"

func main() {
    fmt.Println("Hola, mundo")
}
```

Ejecutar desde una consola de bash:
```bash
go run main.go
```

## Go y Prolog con la biblioteca Ichiban-prolog

La biblioteca **ichiban/prolog** es un motor de Prolog ISO (Organización Internacional de Normalización) escrito puramente en Go, diseñado principalmente para ser embebido como motor de scripting dentro de aplicaciones Go. Es la implementación de referencia y la más utilizada para integrar lógica declarativa en proyectos Go.

Su principal ventaja es que permite combinar la lógica de programación declarativa y de búsqueda de Prolog con la robustez y el ecosistema de Go. Es ideal para sistemas de reglas de negocio, motores de recomendación, validaciones complejas, sistemas de control de acceso (RBAC) o asistentes inteligentes.

Puede instalar la biblioteca así (pero no lo haga, le pediremos a Go que lo haga por nosotros):

```bash
go get -u github.com/ichiban/prolog@latest
```

Dejaremos la instalación de biblotecas a los comandos `go mod` y `go tidy`

|Comando	 |¿Para qué sirve?	|¿Cuándo usarlo?|
|------------|-------------------|---------------|
|go mod init	|Crea un nuevo módulo. Genera el archivo go.mod que define la raíz de tu proyecto y su ruta de importación .	|Al empezar un proyecto nuevo o cuando clonas uno que no tiene go.mod. |
|go mod tidy	|Limpia y sincroniza las dependencias. Añade los paquetes que faltan (como ichiban/prolog), elimina los que no se usan y actualiza go.sum .	|Después de cambiar las importaciones del código o de modificar go.mod manualmente. Es el comando universal del día a día .|
|go get	|Añade, actualiza o degrada una dependencia específica. Es la herramienta para elegir la versión de un paquete .	|Cuando quieres controlar finamente la versión de una dependencia concreta (ej: go get github.com/ichiban/prolog@v1.0.0) .|

### Crear proyecto

Crea una nueva carpeta en tu espacio de trabajo (yo cree una y le puse por nombre: prolog_cursos) y ábrala con Code.

Cuando en en un proyecto use paquetes de go (bibliotecas) le pediremos a go que administre las bibliotecas, para eso abra una terminal *bash* en su nueva carpeta y escriba el comando:

```bash
go mod init prolog_cursos
```
Esto crea el archivo *go.mod* y si lo abre en code verá:

```go
module github.com/jflorespampano/prolog_cursos

go 1.18
```

Aquí se irán registrando los paquetes externos que requiera su aplicación y sus versiones. Ahí dice por ejemplo donde se ubica nuestra aplicación y la versión de go con que se compiló. Usted no deberá modificar este archivo, go lo administrará por usted.


Cree el archivo: main.go con el código:

Archivo: main.go
```go
package main
import (
    "fmt"
    "os"
    "github.com/ichiban/prolog"
)
func main() {

}

```

En su terminal bash escriba:
```bash
go mod tidy
```
Este comando actualiza las dependencias de su código en Go con las de sus bibliotecas (en nuestro caso cargara ichiban/prolog).

### Agregando hechos
Veamos ahora como ingresar una base de conocimiento y hacer consultas, Agregue a su archivo *main.go* el siguiente código después de la función main, y en la función main llame a la función proyectos():

Archivo: main.go
```go
package main
import (
    "fmt"
    "os"
    "github.com/ichiban/prolog"
)
func main() {
    proyectos()
}

func proyectos() {
    p := prolog.New(os.Stdin, os.Stdout)
    if err := p.Exec(`
        %hechos
        nivel(ana,tecnico).
        nivel(juan,pasante).
        nivel(luis,tuitulado).
        nivel(rosa,maestria).
        certificado_en(ana,c).
        certificado_en(rosa,php).
        certificado_en(ana,js).
        certificado_en(juan,c).
    `); err != nil {
        panic(err)
    }
    // Consultar el nivel de Luis
    sols, err := p.Query(`nivel(luis, Nivel).`)
    if err != nil {
        panic(err)
    }
    defer sols.Close()
    
    // Procesar los resultados
    encontrado := false
    for sols.Next() {
        // Prepare una struct con campos con nombre que 
        // corresponden con una variable en el query.
        var resultado struct{ Nivel string }
        if err := sols.Scan(&resultado); err != nil {
            panic(err)
        }
        fmt.Printf("El nivel de Luis es: %s\n", resultado.Nivel)
        encontrado = true
    }
    
    if !encontrado {
        fmt.Println("No se encontró información para Luis")
    }
    
    // Verificar errores de la consulta
    if err := sols.Err(); err != nil {
        panic(err)
    }
}
```


Ejecute así:
```bash
go run main.go
# salida: El nivel de Luis es: tuitulado
```

### Agregando reglas

Archivo: main.go
```go
package main
import (
    "fmt"
    "os"
    "github.com/ichiban/prolog"
)
func main() {
    proyectos()
}

func proyectos() {
    p := prolog.New(os.Stdin, os.Stdout)
    if err := p.Exec(`
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
        puede_proyecto1:-programadorjr(X),programadorsr(Y),X\=Y.
        puede_proyecto2:-programadorsr(X),programadorsr(Y),X\=Y.
        puede_proyecto3:-lider(X),programadorsr(Y),X\=Y.
    `); err != nil {
        panic(err)
    }
    // Primero, asegurémonos de que la regla funciona consultando directamente
    sols, err := p.Query(`certificado_en(rosa, C).`)
    if err != nil {
        panic(err)
    }
    defer sols.Close()

    for sols.Next() {
        var resultado struct{ C string }
        if err := sols.Scan(&resultado); err != nil {
            panic(err)
        }
        fmt.Printf("Rosa tiene certificado: %s\n", resultado.C)
    }
}

```

### Resumen: Como usar Ichiban

El proceso es muy similar a cómo interactuarías con una base de datos usando el paquete database/sql, lo que lo hace familiar para programadores de Go.

1. Crear el Intérprete. Primero, instancias un motor de Prolog. Puedes decidir si quieres que tenga acceso a la entrada/salida estándar (para write, read, etc.) o no.
   ```go
   import "github.com/ichiban/prolog"

    // Crea un interprete sin entrada/salida estándar (útil para la mayoría de los casos)
    p := prolog.New(nil, nil)
   ```

Si necesitas un entorno más seguro y aislado (sandbox), puedes crear un interprete sin ningún predicado predefinido
```go
p := new(prolog.Interpreter) // Sandbox
```

2. Cargar la Base de Conocimiento. Usa el método Exec para cargar tu programa Prolog. Aquí defines los hechos y las reglas.
   ```go
   err := p.Exec(`
        % Hechos: Socrates es humano.
        humano(socrates).

        % Regla: Alguien es mortal si es humano.
        mortal(X) :- humano(X).
    `)
    if err != nil {
        panic(err)
    }
   ```
Puedes usar el placeholder ? para inyectar valores desde Go a tu código Prolog, igual que en database/sql
```go
nombre := "socrates"
err = p.Exec(`humano(?).`, nombre) // Es equivalente a escribir humano(socrates).
```

3. Realizar Consultas (Hacer Preguntas)
Este es el corazón de la interacción. Usas Query para hacer una pregunta a tu base de conocimiento. El resultado es un iterador (Solutions) sobre las posibles respuestas.

A. Consulta Simple (Sí/No):
Preguntas si algo es cierto.
```go
sols, err := p.Query(`mortal(socrates).`) // ¿Es Socrates mortal?
if err != nil {
    panic(err)
}
defer sols.Close()

if sols.Next() {
    fmt.Println("Sí, Socrates es mortal.")
}
```

B. Consulta con Variables:
Preguntas "¿quién cumple con una condición?". Usas variables (que empiezan con mayúscula, como Who).

```go
// Pregunta: "¿Quién es mortal?"
sols, err := p.Query(`mortal(Who).`)
if err != nil {
    panic(err)
}
defer sols.Close()

// Itera sobre todas las soluciones que el motor de Prolog encuentre.
for sols.Next() {
    var resultado struct {
        Who string // El campo 'Who' debe coincidir con la variable de la consulta.
    }
    // Scan llena la variable 'resultado' con los valores de la solución.
    if err := sols.Scan(&resultado); err != nil {
        panic(err)
    }
    fmt.Printf("Respuesta: %s es mortal.\n", resultado.Who)
}
// Output: Respuesta: socrates es mortal.
```

1. Integración Avanzada: Llamar a Go desde Prolog
ichiban/prolog permite extender el lenguaje definiendo predicados personalizados en Go. Esto es increíblemente poderoso, ya que te permite usar cualquier funcionalidad de Go (llamadas a APIs, cálculos complejos, etc.) como si fuera parte de la lógica Prolog.

Por ejemplo, aquí se registra un predicado get_status/2 que, desde Prolog, puede hacer una petición HTTP:

```go
// p es el interprete prolog.New(...)
p.Register2("get_status", func(url, status term.Interface, k func(*term.Env) *nondet.Promise, env *term.Env) *nondet.Promise {
    // 1. Obtener la URL del argumento
    u, ok := env.Resolve(url).(term.Atom)
    if !ok {
        return nondet.Error(fmt.Errorf("URL inválida"))
    }

    // 2. Ejecutar la lógica en Go (hacer la petición HTTP)
    resp, err := http.Get(string(u))
    if err != nil {
        return nondet.Error(err)
    }

    // 3. Unificar el resultado (status code) con la segunda variable.
    env, ok = status.Unify(term.Integer(resp.StatusCode), false, env)
    if !ok {
        return nondet.Bool(false)
    }

    // 4. Continuar con la ejecución de Prolog.
    return k(env)
})

// Ahora, desde una consulta Prolog, puedes usar get_status/2
// Nota el uso de '?' para pasar la URL desde Go.
sols, _ := p.Query(`get_status(?, Status), Status = 200.`, "https://httpbin.org/status/200")
```

## Ejemplo programadores y proyectos mejorado

```go
package main
import (
    "fmt"
    "os"
    "github.com/ichiban/prolog"
)
func main() {
    p := getBaseConocimiento()
	fmt.Println("Consultando quién puede ejecutar el proyecto 1:")
	consulta_quien_puede_ejecutar_p1(p)
	fmt.Println("\nConsultando los certificados de Rosa:")
	getCertificado(p,"rosa")
}

// consulta_quien_puede_ejecutar_p1 devuelve tanto el programador JR como el programador SR para el proyecto 1
func consulta_quien_puede_ejecutar_p1(p *prolog.Interpreter) {
    // Consultamos quiénes pueden trabajar en el proyecto 1
    sols, err := p.Query(`puede_proyecto1(X, Y).`)
    if err != nil {
        panic(err)
    }
    defer sols.Close()
    
    // Consumimos los resultados
    fmt.Println("Proyecto 1 - Parejas posibles:")
    for sols.Next() {
        var resultado struct {
            X string
            Y string
        }
        if err := sols.Scan(&resultado); err != nil {
            panic(err)
        }
        fmt.Printf("Programador JR: %s, Programador SR: %s\n", resultado.X, resultado.Y)
    }
    
    if err := sols.Err(); err != nil {
        panic(err)
    }
}

// getCertificado consulta los certificados de una persona específica
func getCertificado(p *prolog.Interpreter, persona string) {
    // sols, err := p.Query(`certificado_en(?, Certificado).`, persona)
	// este no funciono: En Prolog, los átomos se escriben sin comillas. 
	// Cuando pasas "rosa" desde Go, puede que se esté interpretando como 'rosa' (con comillas) y no coincida con rosa (sin comillas).
	// solución: Asegúrate de que el valor que pasas desde Go se interprete correctamente como un átomo en Prolog.
	consulta := fmt.Sprintf(`certificado_en(%s, Certificado).`, persona)
    sols, err := p.Query(consulta)
	//sols, err := p.Query(`certificado_en(rosa, C).`)
	if err != nil {
		panic(err)
	}
	defer sols.Close()
	
	for sols.Next() {
        var resultado struct{ Certificado string }
        if err := sols.Scan(&resultado); err != nil {
            panic(err)
        }
        fmt.Printf("%s tiene certificado en: %s\n", persona, resultado.Certificado)
    }
}

// getBaseConocimiento inicializa el intérprete de Prolog y carga la base de conocimiento con hechos y reglas
func getBaseConocimiento() *prolog.Interpreter {
	p := prolog.New(os.Stdin, os.Stdout)
    if err := p.Exec(`
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
    `); err != nil {
        panic(err)
    }
	return p
}

```

## Apoyos
* [ichiban prolog](https://github.com/ichiban/prolog)
* [Para entender el funcionamiento del if en Go vea:](https://gobyexample.com/if-else)
* [Para ver funciones que devuelven múltiples valores en go ver:](https://gobyexample.com/multiplereturn-values)
* [Para ver inicialización de variables en Go ver:](https://gobyexample.com/variables)
* [Para ver el uso de la función defer() en Go ver:](https://gobyexample.com/defer)