import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Datos
X1 = np.array([0, 0, 1, 1])
X2 = np.array([0, 1, 0, 1])
#Z = X1 * X2  # Característica creada
Z=(X1 - X2) ** 2
Y = np.array([0, 1, 1, 0])  # Salida esperada

# Crear figura 3D
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# Colores según la salida
colors = ['red' if y == 0 else 'green' for y in Y]

# Dibujar puntos
scatter = ax.scatter(X1, X2, Z, c=colors, s=200, 
                     edgecolors='black', linewidth=2, depthshade=True)

# Añadir etiquetas a los puntos
for i in range(len(X1)):
    ax.text(X1[i], X2[i], Z[i], 
            f'({X1[i]},{X2[i]},{Z[i]})\nY={Y[i]}', 
            fontsize=10, ha='center')

# Dibujar el plano que aprende el perceptrón:
# Fórmula: -0.5 + 1·X1 + 1·X2 - 2·Z = 0  →  Z = 0.5 + 0.5·X1 + 0.5·X2
xx, yy = np.meshgrid(np.linspace(-0.5, 1.5, 10), 
                     np.linspace(-0.5, 1.5, 10))
zz = 0.5 + 0.5*xx + 0.5*yy  # Plano de separación

ax.plot_surface(xx, yy, zz, alpha=0.3, color='blue', 
                label='Plano de separación')

# Configurar ejes
ax.set_xlabel('X1', fontsize=12, fontweight='bold')
ax.set_ylabel('X2', fontsize=12, fontweight='bold')
ax.set_zlabel('Z = (X1-X2)**2', fontsize=12, fontweight='bold')
ax.set_title('Perceptrón XOR - Ingeniería de Características en 3D', 
             fontsize=14, fontweight='bold')

# Leyenda personalizada
from matplotlib.patches import Patch
legend_elements = [Patch(facecolor='red', label='Y = 0 (Clase 0)'),
                   Patch(facecolor='green', label='Y = 1 (Clase 1)'),
                   Patch(facecolor='blue', alpha=0.3, label='Plano separador')]
ax.legend(handles=legend_elements, loc='upper left')

# Ángulo de vista para mejor visualización
ax.view_init(elev=25, azim=-60)

plt.tight_layout()
plt.show()