# CART

CART (Classification and Regression Trees) es uno de los métodos más populares para construir árboles de decisión. CART construye un árbol binario (cada nodo padre tiene como máximo dos hijos) mediante divisiones recursivas. El objetivo es dividir el conjunto de datos en subgrupos cada vez más puros (homogéneos) con respecto a la variable objetivo.

## Criterios de División (¿Cómo elige la mejor partición?)

El algoritmo prueba todas las variables y todos los puntos de corte posibles, y elige aquel que maximiza la "pureza" de los nodos hijos. El criterio depende del tipo de problema:

* Para Clasificación (variable objetivo categórica): usa el Índice de Gini (el más común) o la Entropía.

    * Gini: mide la probabilidad de clasificar incorrectamente un elemento si se etiquetara al azar. Busca minimizar este valor.
    * Entropía: mide el desorden o la incertidumbre. Busca maximizar la ganancia de información.

## Proceso de Construcción (Pasos)

1. Inicio: Para cada variable, evalúa todos los posibles puntos de corte.
3. Selección: Elige la variable y el punto de corte que generen la mayor reducción en la impureza (o error).
4. División: Divide los datos en dos nodos hijos (izquierdo y derecho) según esa regla (ej: Edad <= 30).
5. Repetición: Aplica el mismo proceso recursivamente a cada nodo hijo hasta que se cumpla un criterio de parada.

CART se diferencia de otros algoritmos (como ID3) porque primero crece un árbol muy grande y luego lo poda (reduce) hacia atrás.

| Característica | ID3 (1986) | CART (1984) |
|----------------|------------|-------------|
| **Tipo de árbol** | Multifurcado (puede tener N ramas) | Binario (siempre 2 ramas) |
| **Criterio de división** | Ganancia de información (Entropía) | Índice Gini (clasificación) o MSE (regresión) |
| **Variables soportadas** | Solo categóricas | Categóricas y numéricas |
| **Soporte para regresión** | ❌ No | ✅ Sí |
| **Manejo de valores faltantes** | ❌ No | ✅ Sí |
| **Poda (pruning)** | No incluido originalmente | Sí (poda por complejidad) |
| **Sesgo** | Hacia atributos con muchos valores | Balanceado |

## Poda

En árboles de decisión es una técnica para reducir el tamaño del árbol eliminando ramas que no aportan valor predictivo significativo. Es como podar un árbol real: cortas ramas que no son necesarias para que el árbol sea más fuerte y saludable.

Los árboles de decisión tienen un problema grave: tienden a sobreajustarse (overfitting). Esto significa que:

1. Memorizan los datos de entrenamiento en lugar de aprender patrones generales

2. Crecen demasiado, creando reglas muy específicas que solo funcionan con los datos de entrenamiento

3. Funcionan mal con datos nuevos que no han visto antes

Ejemplo de sobreajuste
```text
Árbol sin podar:
Si edad > 30:
    Si ingresos > 50000:
        Si tiene hijos:
            Si vive en ciudad:
                Si tiene coche propio:
                    Si es casado:
                        → Compra (con 99% de precisión en entrenamiento)
                        → Pero falla con datos nuevos
```

Resumen de poda.
| Concepto | Explicación |
|----------|-------------|
| **¿Qué es?** | Técnica para reducir el tamaño del árbol eliminando ramas innecesarias |
| **¿Por qué?** | Para evitar sobreajuste y mejorar la generalización |
| **Pre-poda** | Detener el crecimiento antes (parámetros como `max_depth`) |
| **Post-poda** | Crecer completo y luego podar (parámetro `ccp_alpha`) |
| **CCP** | Poda por complejidad-coste, método de scikit-learn |
| **Alpha** | Controla cuánto se poda (mayor alpha = más poda) |
| **Resultado** | Árbol más pequeño, más generalizable y más interpretable |