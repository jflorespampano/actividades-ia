const { exec } = require('child_process');

// Programa Prolog simple
const prologProgram = `
padre(juan, maria).
padre(juan, pedro).
hermano(X, Y) :- padre(Z, X), padre(Z, Y), X \\= Y.
`;

// Guardar temporalmente el programa
const fs = require('fs');
fs.writeFileSync('temp.pl', prologProgram);

// Función para consultar Prolog
function consultarProlog(consulta) {
  return new Promise((resolve, reject) => {
    // definir consulta
    // const command = `swipl -q -g "${consulta}, writeln('true')" -t "writeln('false'), halt" -s temp.pl`;
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

// Ejemplo de uso
consultarProlog('hermano(maria, pedroff)')
  .then(result => console.log('¿Son hermanos?', result))
  .catch(err => console.error(JSON.stringify(err, null, 2)));