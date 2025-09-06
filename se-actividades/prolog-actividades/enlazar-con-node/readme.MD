# enlazar node con swi-prolog

## swipl

El comando swipl es el intérprete de SWI-Prolog, una implementación de código abierto del lenguaje de programación Prolog.

Su principal función es ejecutar programas escritos en Prolog, ya sea interactivamente o cargando archivos de código. Al abrir una terminal y ejecutar swipl, se inicia una sesión interactiva donde se pueden realizar consultas lógicas directamente.

Para cargar un archivo de programa Prolog con extensión .pl, se puede usar el comando swipl nombreDeArchivo.pl.

Este comando permite cargar el archivo y comenzar a hacer consultas sobre la base de conocimiento definida en el archivo, como verificar si un hecho es verdadero o buscar soluciones a un predicado.

Además, swipl permite compilar programas Prolog en ejecutables independientes usando opciones como --goal=main --stand_alone=true -o main -c main.pl.

En resumen, swipl sirve como la herramienta principal para ejecutar, probar y desarrollar programas en Prolog utilizando la plataforma SWI-Prolog.

La opción -q (o --quiet) en swipl (SWI-Prolog) se utiliza para operar en modo silencioso. Cuando se activa, esta opción suprime todos los mensajes informativos que normalmente se mostrarían al iniciar el intérprete.

La opción -g en swipl especifica un objetivo que se ejecuta justo antes de entrar en el nivel superior, y puede aparecer múltiples veces; los objetivos se ejecutan en el orden de aparición y, si un objetivo falla, se imprime un error y el proceso se detiene con código de salida 1.
 Este objetivo puede ser un término complejo, requiriendo comillas para protegerlo del shell de Unix.

 La opción -t utiliza el objetivo especificado como nivel superior interactivo en lugar del objetivo predeterminado prolog/0, y si el objetivo de nivel superior tiene éxito, swipl finaliza con estado 0; si falla, el estado de salida es 1

 ## comando 

 ```sh
 swipl -q -g "${consulta}, writeln('true'), halt" temp.pl
 ```

## ejecutar el comando en node

```js
const { exec } = require('child_process');
//...
function consultarProlog(consulta) {
  return new Promise((resolve, reject) => {
    // definir consulta
    const command = `swipl -q -g "${consulta}, writeln('true'), halt" temp.pl`;
    
    // ejecutar comando
    exec(command, (error, stdout, stderr) => {
      if (error) {
        console.log(error)
        reject(
          {
            code: error.code,
            cmd: error.cmd,
            message: `Error al ejecutar Prolog: ${error.message}`
          }
        );
        return;
      }
      resolve(stdout.trim());
    });
  });
}

//uso
consultarProlog('hermano(maria, pedroff)')
  .then(result => console.log('¿Son hermanos?', result))
  .catch(err => console.error(JSON.stringify(err, null, 2)));
```