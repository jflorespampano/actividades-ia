// Package main es el punto de entrada principal de la aplicación.
// Este paquete inicializa el intérprete de Prolog, carga la base de conocimiento
// y ejecuta las consultas para determinar qué programadores pueden trabajar
// en diferentes proyectos y sus certificaciones.
//
// # Uso
//
//   go run main.go
//
// La aplicación mostrará en consola:
//   - Las parejas de programadores (JR y SR) que pueden trabajar en el proyecto 1
//   - Los certificados de las personas consultadas
//
// # Base de conocimiento
//
// La base de conocimiento incluye hechos sobre:
//   - Niveles de programadores (técnico, pasante, titulado, maestría)
//   - Certificaciones de cada persona
//   - Reglas para determinar programadores JR, SR y líderes
package main
import (
    "fmt"
    "os"
    "github.com/ichiban/prolog"
)

func main() {
	p := getBaseConocimiento()
    
    fmt.Println("Consultando quién puede ejecutar el proyecto 1:")
    parejas := consulta_quien_puede_ejecutar_p1(p)
    
    // Imprimir resultados
    for i, pareja := range parejas {
        fmt.Printf("Pareja %d: JR: %s, SR: %s\n", i+1, pareja.JR, pareja.SR)
    }
    
	fmt.Println("\nConsultando los certificados de Rosa:")
    certificados := getCertificado(p, "rosa")
    
    // Mostrar resultados
    if len(certificados) == 0 {
        fmt.Println("Rosa no tiene certificados")
    } else {
        fmt.Printf("Rosa tiene %d certificado(s):\n", len(certificados))
        for i, cert := range certificados {
            fmt.Printf("  %d. %s\n", i+1, cert)
        }
    }
    
}

// PersonaProyecto representa una pareja de programadores para un proyecto
type PersonaProyecto struct {
    JR string
    SR string
}

// consulta_quien_puede_ejecutar_p1 consulta quiénes pueden ejecutar el proyecto 1.
// devuelve un slice con todas las parejas (JR, SR) que pueden trabajar en el proyecto 1.
func consulta_quien_puede_ejecutar_p1(p *prolog.Interpreter) []PersonaProyecto {
    var resultados []PersonaProyecto
    
    sols, err := p.Query(`puede_proyecto1(X, Y).`)
    if err != nil {
        panic(err)
    }
    defer sols.Close()
    
    for sols.Next() {
        var resultado struct {
            X string
            Y string
        }
        if err := sols.Scan(&resultado); err != nil {
            panic(err)
        }
        
        // Agregar al slice
        resultados = append(resultados, PersonaProyecto{
            JR: resultado.X,
            SR: resultado.Y,
        })
    }
    
    if err := sols.Err(); err != nil {
        panic(err)
    }
    
    return resultados
}

// getCertificado consulta los certificados de una persona específica.
// Retorna un slice con todos los certificados que tiene la persona.
func getCertificado(p *prolog.Interpreter, persona string) []string {
    var certificados []string
    
    consulta := fmt.Sprintf(`certificado_en(%s, Certificado).`, persona)
    sols, err := p.Query(consulta)
    if err != nil {
        panic(err)
    }
    defer sols.Close()
    
    for sols.Next() {
        var resultado struct{ Certificado string }
        if err := sols.Scan(&resultado); err != nil {
            panic(err)
        }
        certificados = append(certificados, resultado.Certificado)
    }
    
    if err := sols.Err(); err != nil {
        panic(err)
    }
    
    return certificados
}

// getBaseConocimiento inicializa el intérprete de Prolog y carga la base de conocimiento con hechos y reglas.
// Aquí se definen los hechos y reglas de Prolog que representan el conocimiento sobre los programadores, sus niveles, certificados y las reglas para determinar quién puede trabajar en cada proyecto.	
// devuelve un intérprete de Prolog listo para ser consultado.
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