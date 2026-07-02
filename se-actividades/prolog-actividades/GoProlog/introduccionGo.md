# Introducción GoLang 

Go es un lenguaje, conciso, limpio y eficiente. Sus mecanismos de concurrencia facilitan la escritura de programas que aprovechan al máximo las máquinas multinúcleo y en red, su sistema de tipos permite la construcción de programas modulares y flexibles. Go compila rápidamente a código de máquina, tiene recolección basura, es un lenguaje compilado, rápido y tipificado estáticamente. 

# Instalar GoLang 

* Instale Go desde: https://go.dev/doc/install  
* Para ayuda en la instalación puede apoyares en esta liga:  
https://apuntes.de/golang/instalacion-de-golang-en-windows/#gsc.tab=0

Verifique instalacion
```bash
go version
```


### Estilo clasico de Configurar su Espacio de trabajo de Go 

>Nota: (esta sección es opcional) Puede saltar esta parte e ir directamente a la sección **Estilo moderno**.

En los primeros días de Go, no existía el go.mod. Todo el código debía vivir dentro de un directorio especial llamado workspace, cuya ubicación apuntaba la variable de entorno GOPATH. Este workspace tenía una estructura fija e inamovible con tres directorios principales:

src/: Aquí es donde tú escribías el código fuente de tus proyectos. Cada proyecto (o paquete) era una subcarpeta dentro de src, usualmente siguiendo la ruta de su repositorio remoto (ej: src/github.com/tu-usuario/mi-proyecto).

pkg/: Almacenaba los archivos objeto compilados (.a). Go guardaba aquí el resultado de compilar tus paquetes para no tener que recompilarlos cada vez, acelerando así el proceso de compilación.

bin/: Guardaba los binarios ejecutables que generabas al compilar un programa (un package main). Cuando ejecutabas go install, el ejecutable aparecía aqu

```text
~/go/                     # Esta es tu carpeta $GOPATH
|-- bin/
|   `-- mi-proyecto       # El ejecutable resultante
|-- pkg/
|   `-- linux_amd64/      # Archivos objeto (dependen de la plataforma)
|       `-- github.com/tu-usuario/mi-proyecto/
`-- src/
    `-- github.com/
        `-- tu-usuario/
            `-- mi-proyecto/   # Aquí dentro estaba tu código
                |-- go.mod     # (llegó después)
                |-- main.go
                `-- ...
```

### Configuracion de go estilo viejo (no usaremos este estilo)

GOROOT: Es el directorio donde está instalado el SDK de Go (las herramientas y librerías estándar del lenguaje). Es como la fábrica que te proporciona las piezas básicas. No debes modificarlo. Contiene el código fuente de la biblioteca estándar.

GOPATH: Es el directorio de tu espacio de trabajo personal, donde guardas el código de tus propios proyectos, las librerías de terceros que descargas y los binarios que compilas. Es como tu taller donde creas tus propios programas. Aquí es donde residen tus carpetas src, pkg y bin.

En el desarrollo moderno con Go Modules, la carpeta src ya no es un requisito estricto para tus proyectos, pero la variable de entorno GOPATH y su estructura de pkg y bin siguen siendo muy utilizadas.


Verificar GOPATH y GOROOT.

En una consolo pruebe:
```bahs
echo $GOPATH

eho $GOROOT
```

Para ver el espacio de trabajo que Go configuró en su instalación, debemos ver la variable $GOPATH, para ver el contenido de esta variable de ambiente: En Windows si usa una ventana de cmd o power Shell, escriba (go env) 

```bash
go env 
```

Verá la lista de configuraciones entre ellas la carpeta de desarrollo(GOPATH), esta es la carpeta de trabajo para sus proyectos por ejemplo la mía es: C:\Users\Docente\go

También puede ejecutar en cmd o power Shell el siguiente comando para ver la variable de 
ambiente GOPATH:

```bash
echo %GOPATH%
```


## Estilo moderno (el que usaremos)

Los Módulos (Estilo Moderno y Recomendado): Desde Go 1.11, esta es la forma estándar y más flexible de manejar proyectos. No te obliga a guardar tu código en una ubicación concreta; puedes crearlo en cualquier carpeta de tu computadora. Además, gestiona las dependencias y versiones de forma mucho más eficiente. Por todo ello, es la práctica recomendada por la comunidad hoy en día para cualquier proyecto nuevo. Si eliges usar Módulos (la opción recomendada) no es necesario que configures manualmente el GOPATH. Puedes crear tu proyecto en cualquier directorio y el propio sistema de módulos gestiona las dependencias de forma local en el proyecto, a través del archivo go.mod. Puedes ignorar esta variable ($GOPATH) para empezar.

>Nota: usaremos el estilo moderno


## VScode

Agregue el complemento **Rich Go language support for Visual Studio Code**; esta extensión nos muestra ayudas en la sintaxis del lenguaje GO y completado de código.

## Compilar y ejecutar

Creamos un hola mundo en Go

Archivo: main.go
```go
package main

import "fmt"

func main() {
    fmt.Println("Hola, mundo")
}
```

Ejecutar:
```bash
go run main.go
```

## Elementos del lenguaje 

### 1 Variables y constantes 

Declarar variables en go

|item   |sentencia      | decripcion    |
|-------|---------------|-----------------------------------|
|1      |var i int      | Declara la variable  entera i |
|2      |var i int = 10 | Declara e inicializa la variable entera i a 10 |
|3      |i:=10          | Declara e inicializa la variable entera i a 10, en este caso go infiere el tipo de la variable, no puede utilizarse para variables globales. |
|4      |i:=int64(1)    | Si no desea que go infiera el tipo de la variable pero si quiere usar := use un cast() |



>Nota: Como parte de las convenciones de la comunidad de desarrollo de GO, si declara una variable sin inicializar use la forma 1, si declara e inicializa una variable use la forma 3 en lugar de la forma 2. 

Ejemplo de declarar variables 

```go
var ( 
    nombre tipo
    nombre2 tipo
    nombre3 tipo
)
//ejemplo
var ( 
    a = 1
    b = “hola”
    c = true
)

nombre := expresión 
//ejemplo
a:=5 
b:=6 

//asignación
a,b = b,a
```



Constantes: 

`const nombre = "Sammy" `
 
### 2 Objetos en Go 

```go
package main 
 
import "fmt" 
 
type Persona struct { 
    Nombre string 
    Edad   int 
    Activo bool 
} 
 
func (p Persona) presentarse() { 
    if p.Activo { 
        fmt.Printf("Hola, mi nombre es %s y tengo %d años\n", p.Nombre, p.Edad) 
    } 
} 
 
func main() { 
    persona := Persona{"Orlando", 26, true} 
    persona.presentarse() 
} 
```

Desglose sintáctico:

|Parte	|Significado |
|-------|------------|
|func	|Palabra clave para definir una función|
|(p Persona)	|Receptor - esto es lo que hace que sea un método de Persona|
|presentarse()	|Nombre del método|
|{ ... }	|Cuerpo de la función|

El receptor (p Persona):
* p: Variable que recibe la instancia de Persona (como this o self en otros lenguajes)
* Persona: Tipo al que pertenece este método
 
### 3 Apuntadores 
 
### 4 Sentencias 

If

```go
    if 7%2 == 0 { 
        fmt.Println("7 is even") 
    } else { 
        fmt.Println("7 is odd") 
    } 
 
    if 8%4 == 0 { 
        fmt.Println("8 is divisible by 4") 
    } 
 
    if num := 9; num < 0 { 
        fmt.Println(num, "is negative") 
    } else if num < 10 { 
        fmt.Println(num, "has 1 digit") 
    } else { 
        fmt.Println(num, "has multiple digits") 
    } 

```
 
### 5 Funciones 

Tabla resumen de sintaxis:

|Tipo	|Sintaxis|
|-------|--------|
|Básica	|func nombre(p tipo) tipo {}|
|Múltiples retornos	|func nombre(p tipo) (tipo1, tipo2) {}|
|Parámetros variádicos	|func nombre(p ...tipo) {}|
|Con nombre en retorno	|func nombre() (x int) {}|
|Método	|func (r Receptor) nombre() {}|
|Anónima	|func(p tipo) tipo {}(valor)|

Los parámetros variádicos (o funciones variádicas) son aquellos que permiten recibir un número variable de argumentos del mismo tipo. En Go, se indican con tres puntos ... antes del tipo.

Funcion con nombre en retorno
```go
func nombreFuncion() (nombre1 Tipo1, nombre2 Tipo2) {
    // Los valores ya están inicializados con su valor cero
    nombre1 = valor1
    nombre2 = valor2
    return  // Return vacío (retorna los valores nombrados)
}
```

Funcion anónima
```go
func() {
    // Cuerpo de la función
}()

// Con parámetros
func(param1 Tipo1, param2 Tipo2) TipoRetorno {
    // Cuerpo
}(argumento1, argumento2)
```

En go las funciones pueden devolver más de un valor 

```go
package main 
 
import "fmt" 
 
const Pi = 3.1416 
 
func circulo(radio float64) (area float64, perimetro float64) { 
    area = Pi * radio * radio 
    perimetro = 2 * Pi * radio 
    return area, perimetro 
} 
 
func main() { 
    a, p := circulo(8) 
    fmt.Println("El area del circulo es: ", a) 
    fmt.Println("El perimetro del circulo es: ", p) 
} 

```
 
### 6 Arreglos 

Arreglos de string: 

```go
names := [4]string{"Mary", "John", "Bob", "Anna"} 
 
//Recorrer el arreglo 
for i, n := range names { 
 fmt.Printf("index: %d = %q\n", i, n) 
} 
for i := 0; i < len(names); i++ { 
    fmt.Println(names [i]) 
} 
 
//2 ejemplos de declaración de arreglos 
var nombres [5]string 
 
nombres[0] = "Ana" 
nombres[1] = "José" 
nombres[2] = "Daniel" 
nombres[3] = "María" 
nombres[4] = "Carlos" 
nombres := [5]string{"Ana", "José", "Daniel", "María", "Carlos"} 

```
 
 
### 7 Ciclos 

```go
//El único ciclo en Go es for: 
for i < 10 { 
    fmt.Println("Valor de i:", i) 
    i++ 
} 
for i=0 ; i < 10; i++ { 
    fmt.Println("Valor de i:", i) 
} 
arreglo:=[7]int{0,1,4,6,10,9} 
for i, j:= range arreglo{ 
    fmt.Printf("Valor de j: %d en vuelta #%d\n", j,i) 
} 
for i:= range arreglo{ 
    fmt.Printf("Valor de i: %d\n", i) 
} 
for i:=0 ; i < 10; i++ { 
    fmt.Printf("Valor de i: %d", i) 
    if i == 7{ 
      fmt.Printf(" así que saldremos del ciclo...\n") 
      break 
    } 
    fmt.Printf("\n") 
} 
for i < 10 { 
    fmt.Printf("Valor de i: %d", i) 
    if i == 6{ 
      fmt.Printf(" sumaremos 3\n") 
      i = i + 3 
      continue 
    } 
    fmt.Printf("...\n") 
    i++ 
} 

```
 
### 8 Slices 
### 9 Mapas 
### 10 Estructuras 

### 11 Interfaces 

Las interfaces son conjuntos de firmas de métodos bajo un nombre. (https://gobyexample.com/interfaces ), las firmas de métodos son solo los encabezados de los métodos, donde se define su nombre, parámetros que recibe y datos que devuelve, se declaran así:


Declarar una interfaz 

```go
//interfaz que define la estructura de las funciones area() y perim() 
type figura interface { 
    area() float64 
    perim() float64 
} 

```
Ahora cuando tiene una estructura, por ejemplo: 

```go
//Declarar estructura recta 
//estructura recta 
type recta struct { 
    base float64 
    altura float64 
} 

```

Para implementar la interfaz figura en la estructura recta, solo debemos agregar a nuestra 
estructura, todas las firmas de métodos declaradas en la interfaz: 

```go
//Implementar la interfaz en nuestra estructura recta 
func (r recta) area() float64 { 
    return r.base * r.altura 
} 
func (r recta) perim() float64 { 
    return 2*r.base + 2*r.altura 
} 

```

Ventajas: Suponga ahora que tenemos otra figura, la figura circulo: 

```go
//Declarar estructura circulo 
//estructura circulo 
type circulo struct{ 
    radio float64 
} 

//Implementar la interfaz en nuestra estructura  
func (c circulo) area () float64 { 
    return math.Pi * c.radio * c.radio 
} 
func (c circulo) perim() float64 { 
    return 2 * math.Pi * c.radio 
} 

```
Ahora suponga que quiere mostrar el área y perímetro de una figura sin importar de que figura se trate:

```go
//Usar la interfaz 
func muestraMedidas(g figura) { 
    fmt.Println("datos de la figura:", g) 
    fmt.Println("area de figura:", g.area()) 
    fmt.Println("perimetro de figura:", g.perim()) 
} 
func main() { 
    r := recta{base: 3, altura: 4} 
    c := circulo{radio: 5} 
    muestraMedidas(r) 
    muestraMedidas(c) 
} 

```

#### tipos personalizados: 

```go
package main 
import "fmt" 

type hora int 

func (h hora) aminutos() int { 
    return int(h * 60) 
} 
func main() { 
    h := hora(2) //hacemos un casting para convertir 2 en el tipo hora 
    fmt.Println("minutos", h.aminutos()) 
} 
```

Podemos crear un tipo a partir de otro y agregarle funcionalidad a ese nuevo tipo. Aquí estamos 
creando el tipo hora como un entero: 

`type hora int `

la función: `func (h hora) aminutos int{…} ` es una función que estamos agregando al tipo hora y que devuelve un entero, y el código interior dice que: 

`return int(h * 60) `

la función devuelve el valor h del dato donde fue llamado y devuelve un entero de ese valor 
multiplicado por 60. 
