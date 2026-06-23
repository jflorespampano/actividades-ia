import * as tf from '@tensorflow/tfjs';
import {clsCsv} from './clsCsv.js'

const pathCsv='./data/iris.data.csv'; 
const csvHandler=new clsCsv(pathCsv);

const EPOCHS = 100;
const BATCH_SIZE = 8;
const LEARNING_RATE = 0.01;
let VERVOSE=false;

class irisClasifier{
    constructor() {
        this.model = null;
        this.trainingData = null;
        this.testingData = null;
        //para normalización
        this.mean = null;
        this.variance = null;
    }
    /**
     * Carga y preprocesa los datos de características y etiquetas.
     * los divide en conjuntos de entrenamiento y prueba.
     * @param {Array} features - Matriz de características.
     * @param {Array} labels - Matriz de etiquetas.
     * @return {testingData, labelData} - 2 tensores Datos y etiquetas de prueba.
     */
    loadData(features, labels) {
        // Implementar la carga y preprocesamiento de datos
        try {
            // Convertir a tensores
            const featuresTensor = tf.tensor2d(features);
            const labelsTensor = tf.tensor2d(labels);
            if(VERVOSE){
                console.log("mis tensores:")
                featuresTensor.print();
                labelsTensor.print();
            }

            // Normalizar características por el método de estandarización:(media=0, std=1)
            const { mean, variance } = tf.moments(featuresTensor, 0);
            const normalizedFeatures = featuresTensor.sub(mean).div(variance.sqrt());
            this.mean = mean;
            this.variance = variance;

            // Dividir en entrenamiento (80%) y prueba (20%)
            const splitIndex = Math.floor(features.length * 0.8);

            this.trainingData = {
                features: normalizedFeatures.slice(0, splitIndex),
                labels: labelsTensor.slice(0, splitIndex)
            };

            this.testingData = {
                features: normalizedFeatures.slice(splitIndex),
                labels: labelsTensor.slice(splitIndex)
            };

            // console.log(`📊 Entrenamiento: ${splitIndex} muestras`);
            // console.log(`🧪 Prueba: ${features.length - splitIndex} muestras`);

        } catch (error) {
            console.error('❌ Error cargando datos:', error.message);
        }
        return({testingData:this.testingData, labelData: this.testingData.labels});
    }

    /**
     * Desnormaiza el tensor usando media y varianza almacenadas
     * @param {*} tensor 
     * @returns 
     */
    desNormalize(tensor) {
        return tf.tidy(() => {
            return tensor.mul(this.variance.sqrt()).add(this.mean);
        });
    }

    /**
     * crea un modelo de red neuronal secuencial para clasificación 
     * por ejemplo de flores Iris.
     * El modelo tiene dos capas ocultas con activación ReLU y 
     * una capa de salida con activación softmax.
     * El modelo se compila con el optimizador Adam y 
     * la función de pérdida de entropía cruzada categórica.
     * @param {*} caracteristicas número de características de entrada (por defecto 4).
     * @param {*} clases número de clases de salida (por defecto 3).
     */
    createModel(caracteristicas=4, clases=3) {
        const model = tf.sequential();

        // Capa de entrada + primera capa oculta
        model.add(tf.layers.dense({
            inputShape: [caracteristicas], // 4 características
            units: 10,       // 10 neuronas
            activation: 'relu',
            kernelInitializer: 'heNormal'
        }));

        // Segunda capa oculta
        model.add(tf.layers.dense({
            units: 8,
            activation: 'relu'
        }));

        // Capa de salida
        model.add(tf.layers.dense({
            units: clases,        // 3 clases
            activation: 'softmax'
        }));

        // Compilar modelo
        model.compile({
            optimizer: tf.train.adam(LEARNING_RATE),
            loss: 'categoricalCrossentropy',
            metrics: ['accuracy']
        });

        this.model = model;
        
        if(VERVOSE){
            console.log(' Modelo creado:');
            model.summary();

        }
    }
    /**
     * Entrena el modelo de red neuronal con los datos de entrenamiento cargados.
     * Utiliza un tamaño de lote y número de épocas definidos.
     * 
     * @returns {Promise<tf.History>} - Historia del entrenamiento.
     */
    async train() {
        if (!this.model || !this.trainingData) {
            console.error('❌ Modelo o datos no cargados');
            return;
        }
        if(VERVOSE){
            console.log('🚀 Comenzando entrenamiento...');

        }

        const history = await this.model.fit(
            this.trainingData.features,
            this.trainingData.labels,
            {
                epochs: EPOCHS,
                batchSize: BATCH_SIZE,
                validationSplit: 0.2,
                callbacks: {
                    onEpochEnd: (epoch, logs) => {
                        if(!VERVOSE){
                            // console.log(`epoch -> ${epoch}/${EPOCHS}`);
                            process.stdout.write(`\rEpoch -> ${epoch}/${EPOCHS}`);
                        }else{
                            if (epoch % 150 === 0) {
                                console.log(`-> ${epoch+1}, logs:`,logs)
                                // console.log(`📈 Época ${epoch + 1}: loss=${logs.loss.toFixed(4)}, accuracy=${logs.acc.toFixed(4)}`);
                            }
                        }
                    }
                }
            }
        );

        console.log('✅ Entrenamiento completado');
        return history;
    }
    /**
     * Evalúa el modelo de red neuronal con los datos de prueba cargados.
     * Muestra la pérdida y precisión en la consola.
     * @returns 
     */
    async evaluate() {
        if (!this.model || !this.testingData) {
            console.error('❌ Modelo o datos de prueba no cargados');
            return;
        }

        console.log('🧪 Evaluando modelo...');

        const evaluation = this.model.evaluate(
            this.testingData.features,
            this.testingData.labels
        );

        const loss = evaluation[0].dataSync()[0];
        const accuracy = evaluation[1].dataSync()[0];

        console.log(`📊 Resultados finales:`);
        console.log(`   - Loss: ${loss.toFixed(4)}`);
        console.log(`   - Accuracy: ${(accuracy * 100).toFixed(2)}%`);

        return { loss, accuracy };
    }

    /**
     * Predice la clase de una flor Iris dada sus características.
     * 
     * @param {*} features - features normalizados
     * @param {boolean} normalized - Indica si las características ya están normalizadas.
     * @returns {Promise<{probabilities: Float32Array, predictedClass: string}>} - Probabilidades y clase predicha.
     */
    async predict(features,normalized=true) {
        if (!this.model) {
            console.error('❌ Modelo no cargado');
            return;
        }

        let tensor = tf.tensor2d([features]);
        if(!normalized){
            // Normalizar características usando media y varianza almacenadas
            const normalizedTensor = tensor.sub(this.mean).div(this.variance.sqrt());
            tensor.dispose();
            tensor=normalizedTensor;
        }
        const prediction = this.model.predict(tensor);
        const results = await prediction.data();
        
        tensor.dispose();
        prediction.dispose();

        const classes = ['setosa', 'versicolor', 'virginica'];
        const predictedClass = classes[results.indexOf(Math.max(...results))];
        const stringResponse={
            "features":`[${features.join(', ')}]`,
            "setosa": (results[0] * 100).toFixed(2)+"%",
            "versicolor": (results[1] * 100).toFixed(2)+"%",
            "virginica": (results[2] * 100).toFixed(2)+"%",
            "predictedClass": predictedClass
        }
        // console.log(`  Predicción para [${features.join(', ')}]:`);
        // console.log(`   - setosa: ${(results[0] * 100).toFixed(2)}%`);
        // console.log(`   - versicolor: ${(results[1] * 100).toFixed(2)}%`);
        // console.log(`   - virginica: ${(results[2] * 100).toFixed(2)}%`);
        // console.log(`   - Clase predicha: ${predictedClass}\n`);

        return { probabilities: results, predictedClass, stringResponse };
    }
    // Guardar modelo no funciona
    async saveModel(path = './model') {
        if (!this.model) {
            console.error('❌ Modelo no cargado');
            return;
        }

        await this.model.save(path);
        console.log(`💾 Modelo guardado en: ${path}`);
    }

    // Cargar modelo no funciona
    async loadModel(path = './model') {
        try {
            this.model = await tf.loadLayersModel(`${path}/model.json`);
            console.log('📂 Modelo cargado exitosamente');
        } catch (error) {
            console.error('❌ Error cargando modelo:', error.message);
        }
    }
    

}

/**
 * Obtiene los dtos csv y los procesa en features y labels
 * @returns devuelve 2 arrreglos {features, labels}
 */
function getData(){
    const arr=csvHandler.loadData();
    // const fal=csvHandler.getFeatutesAndLabels(arr);
    const fal=csvHandler.getFeatutesAndLabelsOneHot(arr);
    return fal;
}

/**
 * Convierte etiqueta 0/1/2 a etiquetas de clase
 * @param {*} label 
 * @returns setosa/versicolor/virginica
 */
function quitaOneHot(label){
    const res= label.indexOf(1)
    if(res==0) return "setosa"
    if(res==1) return "versicolor"
    if(res==2) return "virginica"
}

function redondearTensor3Decimales(tensor) {
    return tf.tidy(() => {
        // Multiplicar por 1000, redondear, dividir por 1000
        return tensor.mul(1000).round().div(1000);
    });
}

/**
 * Predice la clase de una flor Iris con características no normalizadas
 * @param {*} iris modelo irisClasifier
 * @param {*} features características no normalizadas
 * @param {*} etiqueta etiqueta real (opcional)
 */
async function prediceNoNormalizada(iris, features, etiqueta=""){
    const result= await iris.predict(features,false)
    
    if(VERVOSE){
        console.log(`Predicción para [${features.join(', ')}](${etiqueta}):`);
        console.log(result);
    }else{
        console.log(`Predicción para [${features.join(', ')}](${etiqueta}):${result.predictedClass}`);
        // console.log(result.predictedClass);
    }

}

/**
 * Predice las clases para todo el conjunto de datos de prueba
 * @param {*} iris modelo irisClasifier
 * @param {*} testingData datos de prueba
 * @returns 
 */
async function prediceTestingData(iris, testingData) {
    const arrayPredictions = [];
    // Obtener los arrays de características y etiquetas
    const feats = await testingData.features.array();
    const labs = await testingData.labels.array();

    for (let i = 0; i < feats.length; i++) {
        console.log(`Entrada: ${feats[i]}`);
        const { stringResponse } = await iris.predict(feats[i]);
        console.log(`Etiqueta: ${quitaOneHot(labs[i])} Predicha: ${stringResponse["predictedClass"]}\n`);
        arrayPredictions.push(stringResponse["predictedClass"]);
    }

    return arrayPredictions;
}

/**
 * Crea la matriz de confusión
 * @param {*} etiquetasReales 
 * @param {*} etiquetasPredichas 
 * @returns Matriz de confusión
 */
function matrizDeConfusion(etiquetasReales, etiquetasPredichas){
    const clases = ['setosa', 'versicolor', 'virginica'];
    // const matriz = Array.from({ length: clases.length }, () => Array(clases.length).fill(0));
    const matriz = Array.from({ length: 3 }, () => 
        Array.from({ length: 3 }, () => 0)
    );
    // console.log(matriz)
    if(VERVOSE){
        console.log("\n")
        console.log("creando la matriz de confusión:")
    }
    for (let i = 0; i < etiquetasReales.length; i++) {
        const realIndex = clases.indexOf(etiquetasReales[i]);
        const predIndex = clases.indexOf(etiquetasPredichas[i]);
        if(VERVOSE){
            console.log(`[real:${realIndex},predicha:${predIndex}]->Error: ${realIndex-predIndex}`)
        }
        if(realIndex==-1 || predIndex==-1){
            console.warn(`⚠️  Etiqueta desconocida: real=${etiquetasReales[i]}, predicha=${etiquetasPredichas[i]}`);
            continue;
        }
        matriz[realIndex][predIndex]++;
    }
    return matriz;
}

async function main(){
    if(process.argv.includes('--vervose')){
        VERVOSE=true;
    }

    //obtener {festures, labels} desde archivo csv
    const {features, labels}=getData();
    if(VERVOSE){
        console.log("Datos cargados desde CSV:");
        console.log(features);
        console.log(labels);
    }

    //crear, entrenar y evaluar el clasificador
    const iris=new irisClasifier();
    const {testingData, labelData}=iris.loadData(features, labels);
    iris.createModel();
    await iris.train();
    await iris.evaluate();

    
    // Hacer predicciones de ejemplo
    console.log('\n🎯 Predicciones de ejemplo:');
        console.log(`
        Predicciones para el conjunto de datos de prueba:
        [5.1, 3.5, 1.4, 0.2],"setosa"
        [6.7, 3.0, 5.2, 2.3],"virginica"
        [5.9, 3.0, 4.2, 1.5],"versicolor"
    `);
    // no se puede predecir directamente x k fueron normalizados
    await prediceNoNormalizada(iris, [5.1, 3.5, 1.4, 0.2],"setosa"); // setosa
    await prediceNoNormalizada(iris, [6.7, 3.0, 5.2, 2.3],"virginica"); // virginica
    await prediceNoNormalizada(iris, [5.9, 3.0, 4.2, 1.5],"versicolor"); // versicolor

    //predicciones del conjunto testing data
    console.log("\n----Predicciones de testing data:-----\n")
    const arrayPredictions=await prediceTestingData(iris, testingData);
    if(VERVOSE ){
        console.log("\nresumen predicciones testing data")
        console.log(JSON.stringify(arrayPredictions))
    }

    //Creaar Matriz de confusión
    const labelsArray = await labelData.arraySync();
    labelData.dispose();
    const etiquetasReales = labelsArray.map(lab => quitaOneHot(lab));
    if(VERVOSE){
        console.log("\nresumen etiquetas reales")
        console.log(JSON.stringify(etiquetasReales));
    }
    const mc=matrizDeConfusion(etiquetasReales, arrayPredictions);
    console.log("\nMatriz de confusión - Predicciones:")
    console.table(mc);
}

main();
