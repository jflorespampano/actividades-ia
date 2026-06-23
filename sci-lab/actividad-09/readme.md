## Obetivo

Crear una red neuronal multicapa y entrenarla para un conjunto de datos dado.

## campos

A continuación se describe un conjunto de datos reales sobre bservaciones de datos medicos de pacientes (13 datos) y una eqiqueta que indica si padece o no alguna enfermedad cardiaca, 0 i no la padece y (1,2,3) si padece alguna. los datos fueron tomados de: [liga](https://archive.ics.uci.edu/dataset/45/heart+disease)

Esta es la base de datos del Dr. Detrano modificada para ser un conjunto de datos MIXTO real.

Atributos: 8 simbólicos, 6 numéricos:

1. Edad; 
2. sexo; 
3. tipo de dolor en el pecho (angina, angina anormal, sin dolor, asintomático)
4. Presión arterial en reposo (PAB); 
5. colesterol; 
6. azúcar en sangre en ayunas < 120% (verdadero o falso); 
7. ECG en reposo (normal, anómalo, hiper); 
8. frecuencia cardíaca máxima;
9. angina inducida por ejercicio (verdadero o falso); 
10. pico anterior; 
11. pendiente (arriba, plana, abajo)
12. número de vasos coloreados (???); 
13. tal (normal, fijo, invertido). 
14. Finalmente, la clase es saludable (0) o con enfermedad cardíaca (1,2,3).

Atributos y sus valores posibles:
1. edad; 
2. sexo (1,0); 
3. cp (1-4); 
4. trestbps; 
5. chol; 
6. fbs (1,0); 
7. restecg (0,1,2);
8. thalach; 
9. exang (1,0); 
10. oldpeak; 
11. slope (1,2,3); 
12. ca; 
13. thal (3,6,7);
14. class att: 0 es saludable, 1,2,3,4 es enfermo.

## ejemplo de datos

| A1 | A2 | A3 | A4  | A5  | A6  | A7  | A8  | A9 | A10  | A11| A12 | A13| A14|
|----|----|----|-----|-----|-----|-----|-----|----|------|----|-----|----|----|
|40  |1   | 2  | 140 | 289 | 0   | 0   | 172 | 0  |  0   | -9 | -9  | -9 |  0 |


el valor -9 indica que no se conoce el dato.
Los datos los puede encontrar en el archivo: reprocessed.hungarian.data

## Actividad

Construya y entrene una red neuronal para predecir las etiquetas que se describen arriba.

## Entregable

1. Código es SCILAB con la red neuronal que prediga las etiquetas cargado en su repositorio de GitHub.

2. Archivo pdf con la liga al repositorio descrito en 1. El archivo pdf deberá cargarse donde el profesor indique.

