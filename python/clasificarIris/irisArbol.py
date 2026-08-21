# Importar bibliotecas necesarias
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.datasets import load_iris
from sklearn import tree
import matplotlib.pyplot as plt

# 1. Cargar un dataset de ejemplo (Iris)
iris = load_iris()
X = iris.data          # Características (largo y ancho de sépalos/pétalos)
y = iris.target        # Etiquetas (tipo de flor)

# 2. Dividir en entrenamiento (70%) y prueba (30%)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# 3. Crear y entrenar el árbol de decisión
# La función DecisionTreeClassifier de la librería scikit-learn implementa el algoritmo CART (Classification and Regression Trees)
clf = DecisionTreeClassifier(max_depth=3, random_state=42)  # Limitamos profundidad para evitar sobreajuste
clf.fit(X_train, y_train)

# 4. Evaluar el modelo
precision = clf.score(X_test, y_test)
print(f"Precisión en el conjunto de prueba: {precision:.2f}")

# 5. Visualizar el árbol
plt.figure(figsize=(12, 8))
tree.plot_tree(clf, 
               feature_names=iris.feature_names, 
               class_names=iris.target_names,
               filled=True, 
               rounded=True)
plt.title("Árbol de Decisión - Dataset Iris")
plt.savefig("arbol_decision.png")  # Guardar como imagen
plt.show()

# 6. Hacer una predicción con nuevos datos
nueva_flor = [[5.1, 3.5, 1.4, 0.2]]  # Ejemplo: setosa
prediccion = clf.predict(nueva_flor)
print(f"La flor nueva es: {iris.target_names[prediccion[0]]}")