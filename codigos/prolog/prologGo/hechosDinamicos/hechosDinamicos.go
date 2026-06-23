package main

import (
	"context"
	"fmt"
	"log"

	"github.com/ichiban/prolog"
)

func agregarHechoG(i *prolog.Interpreter) {
	// 1. CREAR EL CONTEXTO REQUERIDO POR LA LIBRERÍA
	ctx := context.Background()

	// 2. Declarar el predicado como dinámico pasándole 'ctx'
	err := i.Exec(ctx, ":- discontiguous(padre/2).")
	if err != nil {
		log.Fatalf("Error al declarar predicado discontiguous: %v", err)
	}
	
	err = i.Exec(ctx, ":- dynamic(padre/2).")
	if err != nil {
		log.Fatalf("Error al declarar predicado dinámico: %v", err)
	}

	// 3. Agregar hechos de manera dinámica pasándole 'ctx'
	hechos := []string{
		"assertz(padre(carlos, braian)).",
		"assertz(padre(luis, kevin)).",
	}

	for _, hecho := range hechos {
		err := i.Exec(ctx, hecho) // <-- ctx agregado aquí
		if err != nil {
			log.Fatalf("Error al insertar el hecho %s: %v", hecho, err)
		}
	}
	fmt.Println("✅ Hechos agregados dinámicamente con éxito.")

	// 4. Consultar los hechos dinámicos
	persona := "carlos"
	// Usamos comillas normales para evitar que se cuelen saltos de línea invisibles
	consulta := fmt.Sprintf("padre(%s, X).", persona)
	
	fmt.Printf("\nConsultando: %s", consulta)
	
	// <-- Cambiado i.Query(consulta) por i.Query(ctx, consulta)
	sols, err := i.Query(ctx, consulta) 
	if err != nil {
		log.Fatalf("Error al realizar la consulta: %v", err)
	}
	defer sols.Close()

	fmt.Println("\nResultados de la consulta (Hijos de carlos):")
	for sols.Next() {
		// Tu struct con el tag de mapeo está perfecto, ahora sí se llenará
		var resultado struct {
			X string `prolog:"X"`
		}
		
		if err := sols.Scan(&resultado); err != nil {
			log.Fatalf("Error al escanear solución: %v", err)
		}
		fmt.Printf("- %s\n", resultado.X)
	}

	if err := sols.Err(); err != nil {
		log.Fatalf("Error durante la iteración: %v", err)
	}
}

func main() {
	i := prolog.New()
	agregarHechoG(i)
}
