package main
import (
    "fmt"
	"log"
    "os"
	"strings"
    "github.com/ichiban/prolog"
)
func main() {
	p := getBaseConocimiento()

	consultarAbuelo(p, "luis")
	agregarHechoG(p)
	// consultarPadre(p, "rocio")

    
}

func agregarHechoG(i *prolog.Interpreter) {
	// 2. Declarar el predicado como dinámico
	err := i.Exec(":- discontiguous(padre/2).")
	if err != nil {
		log.Fatalf("Error al declarar predicado dinámico: %v", err)
	}
	// Esto es obligatorio antes de usar asserta o assertz
	err = i.Exec(":- dynamic(padre/2).")
	if err != nil {
		log.Fatalf("Error al declarar predicado dinámico: %v", err)
	}


	// 3. Agregar hechos de manera dinámica (assertz agrega al final)
	// Sintaxis: padre(padre, hijo)
	hechos := []string{
		"assertz(padre(carlos, braian)).",
		"assertz(padre(luis, kevin)).",
	}

	for _, hecho := range hechos {
		err := i.Exec(hecho)
		if err != nil {
			log.Fatalf("Error al insertar el hecho %s: %v", hecho, err)
		}
	}
	fmt.Println("✅ Hechos agregados dinámicamente con éxito.")

	// 4. Consultar los hechos dinámicos para verificar
	// Queremos saber: ¿De quién es padre 'carlos'? -> padre(carlos, X).
	persona := "carlos"
	consulta := fmt.Sprintf(`padre(%s, X).`, persona)
	
	fmt.Printf("\nConsultando: %s", consulta)
	sols, err := i.Query(consulta)
	if err != nil {
		log.Fatalf("Error al realizar la consulta: %v", err)
	}
	defer sols.Close()

	// fmt.Println("\nResultados de la consulta (Hijos de carlos):")
	// for sols.Next() {
	// 	// var resultado struct{ X string }
	// 	var resultado struct{ X string `prolog:"X"` }
	// 	// SOLUCIÓN: Agregamos el tag `prolog:"X"` para que Go sepa cómo mapear la variable X de Prolog
	// 	// var solucion struct {
	// 	// 	X string `prolog:"X"`
	// 	// }
		
	// 	if err := sols.Scan(&resultado); err != nil {
	// 		log.Fatalf("Error al escanear solución: %v", err)
	// 	}
	// 	fmt.Printf("- %s\n", resultado.X)
	// }

	// if err := sols.Err(); err != nil {
	// 	log.Fatalf("Error durante la iteración: %v", err)
	// }
	fmt.Println("\nResultados de la consulta (Hijos de carlos):")
	for sols.Next() {
		// EN LA VERSIÓN VIEJA: Usar una interfaz vacía para que no falle el mapeo
		var resultado interface{}
		
		if err := sols.Scan(&resultado); err != nil {
			log.Fatalf("Error al escanear: %v", err)
		}
		
		// En la versión vieja, Scan vuelca un mapa interno si le pasas una interfaz
		if mapa, ok := resultado.(map[string]interface{}); ok {
			fmt.Printf("- %v\n", mapa["X"])
		} else {
			// Dependiendo de la subversión exacta v0.x, a veces devuelve directamente el valor
			fmt.Printf("- %v\n", resultado)
		}
	}
}

func agregarHecho(p *prolog.Interpreter, hecho string) {
	hecho = strings.TrimSpace(hecho)

	// Verificar si ya existe
	solsCheck, err := p.Query(hecho + ".")
	if err != nil {
		log.Fatal(err)
	}
	
	if solsCheck.Next() {
		solsCheck.Close()
		fmt.Printf("⚠️ El hecho '%s' YA EXISTE\n", hecho)
		return
	}else{
		fmt.Printf("El hecho '%s' NO EXISTE, se procederá a agregarlo\n", hecho)
	}
	solsCheck.Close()

	// Agregar nuevos hechos
	nuevaClausula := fmt.Sprintf("assertz(%s).", hecho)
	fmt.Println("Agregando: " + nuevaClausula)
	if err := p.Exec(nuevaClausula); err != nil {
		log.Fatal(err)
	}
	// Verificar que se agregaron correctamente
	//consulta := fmt.Sprintf(`%s.`, hecho)
	fmt.Printf("\nVerificando hecho agregado: %s\n", hecho)
	sols2, err := p.Query(hecho + ".")
	if err != nil {
		fmt.Printf("Error al consultar el hecho agregado: %s\n", err)
		log.Fatal(err)
	}
	defer sols2.Close()
	
	if sols2.Next() {
		fmt.Printf(`✓ el hecho %s existe\n`, hecho)
	}else {
		fmt.Printf("❌ El hecho '%s' NO fue agregado\n", hecho)
	}
	if err := sols2.Err(); err != nil {
		log.Fatal(err)
	}
}

func consultarAbuelo(p *prolog.Interpreter, persona string) {
	consulta := fmt.Sprintf(`abuelo(Abuelo, %s).`, persona)
	sols, err := p.Query(consulta)
	if err != nil {
		panic(err)
	}
	defer sols.Close()

	for sols.Next() {
		var resultado struct{ Abuelo string }
		if err := sols.Scan(&resultado); err != nil {
			panic(err)
		}
		fmt.Printf("%s es abuelo de: %s\n", resultado.Abuelo, persona)
	}
}

func consultarPadre(p *prolog.Interpreter, persona string) {
	fmt.Printf("\nConsultando quién es padre de %s:\n", persona)
	consulta := fmt.Sprintf(`padre(Padre, %s).`, persona)
	sols, err := p.Query(consulta)
	if err != nil {
		panic(err)
	}
	defer sols.Close()

	for sols.Next() {
		var resultado struct{ Padre string }
		if err := sols.Scan(&resultado); err != nil {
			panic(err)
		}
		fmt.Printf("%s es padre de: %s\n", resultado.Padre, persona)
	}
}

func getBaseConocimiento() *prolog.Interpreter {
	// Leer el contenido del archivo
	contenido, err := os.ReadFile("familia.pl")
	if err != nil {
		log.Fatal(err)
	}
	pl := prolog.New(os.Stdin, os.Stdout)

	// Cargar desde archivo
	if err := pl.Exec(string(contenido)); err != nil {
		log.Fatal(err)
	}
	return pl
}