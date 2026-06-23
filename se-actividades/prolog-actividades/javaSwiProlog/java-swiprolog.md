# enlazar swi-prolog con java

## opcion 1

Se requiere la biblioteca .jar siguente, que se encuenntra en:
Windows: C:\Program Files\swipl\bin\jpl.dll y C:\Program Files\swipl\lib\jpl.jar

Para enlazar:

* Disponer de la biblioteca JPL
    * Puedes descargarla desde https://www.swi-prolog.org/pldoc y seguir las instrucciones de instalación.
    * O si tienes instalado swi-prolog la biblioteca esta en la carpeta: **C:\Program Files\swipl\bin\jpl.dll y C:\Program Files\swipl\lib\jpl.jar**
* Asegúrate de tener la biblioteca JPL en tu classpath
* o usar la opcion classpath: **-cp ".;C:\Program Files\swipl\lib\jpl.jar"** al compilar
* También necesitas tener SWI-Prolog instalado en tu sistema.

Este ejemplo asume que tienes un archivo Prolog llamado "aprobo.pl" en el mismo directorio que tu archivo Java: El archivo "aprobo.pl" podría contener algo como:

Archivo: aprobo.pl
```prolog
aprobo(juan, matematicas).
aprobo(maria, historia).
```
### Ejecución del programa:

Forma de ejecutar:

1. Asegúrate de que SWI-Prolog esté instalado y que puedas ejecutarlo desde la línea de comandos. Abre una terminal y escribe:

```sh
swipl --version
```

2. Para usar JPL en Java, necesitas:

Agregar **jpl.jar** al classpath de tu proyecto.

Asegurarte de que la biblioteca nativa (jpl.dll, libjpl.so, o libjpl.dylib) esté en el path del sistema o especificar su ubicación con la opcion **-cp**.

Ejecutar el programa java:

```sh
java -cp ".;C:\Program Files\swipl\lib\jpl.jar" -Djava.library.path="C:\Program Files\swipl\bin" conectarConSwiProlog.java
```

Si sale este: WARNING: **Use --enable-native-access=ALL-UNNAMED to avoid a warning for callers in this module**, debe activar el acceso nativo:

```sh
java --enable-native-access=ALL-UNNAMED -cp tu_classpath ClasePrincipal
```

### Para activar acceso nativo:

Configuración manual mediante línea de comandos
Compila y ejecuta tu programa Java así:

```sh
# En Windows
java -cp ".;C:\Program Files\swipl\lib\jpl.jar" -Djava.library.path="C:\Program Files\swipl\bin" MiClase
# ejemplo:
java --enable-native-access=ALL-UNNAMED -cp ".;C:\Program Files\swipl\lib\jpl.jar" -Djava.library.path="C:\Program Files\swipl\bin" conectarConSwiProlog.java
```

## Opción 2: Configuración en un IDE (Eclipse, IntelliJ, NetBeans)

Agregar **jpl.jar** al classpath del proyecto:

En el IDE, ve a las propiedades del proyecto, luego a "Libraries" y agrega el archivo JAR externo (jpl.jar).

Configurar la biblioteca nativa:

En las opciones de ejecución, agrega la siguiente VM option: 
`-Djava.library.path=<ruta_a_la_biblioteca_nativa>`

## ejemplo de código

Archivo: conectarConSwiProlog.java
```java
import org.jpl7.Query;
import org.jpl7.Term;

//para manejo de acentos
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;

public class conectarConSwiProlog {
    public static void main(String[] args) {
        // Cargar el archivo Prolog
        String prologFile = "./aprobo.pl"; // Cambia esto por la ruta a tu archivo .pl
        Query loadQuery = new Query("consult", new Term[] {new org.jpl7.Atom(prologFile)});
        
        if (loadQuery.hasSolution()) {
            System.out.println("Archivo Prolog cargado exitosamente.");
            
            // Realizar una consulta
            String prologQuery = "aprobo(juan,X)."; // Cambia esto por tu consulta Prolog
            Query query = new Query(prologQuery);
            
            while (query.hasMoreSolutions()) {
                java.util.Map<String, Term> solution = query.nextSolution();
                
                try {
                    //salida con acentos
                    PrintStream out = new PrintStream(System.out, true, "UTF-8");
                    out.println("Solución: " + solution);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                //salida sin acentos
                System.out.println("Solución: " + solution);
            }
        } else {
            System.out.println("Error al cargar el archivo Prolog.");
        }
    }
}
```