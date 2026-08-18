# Resumen: Sistemas Expertos Basados en Reglas
*Origen: Universidad de Sevilla (Dpto. de Ciencias de la Computación e IA)*

El documento detalla cómo las reglas deterministas se utilizan dentro de la Inteligencia Artificial para modelar situaciones complejas mediante la lógica clásica, sirviendo como base teórica antes de introducir modelos probabilísticos más avanzados.

Aqui un resumen:

---

## Componentes Clave

* **Base de Conocimiento:** Almacena las reglas declarativas (estructuras `SI... ENTONCES`) y los hechos iniciales que definen el problema.
* **Motor de Inferencia:** Aplica la lógica matemática para combinar los hechos de la memoria de trabajo con las reglas y deducir nuevos datos.
* **Control de Coherencia:** Subsistema encargado de validar que las nuevas reglas no contradigan a las existentes y de eliminar valores "no factibles" que generen inconsistencias.
* **Subsistema de Explicación:** Suministra al usuario la secuencia lógica y la lista de reglas ejecutadas que justifican la conclusión obtenida.

---

## Reglas de Inferencia Utilizadas

1. **Modus Ponens:** Inferencia hacia adelante; si la premisa es verdadera, se concluye de forma directa que la consecuencia también lo es.
$$ \frac{P \rightarrow Q, \quad P}{\therefore Q} $$
o
$$ ((P \rightarrow Q) \land P) \rightarrow Q $$
2. **Modus Tollens:** Inferencia hacia atrás; si la conclusión es falsa, se deduce que la premisa de origen obligatoriamente es falsa.
$$ \frac{P \rightarrow Q, \quad \neg Q}{\therefore \neg P} $$

Como tautología lógica en una sola línea:

$$ ((P \rightarrow Q) \land \neg Q) \rightarrow \neg P $$
3. **Mecanismo de Resolución:** Método para obtener conclusiones compuestas mediante la combinación y simplificación de expresiones lógicas equivalentes.

---

## Estrategias de Control

* **Encadenamiento hacia adelante:** Parte de los hechos conocidos para activar reglas de forma sucesiva hasta que no se puedan derivar más conclusiones.
* **Encadenamiento hacia atrás:** Se selecciona una variable objetivo y el algoritmo navega en reversa buscando los hechos necesarios; si faltan, interroga al usuario.
* **Compilación de reglas:** Combina múltiples reglas interconectadas en ecuaciones lógicas directas para agilizar la velocidad de cómputo del motor.

---

## Ejemplos Prácticos donde se puede aplicar

* **Cajero automático:** Modelado de la verificación de tarjetas, solicitudes de NIP, límites diarios y autorizaciones de retiro.
* **Problema de los agentes secretos:** Acertijo lógico resuelto mediante restricciones de coherencia de hechos donde un agente siempre miente.
* **Control de tráfico ferroviario:** Diseño de un sistema experto con 14 señales lógicas para coordinar el paso seguro de trenes y evitar colisiones.

---

## Limitación Principal

* **Rigidez determinista:** La lógica clásica se queda corta ante diagnósticos médicos u escenarios reales donde existe **incertidumbre**, planteando la necesidad de transicionar hacia sistemas probabilísticos.
