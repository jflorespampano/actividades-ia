# hola

El objetivo de este código es utilizar un algoritmo genético para resolver un problema de optimización: encontrar una cadena que coincida exactamente con una cadena objetivo (en este caso, "Hola").

Este proceso simula la evolución natural, donde una población de soluciones iniciales (individuos) evoluciona hacia una solución óptima mediante los siguientes pasos:

Generación aleatoria: Comienza con una población de cadenas generadas al azar.

Evaluación (Fitness): Cada cadena se evalúa comparándola con la cadena objetivo. La puntuación indica qué tan similar es la cadena al objetivo.

Selección: Las cadenas con mejor puntaje tienen más probabilidad de ser seleccionadas para reproducirse (como en la selección natural).

Cruce: Combina partes de dos cadenas "padres" para generar una nueva cadena "hijo". Esto aumenta la diversidad y mezcla características buenas.

Mutación: Se cambian aleatoriamente algunos caracteres en las cadenas para evitar quedar atrapados en soluciones subóptimas.

Iteración: Este proceso se repite hasta que una de las cadenas coincide completamente con el objetivo.

# sen(x)*cos(x)

Población inicial: Se genera una lista de números aleatorios (𝑥) dentro del rango especificado.

Evaluación de aptitud: Se calcula 
𝑓(𝑥)=sin(𝑥)⋅cos(𝑥) para cada individuo en la población.

Selección: Se seleccionan los mejores individuos (es decir, aquellos con mayor valor de 
𝑓(𝑥)).

Cruce: Los individuos seleccionados generan descendencia combinando sus valores.

Mutación: A los descendientes se les introduce un pequeño cambio aleatorio para explorar nuevas soluciones.

Iteración: Este proceso se repite durante varias generaciones para encontrar una buena aproximación al máximo.

Este enfoque aproximará el valor de 𝑥 donde la función alcanza su valor máximo. En el caso de 
sin(𝑥)⋅cos(𝑥), sabemos que el máximo ocurre en 𝑥=𝜋/4, pero este algoritmo evolutivo lo descubre de manera iterativa.

El resultado de 3.14/4 es aproximadamente 0.785. Este valor es una aproximación de 
𝜋/4, que es el ángulo donde la función 
sin(𝑥)⋅cos(𝑥) alcanza su máximo valor