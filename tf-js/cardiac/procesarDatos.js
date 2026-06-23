const fs = require('fs');

function leerDatos(rutaArchivo){
    return new Promise((resolve, reject) => { 
        let datos = [];
        fs.readFile(rutaArchivo, 'utf8', (err, data) => {
            if (err) {
                console.error('Error al leer el archivo:', err);
                reject(err);
                return;
            }

            const lineas = data.split('\n');
            lineas.forEach((linea, index) => {
                // const valores = linea.split(' ');
                // console.log(`Línea ${index + 1}:`, valores);
                if (linea.trim() !== '') { // Ignorar líneas vacías
                    const valores = linea.split(' ').map(Number);
                    //const arreglo = cadena.split(' ');
                    // console.log("valores:",valores)
                    datos.push(valores);
                }
            });
            resolve(datos);
        });
    })
}

leerDatos('./reprocessed.hungarian.data')
.then(data => {
    console.log('Datos leídos:', data);
    // Filtra los datos eliminando las columnas 10, 11 y 12
    let datos = data.map(subarray => 
        subarray.filter((_, index) => ![10, 11, 12].includes(index))
    );
    
    // Convertir los datos a un formato donde cada subarreglo esté en una línea
    const datosComoTexto = 
        '['+datos.map(subarray => JSON.stringify(subarray)+',').join('\n')
        +']';
    // Escribir los datos en el archivo
    fs.writeFile('./datosProcesados.txt', datosComoTexto, 'utf8', (err) => {
        if (err) {
            console.error('Error al escribir el archivo:', err);
            return;
        }
        console.log('Datos escritos en datosProcesados.txt');
    });
})
.catch(err => {
    console.error('Error al leer los datos:', err);
});
