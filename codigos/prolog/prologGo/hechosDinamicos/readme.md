# Crear

# estos códigos aun estan en etapa de pruebas


```bash
go mod init hechosDinamicos
```

en su archivo `main.go` cargue la biblioteca:

```go
package main

import (
	"fmt"
	"log"

	"github.com/ichiban/prolog"
)

func main() {
}
```
Actualizar dependencias

```bash
go mod tidy
```

Esto instala la dependencia, tambien se puede instalar a mano:
```bash
go get github.com/ichiban/prolog
```
Agregue su código

ejecute:
```bash
go run main.go
```