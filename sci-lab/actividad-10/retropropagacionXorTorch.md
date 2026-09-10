# Retropropagación

La retropropagación es el algoritmo que permite entrenar redes neuronales con múltiples capas. Resuelve el problema que de: cómo ajustar los pesos de una red con muchas capas cuando el error se calcula solo al final.

Idea intuitiva

Imagina una red como una cadena de personas pasándose un mensaje (la información fluye hacia adelante: forward pass). Al final, alguien dice "el mensaje llegó mal, se equivocaron por X". Ahora hay que averiguar quién contribuyó más al error y decirle cuánto debe corregir su parte.

La retropropagación hace exactamente eso: propaga el error hacia atrás, capa por capa, usando la regla de la cadena (chain rule) del cálculo diferencial, para saber cuánto debe ajustarse cada peso.

## Los dos pasos
1. Forward pass: los datos pasan por la red, capa por capa, hasta producir una predicción.
2. Backward pass: se calcula el error (pérdida), y usando derivadas, se calcula el gradiente de ese error respecto a cada peso. Luego se actualizan los pesos en la dirección que reduce el error (descenso de gradiente).

$$w \leftarrow w - \eta \cdot \frac{\partial L}{\partial w}$$

Donde
* L=funcion de perdida (loss)
* $\eta$ = tasa de aprndizaje
* $\frac{\partial L}{\partial w}$ = gradiente (que tanto influye ese peso en el error)

## PyTorch es ideal para esto
PyTorch tiene autograd, un sistema de diferenciación automática. Tú solo defines el forward pass, y PyTorch construye automáticamente un "grafo computacional" que le permite calcular todos los gradientes por ti al llamar .backward().

## Ejemplo: Red neuronal(XOR) con backprop

Resolvamos el problema que el perceptrón simple no podía resolver: XOR.

```python
import torch
import torch.nn as nn
import torch.optim as optim

# Datos: la función XOR
X = torch.tensor([[0.,0.], [0.,1.], [1.,0.], [1.,1.]])
y = torch.tensor([[0.], [1.], [1.], [0.]])

# --- Definimos la arquitectura: red con una capa oculta ---
class RedXOR(nn.Module):
    def __init__(self):
        super().__init__()
        self.capa1 = nn.Linear(2, 4)   # 2 entradas -> 4 neuronas ocultas
        self.capa2 = nn.Linear(4, 1)   # 4 neuronas -> 1 salida
        self.activacion = nn.Sigmoid()

    def forward(self, x):
        x = self.activacion(self.capa1(x))
        x = self.activacion(self.capa2(x))
        return x

modelo = RedXOR()
criterio = nn.MSELoss()                          # función de pérdida
optimizador = optim.SGD(modelo.parameters(), lr=0.5)  # descenso de gradiente

# --- Entrenamiento ---
for epoca in range(3000):
    # 1. Forward pass: predicción
    y_pred = modelo(X)

    # 2. Calcular la pérdida
    loss = criterio(y_pred, y)

    # 3. Reiniciar gradientes acumulados (paso clave, se olvida seguido)
    optimizador.zero_grad()

    # 4. Backward pass: retropropagación del error
    loss.backward()

    # 5. Actualizar los pesos usando los gradientes calculados
    optimizador.step()

    if epoca % 500 == 0:
        print(f"Época {epoca}, pérdida: {loss.item():.4f}")

# --- Probamos la red entrenada ---
print("\nResultados finales:")
with torch.no_grad():   # no necesitamos gradientes solo para predecir
    for xi, yi in zip(X, y):
        pred = modelo(xi)
        print(f"Entrada: {xi.tolist()} -> Predicción: {pred.item():.4f} (esperado: {yi.item()})")
```

Arquitectura de esta red:
```text
Entrada (2) 
    ↓
[Linear(2→4)] → (z1) 
    ↓
[Sigmoid] → (h)
    ↓
[Linear(4→1)] → (z2)
    ↓
[Sigmoid] → (salida, 0-1)
```

## torch

torch.nn es el submódulo de PyTorch dedicado a construir redes neuronales. Contiene todos los "bloques de construcción" ya hechos: capas, funciones de activación, funciones de pérdida, etc. En lugar de programar cada operación matemática a mano (como multiplicar por pesos, sumar el bias, aplicar sigmoid...), usas piezas prefabricadas de torch.nn y las combinas.

## Las tres piezas principales de torch.nn

1. nn.Module — la clase base de toda red

Cualquier red neuronal en PyTorch hereda de nn.Module.

```python
import torch.nn as nn

class RedXOR(nn.Module):
    def __init__(self):
        super().__init__()          # inicializa la maquinaria interna de nn.Module
        self.capa1 = nn.Linear(2, 4)
        self.capa2 = nn.Linear(4, 1)

    def forward(self, x):
        # Define cómo fluyen los datos hacia adelante
        x = torch.sigmoid(self.capa1(x))
        x = torch.sigmoid(self.capa2(x))
        return x
```

nn.Module te da automáticamente:

* Seguimiento de parámetros: sabe qué tensores son pesos entrenables (para dárselos al optimizador con modelo.parameters()).
* Organización jerárquica: puedes anidar módulos dentro de módulos.
* Modo entrenamiento/evaluación: modelo.train() / modelo.eval() (útil para capas que se comportan distinto en cada modo, como Dropout).

2. Capas (layers)

Son las piezas que transforman los datos. La más común:

```python
capa = nn.Linear(in_features=2, out_features=4)
```

Esto crea una transformación lineal: 
$𝑦 = 𝑥 \cdot 𝑊^𝑇+𝑏$, donde W y b son tensores con requires_grad=True automáticamente — no tienes que crearlos tú.

Otras capas comunes:

| Capa | Uso típico |
|------|------------|
| `nn.Linear(in, out)` | Capa totalmente conectada (fully connected) |
| `nn.Conv2d(in_ch, out_ch, kernel_size)` | Convolución 2D, para imágenes |
| `nn.LSTM` / `nn.GRU` | Capas recurrentes, para secuencias/texto |
| `nn.Embedding(num, dim)` | Convierte índices (palabras) en vectores |
| `nn.Dropout(p)` | Apaga neuronas al azar para evitar sobreajuste |
| `nn.BatchNorm1d`/`2d` | Normaliza activaciones entre capas |

3. Funciones de activación y de pérdida

```python
# Activaciones (introducen no linealidad)
nn.ReLU()
nn.Sigmoid()
nn.Tanh()
nn.Softmax(dim=1)

# Funciones de pérdida (loss)
nn.MSELoss()         # error cuadrático medio, para regresión
nn.CrossEntropyLoss()  # para clasificación multiclase
nn.BCELoss()          # para clasificación binaria
```

