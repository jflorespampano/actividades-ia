package main

import (
	"fmt"
	"log"

	"github.com/ichiban/prolog"
)

func main() {
	// Crear un nuevo intérprete Prolog
	pl := prolog.New(nil,nil)

	// ============================================
	// 1. CONSULTAR hechos iniciales (estáticos)
	// ============================================
	fmt.Println("=== CONSULTANDO HECHOS INICIALES ===")
	
	// Consultar hechos iniciales
	if err := pl.Exec(`
		% Declarar predicados como dinámicos
		:- dynamic padre/2.
		:- dynamic madre/2.
		:- dynamic edad/2.
		
		%
		% Hechos sobre relaciones familiares
		padre(juan, maria).
		padre(juan, carlos).
		padre(carlos, luis).
		madre(ana, maria).
		madre(ana, carlos).
		madre(luisa, luis).
		
		% Regla: abuelo(X, Y) si X es padre/madre de Z y Z es padre/madre de Y
		abuelo(X, Y) :- padre(X, Z), padre(Z, Y).
		abuelo(X, Y) :- padre(X, Z), madre(Z, Y).
		abuelo(X, Y) :- madre(X, Z), padre(Z, Y).
		abuelo(X, Y) :- madre(X, Z), madre(Z, Y).
	`); err != nil {
		log.Fatal(err)
	}

	// Consultar: ¿Quién es abuelo de luis?
	fmt.Println("\nAbuelos de luis:")
	sols, err := pl.Query(`abuelo(X, luis).`)
	if err != nil {
		log.Fatal(err)
	}
	defer sols.Close()

	for sols.Next() {
		var x string
		if err := sols.Scan(&x); err != nil {
			log.Fatal(err)
		}
		fmt.Printf("  %s es abuelo de luis\n", x)
	}
	if err := sols.Err(); err != nil {
		log.Fatal(err)
	}

	// ============================================
	// 2. AGREGAR hechos dinámicamente
	// ============================================
	fmt.Println("\n=== AGREGANDO HECHOS DINÁMICAMENTE ===")

	// Agregar nuevos hechos
	fmt.Println("Agregando: madre(maria, pedro)")
	if err := pl.Exec(`assertz(madre(maria, pedro)).`); err != nil {
		log.Fatal(err)
	}
	
	fmt.Println("Agregando: padre(pedro, sofia)")
	if err := pl.Exec(`assertz(padre(pedro, sofia)).`); err != nil {
		log.Fatal(err)
	}

	// Verificar que se agregaron correctamente
	fmt.Println("\nVerificando hechos agregados:")
	sols2, err := pl.Query(`madre(maria, pedro).`)
	if err != nil {
		log.Fatal(err)
	}
	defer sols2.Close()
	
	if sols2.Next() {
		fmt.Println("  ✓ madre(maria, pedro) existe")
	}
	if err := sols2.Err(); err != nil {
		log.Fatal(err)
	}

	// ============================================
	// 3. CONSULTAR con los nuevos hechos
	// ============================================
	fmt.Println("\n=== CONSULTANDO CON NUEVOS HECHOS ===")
	
	// ¿Quién es abuelo de sofia?
	fmt.Println("\nAbuelos de sofia (con hechos agregados):")
	sols3, err := pl.Query(`abuelo(X, sofia).`)
	if err != nil {
		log.Fatal(err)
	}
	defer sols3.Close()

	for sols3.Next() {
		var x string
		if err := sols3.Scan(&x); err != nil {
			log.Fatal(err)
		}
		fmt.Printf("  %s es abuelo de sofia\n", x)
	}
	if err := sols3.Err(); err != nil {
		log.Fatal(err)
	}

	// // ============================================
	// // 4. AGREGAR MÚLTIPLES HECHOS
	// // ============================================
	// fmt.Println("\n=== AGREGANDO MÚLTIPLES HECHOS ===")
	
	// // Agregar varios hechos a la vez
	// nuevosHechos := `
	// 	edad(juan, 65).
	// 	edad(ana, 60).
	// 	edad(carlos, 40).
	// 	edad(maria, 35).
	// `
	
	// fmt.Println("Agregando hechos de edad:")
	// if err := pl.Exec(nuevosHechos); err != nil {
	// 	log.Fatal(err)
	// }

	// // Consultar todas las edades
	// fmt.Println("\nEdades registradas:")
	// sols4, err := pl.Query(`edad(Persona, Edad).`)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// defer sols4.Close()

	// for sols4.Next() {
	// 	var persona string
	// 	var edad int
	// 	if err := sols4.Scan(&persona, &edad); err != nil {
	// 		log.Fatal(err)
	// 	}
	// 	fmt.Printf("  %s tiene %d años\n", persona, edad)
	// }
	// if err := sols4.Err(); err != nil {
	// 	log.Fatal(err)
	// }

	// // ============================================
	// // 5. REGLAS DINÁMICAS
	// // ============================================
	// fmt.Println("\n=== AGREGANDO REGLAS DINÁMICAS ===")
	
	// // Agregar una nueva regla
	// fmt.Println("Agregando regla: mayor_de_edad(X) :- edad(X, E), E >= 18")
	// if err := pl.Exec(`
	// 	mayor_de_edad(X) :- edad(X, E), E >= 18.
	// `); err != nil {
	// 	log.Fatal(err)
	// }

	// // Consultar quiénes son mayores de edad
	// fmt.Println("\nPersonas mayores de edad:")
	// sols5, err := pl.Query(`mayor_de_edad(X).`)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// defer sols5.Close()

	// for sols5.Next() {
	// 	var x string
	// 	if err := sols5.Scan(&x); err != nil {
	// 		log.Fatal(err)
	// 	}
	// 	fmt.Printf("  %s es mayor de edad\n", x)
	// }
	// if err := sols5.Err(); err != nil {
	// 	log.Fatal(err)
	// }

	// // ============================================
	// // 6. ELIMINAR HECHOS
	// // ============================================
	// fmt.Println("\n=== ELIMINANDO HECHOS ===")
	
	// // Eliminar un hecho
	// fmt.Println("Eliminando: edad(juan, 65)")
	// if err := pl.Exec(`retract(edad(juan, 65)).`); err != nil {
	// 	log.Fatal(err)
	// }

	// // Verificar que se eliminó
	// fmt.Println("\nEdades después de eliminar a juan:")
	// sols6, err := pl.Query(`edad(Persona, Edad).`)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// defer sols6.Close()

	// for sols6.Next() {
	// 	var persona string
	// 	var edad int
	// 	if err := sols6.Scan(&persona, &edad); err != nil {
	// 		log.Fatal(err)
	// 	}
	// 	fmt.Printf("  %s tiene %d años\n", persona, edad)
	// }
	// if err := sols6.Err(); err != nil {
	// 	log.Fatal(err)
	// }
}