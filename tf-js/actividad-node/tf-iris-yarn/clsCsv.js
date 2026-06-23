import fs from 'fs';
class clsCsv{
    constructor(pathCsv){
        this.pathCsv=pathCsv;
    }

    /**
     * Lee el archivo CSV y devuelve los datos como un array de objetos.
     * @returns array de objetos con los datos del CSV
     */
    loadData () {
        try {
            // Leer archivo CSV
            // const csvData = fs.readFileSync('./data/iris.data.csv', 'utf8');
            const csvData = fs.readFileSync(this.pathCsv, 'utf8');
            // console.log(csvData);
            return this.csvToArray(csvData);
        } catch (err) {
            console.error('Error al leer el archivo:', err);
        }  
    }

    /**
     * Mezclar array (Algoritmo: Fisher-Yates shuffle)
     * 
     * @param {*} array 
     */
    shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
    }
    /**
     * devuelve
     * [{sepall: '5.1',sepalw: '3.5',petall: '1.4',petalw: '0.2',clase: 'Iris-setosa\r'}...]
     * @param {*} data archivo csv como string
     * @returns 
     */
    csvToArray (data) {
        const lines = data.split('\n');
        // const result = lines.map(line => line.split(','));
        //
        const cabeceras = lines[0].trim().split(',');
        const arregloDeObjetos = lines.slice(1).map(linea => {
            const valores = linea.split(',');
            const objeto = {};
            cabeceras.forEach((cabecera, indice) => {
                objeto[cabecera] = valores[indice];
            });
            return objeto;
        });
        //
        this.shuffleArray(arregloDeObjetos);
        return arregloDeObjetos;
    }

    /**
     * Devuelve 2 arreglos features y labels
     * {[[ 5.1, 3.5, 0.2, 0.2 ]...], [0,1,2...]}
     * @param {data} data 
     * @returns objeto con features y labels
     */
    getFeatutesAndLabels (data){
        // console.log(data)
        const features = data.map(item => [
            parseFloat(item.sepall),
            parseFloat(item.sepalw),
            parseFloat(item.petalw),
            parseFloat(item.petalw)
        ]);
        const labels = data.map(item => {
            let species = item.clase
            switch (species) {
                case 'Iris-setosa\r':
                    return 0;
                case 'Iris-versicolor\r':
                    return 1;
                case 'Iris-virginica\r':
                    return 2;
                default:
                    return -1;
            }
        });
        return { features, labels };
    }
        /**
     * Devuelve objeto con 2 arreglos: features y labels one hot
     * {[[ 5.1, 3.5, 0.2, 0.2 ]...], [[1,0,0],[0,1,0]...]}
     * @param {data} data 
     * @returns objeto con features y labels one hot
     */
    getFeatutesAndLabelsOneHot (data){
        // console.log(data)
        const features = data.map(item => [
            parseFloat(item.sepall),
            parseFloat(item.sepalw),
            parseFloat(item.petalw),
            parseFloat(item.petalw)
        ]);
        const labels = data.map(item => {
            let species = item.clase
            switch (species) {
                case 'Iris-setosa\r':
                    return [1,0,0];
                case 'Iris-versicolor\r':
                    return [0,1,0];
                case 'Iris-virginica\r':
                    return [0,0,1];
                default:
                    return [-1,-1,-1];
            }
        });
        return { features, labels };
    }
}
export {clsCsv}