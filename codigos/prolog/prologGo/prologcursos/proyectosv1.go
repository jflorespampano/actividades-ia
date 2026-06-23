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
	consulta_quien_puede_ejecutar_p1(p)
	fmt.Println("\nConsultando los certificados de Rosa:")
	getCertificado(p,"rosa")
}

// consulta_quien_puede_ejecutar_p1  consulta quiénes pueden ejecutar el proyecto 1, mostrando tanto el programador JR como el programador SR.  
// Retorna tanto el programador JR como el programador SR para el proyecto 1
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
