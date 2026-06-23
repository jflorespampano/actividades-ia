## Tau prolog

Tau Prolog es un intérprete de Prolog del lado del cliente, completamente implementado en JavaScript, cuyo desarrollo se ha basado en el estándar ISO Prolog.

Cumplimiento del estándar ISO Prolog. El desarrollo de Tau Prolog se ha basado en el estándar ISO Prolog, diseñado para promover la aplicabilidad y portabilidad del texto y los datos de Prolog entre diversos sistemas de procesamiento de datos.

Compatible con navegadores y Node.js. Tau Prolog se ha desarrollado para funcionar sin problemas tanto con Node.js como con un navegador. Simplemente use la etiqueta script o la función require para añadir Tau Prolog a su proyecto y empezar a programar.


Manipulación del DOM y gestión de eventos. Aprovechando lo mejor de JavaScript y Prolog, Tau Prolog permite gestionar eventos del navegador y modificar el DOM de una web mediante predicados de Prolog, lo que aumenta aún más la potencia de Prolog.

Predicados asíncronos. Tau Prolog se ha desarrollado siguiendo un enfoque no bloqueante basado en devoluciones de llamadas, lo que permite, por ejemplo, suspender el hilo principal o realizar peticiones AJAX sin bloquear el navegador.

Puedes descargar un paquete personalizado que incluye solo los módulos que necesitas aquí. El código fuente de Tau Prolog está disponible en GitHub. También puedes instalar Tau Prolog desde npm:

## cargar tp en su html

```js
<script src="tau-prolog.js"></script>
```

## descargar

[descargar TP](https://github.com/tau-prolog/tau-prolog)
[TP para node](https://www.npmjs.com/package/tau-prolog)

## ejemplo

```html
<!DOCTYPE html>
<html>
    <head>
        <script src="tau-prolog.js"></script>
    </head>
    <body>
        <!-- Program -->
        <textarea class="example-textinput example-program" id="program">
            le_gusta_a(margara,manzana).
            le_gusta_a(margara,papaya).
            le_gusta_a(calderon,ron).
            le_gusta_a(calderon,brandy).
            le_gusta_a(calderon,whiskey).
        </textarea>
        <br>
        <!-- Nombre -->
        <input class="example-textinput example-goal" type="text" id="name" onKeyup="changeName();" value="" placeholder="Introduzca el nombre" />
        <br>
        <!-- consulta -->
        <input class="example-button" type="button" value="Ver todos sus gustos" id="button" onClick="clickButton();" />
        <!-- respuestas -->
        <div class="example-result" id="result"></div>
    </body>
    
	<script>
        // Callback function
        function show(name) {
            // obtener contenedor de salida
            var result = document.getElementById("result");
            // devolver función  callback
            return function(answer) {
                // si es una pregunta valida
                if(pl.type.is_substitution(answer)) {
                    // obtener el valor del gusto
                    var food = answer.lookup("X");
                    // obtener el nombre de la persona
                    var person = name != "Y" ? name : answer.lookup("Y");
                    // mostrar respuesta
                    result.innerHTML = result.innerHTML + "<div>" + person + " gusta de " + food + "</div>";
                }
            };
        }

        // Mostrar los gustos de una persona
        function likes(name) {
            // Crer session
            var session = pl.create(1000);
            // obtener el programa
            var program = document.getElementById("program").value;
            // limpiar salida
            document.getElementById("result").innerHTML = "";
            // Consultar programa
            session.consult(program);
            // Establecer objetivo de la consulta
            session.query("le_gusta_a(" + name + ", X).");
            // encontrar respuestas
            session.answers(show(name), 1000);
        }

        /** EVENTS */

        // onClick #button
        function clickButton() {
            // Obtener persona
            var name = document.getElementById("name").value;
            name = name != "" ? name : "Y";
            // Obtener gustos
            likes(name);
        }

        // onChange #name
        function changeName() {
            var name = document.getElementById("name").value;
            document.getElementById("button").value = name != "" ? "Que le gusta a  " + name  + " ?" : "Ver todos los gustos";
        }
        changeName();
	</script>
</html>
```