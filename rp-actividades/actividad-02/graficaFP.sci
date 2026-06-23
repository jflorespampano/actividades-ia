// Función de pérdida típica: L(w) = (w - a)² + (w - b)²
// Para dos parámetros: L(w1, w2) = (w1 - a)² + (w2 - b)²

// Definir rango de parámetros
w1 = linspace(-5, 5, 50);
w2 = linspace(-5, 5, 50);

// Crear malla 2D
[W1, W2] = meshgrid(w1, w2);

// Definir función de pérdida (ejemplo con mínimo en (2, -1))
a = 2;
b = -1;
L = (W1 - a).^2 + (W2 - b).^2;

// Crear gráfica 3D
clf()
f = gcf();
f.color_map = jetcolormap(64);  // Mapa de colores

// Superficie 3D
surf(W1, W2, L)
title('Función de Pérdida Cuadrática en 3D', 'fontsize', 3)
xlabel('Parámetro w1', 'fontsize', 2)
ylabel('Parámetro w2', 'fontsize', 2)
zlabel('Pérdida L(w1, w2)', 'fontsize', 2)
colorbar()  // Barra de colores
