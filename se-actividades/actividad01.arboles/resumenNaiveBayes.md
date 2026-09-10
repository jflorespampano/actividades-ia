# Naive Bayes 

## Teorema de la Probabilidad Total

**La fórmula de Naive Bayes es una aplicación directa y conjunta del Teorema de Bayes y el Teorema de la Probabilidad Total**.

---

## 1. El Teorema de Bayes (la base)

El clasificador Naive Bayes se llama así porque aplica el **Teorema de Bayes**:

$$
P(C_k | \mathbf{x}) = \frac{P(\mathbf{x} | C_k) \cdot P(C_k)}{P(\mathbf{x})}
$$

Donde:

- $C_k $ = clase (ej: "spam" o "no spam").
- $\mathbf{x}$ = vector de características (ej: palabras de un correo).
- $P(C_k | \mathbf{x})$ = probabilidad *a posteriori* (lo que queremos calcular).
- $P(\mathbf{x} | C_k)$ = verosimilitud.
- $P(C_k)$ = probabilidad *a priori*.
- $P(\mathbf{x})$ = **evidencia** o **probabilidad marginal**.

---

## 2. ¿Dónde entra el Teorema de la Probabilidad Total?

El denominador de Bayes, **$P(\mathbf{x})$**, se calcula casi siempre usando el **Teorema de la Probabilidad Total**.

Si las clases $ C_1, C_2, ..., C_n $ son mutuamente excluyentes y cubren todo el espacio muestral, entonces:

$$P(\mathbf{x}) = \sum_{k=1}^{n} P(\mathbf{x} | C_k) \cdot P(C_k)$$

Es decir, **la probabilidad de observar $ \mathbf{x} $** es el promedio ponderado (por las probabilidades a priori) de la verosimilitud de $ \mathbf{x} $ en cada clase.

---

## 3. Ejemplo numérico

Clasificar un correo con la palabra **"oferta"**  ($x=oferta$):

- $ C_1 = Spam $, $ P(Spam) = 0.4 $
- $ C_2 = No Spam $, $ P(No Spam) = 0.6 $
- $ P("oferta" | Spam) = 0.8 $
- $ P("oferta" | No Spam) = 0.1 $

**Paso 1: Probabilidad Total (el denominador)**

$$P(\mathbf{x}) = \sum_{k=1}^{n} P(\mathbf{x} | C_k) \cdot P(C_k)$$
$$k \in \{\text{Spam}, \text{No Spam}\}$$


$$P("oferta") = P(\mathbf{oferta} | Spam) \cdot P(Spam) + P(\mathbf{oferta} | No Spam) \cdot P(No Spam)$$
$$P("oferta") = (0.8 \cdot 0.4) + (0.1 \cdot 0.6) = 0.32 + 0.06 = 0.38$$

**Paso 2: Teorema de Bayes**

$$P(Spam | "oferta") = \frac{0.8 \cdot 0.4}{0.38} = \frac{0.32}{0.38} \approx 0.842$$

**Sin la Probabilidad Total, no podríamos calcular el denominador** y, por tanto, no obtendríamos la probabilidad a posteriori.

---

## 4. El "Naive" (ingenuo) 

El teorema de Bayes dice:

$$P(\mathbf{c} | x_1,...x_n) = \frac{P(c) \cdot P(x_1,...x_n|c)}{P(x_1,...x_n)}$$

El adjetivo *Naive* viene de la aplicación de la **suposición  (igenua) de independencia condicional** que aplicandola tenemos que:

$$P(x_1,...x_n) = P(x_1|c) \cdot P(x_2|c) ... P(x_n|c) $$
$$P(x_1,...x_n) = \prod_{i=1}^{n} P(x_i|C) $$


Entonces la formula de bayes queda:

$$P(\mathbf{c} | x_1...x_n) = \frac {P(c) \cdot \prod_{i=1}^{n} P(x_i|C)}{P(x_1,...x_n)} $$

Dado que $P(x_1,…,x_n)$ es constante, Tomemos $px= P(x1,…,xn)$. Vemos que al comparar 2 valores (a/px) y (b/px) , como px es positivo y constante (a/px) > (b/px) implica que a>b dada la entrada, por tanto podemos eliminar el denominador sin afectar la escencia de la formula:

$$P(\mathbf{c} | x_1...x_n) = {P(c) \cdot \prod_{i=1}^{n} P(x_i|c)} $$


## Algoritmo

* Paso 1: Para cada clase $c_j$, calcular la probabilidad, dados los atributos $x_i$:
$$P(\mathbf{c_j} | x_1...x_n) = {P(c_j) \cdot \prod_{i=1}^{n} P(x_i|c_j)} $$

* Pass 2: seleccionar la clase con mayor probabilidad

## Versión con logaritmos

El underflow ocurre cuando una operación matemática produce un resultado tan cercano a cero
que no puede ser representado con precisión dentro del rango de números que puede manejar un
computador. En Naive Bayes, esto sucede porque multiplicamos muchas probabilidades (valores entre 0 y 1), y el producto resultante puede ser increíblemente pequeño, por ejemplo: 10−1000
. Las computadoras tienen un límite en la precisión de números decimales (usualmente alrededor de 10 −324 en doble precisión), y cualquier valor por debajo de ese límite se redondea a 0.0.

Para evitar underflow aplicar la formula:

$$clasePredicha = max(c_j) \cdot [{log(P(c_j))}+{\sum {log(P(x_i | c_j))}}] $$
