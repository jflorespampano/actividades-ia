ann_FF

ANN artificial neural network

Algoritmos para redes de propagación hacia adelante

## Objetivo

Proporcionar motores para la exploración, prueba y prototipado rápido de redes neuronales artificiales (RNA) de propagación progresiva. Se ofrece cierta flexibilidad (p. ej., la posibilidad de modificar las funciones de activación o error).

## Descripción de la arquitectura

1. La red se visualiza de la siguiente manera: 
entradas a la izquierda y datos (señales) propagándose a la derecha.

2. N es un vector de fila que contiene el número de neuronas por capa, incluida la entrada.

3. La primera capa es la entrada (aunque no procesa datos, facilita la implementación).
Capa n.° 1 2 ... size(N,'c') [**Nota** size(N,'c') nos da el número de columnaas]
Tenga en cuenta que las conexiones no saltan entre capas, sino que solo se dan entre capas adyacentes (completamente interconectadas). 

4. La dimensión de N es size(N,'c'), por lo que:
La capa de entrada tiene N(1) neuronas.
La primera capa oculta tiene N(2) neuronas, ...
La capa de salida L tiene N(size(N,'c')) neuronas.

5. El vector/matriz de entrada es x; cada patrón se representa mediante una columna.
Solo se aceptan patrones de entrada de tamaño constante.
NOTA: Internamente, los patrones se trabajarán individualmente como vectores columna; es decir, cada vector patrón es una columna con la forma: x(:,p), (siendo p el número de orden del patrón).

6. Cada neurona de la primera capa oculta tiene N(1) entradas, ... para la capa l en [2, ..., tamaño(N,'c')], cada neurona tiene N(l-1) entradas de la capa anterior más una que simula el sesgo (cuando corresponde, la mayoría de los algoritmos asumen la existencia de sesgo). 

7. La red está completamente conectada, pero se puede cancelar la conexión poniendo a cero el peso correspondiente (tenga en cuenta que un procedimiento de entrenamiento puede volver a un valor distinto de cero; esta es una de las razones por las que se proporcionan algunos "ganchos"; consulte el parámetro "ex" a continuación).

## interfaz de usuario, parámetros

Esta subsección describe los parámetros que toman las distintas funciones definidas en la caja de herramientas. No todas las funciones requieren todos los parámetros.

En orden alfabético: af proporciona la función de activación y, si es necesario, su derivada (total). Puede ser: - una cadena con el nombre de la función de activación - un vector fila de dos elementos de cadenas donde af(1) es la cadena con el nombre de la función de activación y af(2) es el nombre de la derivada.

NOTA: Dada una función de activación y = f(x), la derivada debe expresarse en términos de y, no de x.
Por ejemplo, dada la función de activación logística: 1 y = ----------- 1 + exp(-x), la derivada se expresará como: dy -- = y (1 - y) dx. Esta forma reduce el uso de memoria y, en el caso particular de la función de activación logística, también aumenta la velocidad.

Este parámetro es opcional. El valor predeterminado es "ann_log_activ" o ["ann_log_activ","ann_d_log_activ"] (dependiendo de la función que lo utilice), es decir, la función de activación descrita anteriormente y su derivada (las funciones predeterminadas ya están definidas en esta caja de herramientas).

Preste mucha atención a la definición de una nueva función de activación.

Estas funciones aceptan patrones como vectores columna dentro de y, donde cada elemento representa la entrada total en una neurona, y devuelven una matriz similar que representa la activación de toda la capa. Es decir, la función logística se define como: y = 1 ./ (1 + %e^(-x)) y observe el espacio entre 1 y ./. La derivada de la función de activación se define de forma similar: z = y .* (1 - y) y observe el operador ".*".

Delta_W_old: La cantidad en la que W se modificó en el patrón de entrenamiento anterior. 

dW, dW2: la cantidad de variaciones de cada elemento W para calcular las derivadas del error mediante un enfoque de diferencias finitas (véase ann_FF_grad y ann_FF_Hess para más información). ef: función de error.

Este parámetro es opcional; el valor predeterminado es "ann_sum_of_sqr", es decir, la suma de cuadrados (ya definida en esta herramienta). err_deriv_y: la derivada del error con respecto a las salidas de la red. Devuelve una matriz cuya columna contiene la derivada del error correspondiente al patrón apropiado.

Este parámetro es opcional; el valor predeterminado es "ann_d_sum_of_sqr" (ya definido en esta herramienta), es decir, la derivada de la función de error de suma de cuadrados. ex es una secuencia de programa de Scilab que se ejecuta después de actualizar la hipermatriz de pesos de cada patrón de entrenamiento.

Su propósito principal es proporcionar enlaces para modificar la función de aprendizaje sin tener que reescribirla. Usos típicos: comprobar criterios de parada y poda.

Este parámetro es opcional; el valor predeterminado es [" "] o [" "," "] (algunas funciones tienen dos enlaces); es decir, una cadena vacía no realiza ninguna función. l rango de capas entre las que se ejecuta la red.
Vector de fila de dos componentes: l(1) capa en la que se inyectará un patrón, presentado como si hubiera provenido de la capa anterior: l(1)-1. l(2) capa de la que se recopilan las salidas. Por ejemplo: l = [3,3] significa que la entrada se inyecta en las neuronas de la capa 3 y sus salidas (l(2)=3) se recopilan para obtener el resultado. l = [2,3] significa que la entrada se inyecta en la primera capa oculta (tal como provendría de la capa de entrada) y la salida se recopila en las salidas de las neuronas de la capa 3. Este parámetro es opcional; el valor predeterminado es [2, tamaño(N, 'c')] (red completa).

l(1) = 1 no tiene sentido, ya que representa la capa de entrada.

lp representa los parámetros de aprendizaje y es un vector de fila [lp(1), lp(2), ...]

El significado real de cada componente puede variar; consulte las páginas del manual correspondientes para ver la representación y los valores típicos.

N (vector de fila) define la red, es decir, el número de neuronas por capa. N(l) representa el número de neuronas en la capa l. Por ejemplo: N(1) es el tamaño del vector de entrada; N(tamaño(N), 'c') es el tamaño del vector de salida. r (rango de números aleatorios) en función del cual se inicializan los pesos de conexión (no los sesgos).

Es un vector de fila de dos componentes: r(1) da el límite inferior y r(2) da el límite superior.

Este parámetro es opcional; el valor predeterminado es [-1,1].

rb: rango de números aleatorios con base en el cual se inicializan los sesgos (no otros pesos).

Es un vector de fila de dos componentes: rb(1) da el límite inferior y rb(2) da el límite superior.

Este parámetro es opcional; el valor predeterminado es [0,0]; es decir, los sesgos se inicializan con 0.
t: matriz de objetivos, un patrón por columna. Por ejemplo, t(:,p) representa el patrón n.° p. x: matriz de entradas, un patrón por columna. Por ejemplo, x(:,p) representa el patrón no. p.

## Interfaz de usuario (2): 

Funciones
Los nombres de las funciones se estructuran de la siguiente manera:

ann Prefijo para todos los nombres de funciones dentro de esta caja de herramientas.
_FF Prefijo para todos los nombres de funciones diseñados para redes FeedForward. Define el tipo de algoritmo: en línea usa un patrón a la vez. batch usa todos los patrones a la vez.

_nb sufijo para todos los nombres de funciones dentro de esta caja de herramientas diseñada para redes sin sesgos.
ann_FF_init Construir e inicializar la hipermatriz de pesos.
ann_FF_Std Algoritmo de retropropagación estándar (vainilla, regla delta).
ann_FF_Mom Backpropagation with momentum.
ann_FF_run Runs the network.
ann_FF_grad Calculate the error gradient trough a finite difference approach. It is provided for testing purposes only.
ann_FF_Jacobian Calculate the Jacobian trough a finite difference approach. It is provided for testing purposes only.
ann_FF_Jacobian_BP Calculate the Jacobian trough a Back-Propagation algorithm.
ann_FF_Hess Calculate the Hessian trough a finite difference approach. It is provided for testing purposes only.
ann_FF_VHess Calculate the multiplication between a vector and the Hessian trough an efficient finite difference approach.
ann_FF_ConjugGrad Conjugate gradients algorithm.
ann_FF_SSAB Backpropagation with SuperSAB algorithm.

## Tips

No utilice redes sin sesgo a menos que sepa lo que hace.
El algoritmo más eficiente (con diferencia) es el "Gradiente Conjugado", aunque puede requerir el arranque con otro algoritmo (vea los ejemplos).
Reduzca al máximo el número de bucles y llamadas a funciones; utilice en su lugar las capacidades de manipulación de matrices de Scilab.
Puede reorganizar los patrones de entrenamiento entre dos llamadas al procedimiento de entrenamiento; utilice los ganchos "ex" proporcionados.
Tenga mucho cuidado al definir nuevas funciones de activación y error, y pruébelas para asegurarse de que cumplen su función.
No utilice matrices dispersas a menos que sean realmente dispersas (<5%).

## Detalles de implementación
- Cada capa tiene asociada una hipermatriz de pesos.

La mayoría de los algoritmos asumen la existencia de sesgos por defecto. Para cada capa l, excepto l = 1, la matriz de pesos asociada a las conexiones de l-1 a ​​l es W(1:N(l),1:N(l-1),l-1) para redes sin sesgos y W(1:N(l),1:N(l-1)+1,l-1) para redes con sesgos. Es decir, los sesgos se almacenan en la primera columna: W(1:N(l),1,l-1).

La ​​entrada total a una capa l es: = W(1:N(l),1:N(l-1),l-1)*z(1:N(l-1)) para una red sin sesgos = W(1:N(l),1:N(l-1)+1,l-1)*[1; z(1:N(l-1))] para redes con sesgos, donde z(1:N(l-1)) es la salida de la capa anterior (vector columna); es decir, el sesgo se simula como la neurona n.° 0 en cada capa con una salida constante de 1.

W se inicializa a ceros(máx.(N),máx.(N),tamaño(N,'c')-1) para redes sin sesgos, y a hipermat(máx.(N),máx.(N)+1, tamaño(N,'c')-1) para redes con sesgos; las entradas no utilizadas de W se inicializan a cero y se dejan intactas.
- Los vectores de patrones se pasan como columnas en una matriz que representa un conjunto (de patrones).

## online
la sentencia:

W= ann_FF_Std_online(X,Y,N,W,learning_rate,epochs);

La función ann_FF_Std_online toma estas variables y ajusta los pesos W de la red neuronal durante un número especificado de epochs, utilizando la tasa de aprendizaje learning_rate. En cada epoch, la red realiza ajustes basados en los errores cometidos en las predicciones en comparación con las salidas deseadas Y.


 Este enfoque en línea significa que los pesos se actualizan continuamente después de cada muestra de entrenamiento, en lugar de esperar hasta el final de un ciclo completo de entrenamiento.