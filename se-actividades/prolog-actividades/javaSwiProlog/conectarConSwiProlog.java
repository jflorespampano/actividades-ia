// Ejemplo de conexión de Java con SWI-Prolog usando JPL
// COMPILAR Y EJECUTAR con acceso nativo
//java --enable-native-access=ALL-UNNAMED -cp ".;C:\Program Files\swipl\lib\jpl.jar" -Djava.library.path="C:\Program Files\swipl\bin" conectarConSwiProlog.java


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
            String prologQuery = "aprobo(maria,X)."; // Cambia esto por tu consulta Prolog
            Query query = new Query(prologQuery);
            
            while (query.hasMoreSolutions()) {
                java.util.Map<String, Term> solution = query.nextSolution();
                
                try {
                    //salida con acentos
                    PrintStream out = new PrintStream(System.out, true, "UTF-8");
                    out.println(prologQuery+" Solución: " + solution);
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                //salida sin acentos
                System.out.println(prologQuery+" Solución sin acento: " + solution);
            }
        } else {
            System.out.println("Error al cargar el archivo Prolog.");
        }
    }
}