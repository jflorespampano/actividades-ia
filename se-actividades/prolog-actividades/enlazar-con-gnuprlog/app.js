const { exec } = require('child_process');

function consultarProlog(consulta) {
    return new Promise((resolve, reject) => {
        const proceso = exec(`gprolog --consult-file script.pl --query-goal "main."`, 
            (error, stdout, stderr) => {
                if (error) reject(stderr);
                resolve(stdout);
            });

        // Envía la consulta al STDIN de GNU Prolog
        proceso.stdin.write(consulta + '.\n'); // ¡Añade el punto final!
        proceso.stdin.end();
    });
}

// Ejemplo de uso
consultarProlog('member(X, [1,2,3])')
    .then(resultado => console.log(resultado))
    .catch(error => console.error(error));
    //salida esperada Éxito: member(1, [1,2,3])