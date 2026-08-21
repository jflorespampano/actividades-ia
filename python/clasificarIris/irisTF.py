# dataset iris clasificación con red neuronal con bibliotecas: tensorflow, pandas, numpy, matplotlib, seaborn, scikit-learn
# trabaja sobre python 3.12 o sobre un ambiente virtual python 3.12
# se requiere instalas las bibliotecas: tensorflow, pandas, numpy, matplotlib, seaborn, scikit-learn

import os
# Controlar el nivel de verbosidad (cantidad de mensajes) que TensorFlow muestra en consola.
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'  # # 0: todos, 1: info, 2: warnings, 3: errores
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'

import tensorflow as tf
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.metrics import classification_report, confusion_matrix

print("TensorFlow version:", tf.__version__)

# Paso 1: cargar modelo y dataset
# load_iris() devuelve un objeto Bunch (similar a un diccionario) que contiene 7 atributos principales.
# print(iris.keys()) # dict_keys(['data', 'target', 'frame', 'target_names', 'DESCR', 'feature_names', 'filename'])
iris = load_iris()
X = iris.data  # Características: [sepal_length, sepal_width, petal_length, petal_width]
y = iris.target  # Etiquetas: 0=setosa, 1=versicolor, 2=virginica
feature_names = iris.feature_names
target_names = iris.target_names

print("Forma de los datos:", X.shape)
print("Características:", feature_names)
print("Especies:", target_names)
print("\nPrimeras 5 filas:")
print(pd.DataFrame(X, columns=feature_names).head())

# Paso 2: preprocesamiento
# Dividir conjunto de datos en entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# Escalar características (importante para redes neuronales)
# Estandarizamos las características (features) para que tengan media = 0 y desviación estándar = 1.
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train) # Calcula estadísticas (media/std) de X_train Y las aplica a X_train
X_test_scaled = scaler.transform(X_test) # Aplica las estadísticas YA calculadas de X_train a X_test

print(f"Datos de Entrenamiento: {X_train_scaled.shape}")
print(f"Datos de Prueba: {X_test_scaled.shape}")
print(f"Distribución de clases en entrenamiento: {np.bincount(y_train)}")
print(f"Distribución de clases en prueba: {np.bincount(y_test)}")

# Paso 3: crear modelo

def crear_modelo_basico():
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(64, activation='relu', input_shape=(4,)),
        tf.keras.layers.Dropout(0.3),
        tf.keras.layers.Dense(32, activation='relu'),
        tf.keras.layers.Dropout(0.3),
        tf.keras.layers.Dense(3, activation='softmax')  # 3 clases de salida
    ])

    model.compile(
        optimizer='adam',
        loss='sparse_categorical_crossentropy',  # Para etiquetas enteras
        metrics=['accuracy']
    )

    return model

modelo_basico = crear_modelo_basico()
modelo_basico.summary()


# Paso 4: Entrenamiento del modelo
# Callbacks para mejorar el entrenamiento
early_stopping = tf.keras.callbacks.EarlyStopping(
    monitor='val_loss', patience=20, restore_best_weights=True
)

reduce_lr = tf.keras.callbacks.ReduceLROnPlateau(
    monitor='val_loss', factor=0.5, patience=10, min_lr=0.0001
)

# Entrenar el modelo
print("Iniciando entrenamiento...")
history = modelo_basico.fit(
    X_train_scaled, y_train,
    epochs=200,
    batch_size=16,
    validation_data=(X_test_scaled, y_test),
    callbacks=[early_stopping, reduce_lr],
    verbose=1
)

print("✅ Entrenamiento completado!")

# Paso 5: Evaluación del modelo
# Evaluar el modelo
test_loss, test_accuracy = modelo_basico.evaluate(X_test_scaled, y_test, verbose=0)
print(f"Precisión en prueba: {test_accuracy:.4f}")
print(f"Pérdida en prueba: {test_loss:.4f}")

# Gráficas de entrenamiento
def plot_training_history(history):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(15, 5))

    # Precisión
    ax1.plot(history.history['accuracy'], label='Precisión entrenamiento')
    ax1.plot(history.history['val_accuracy'], label='Precisión validación')
    ax1.set_title('Precisión del modelo')
    ax1.set_xlabel('Época')
    ax1.set_ylabel('Precisión')
    ax1.legend()
    ax1.grid(True)

    # Pérdida
    ax2.plot(history.history['loss'], label='Pérdida entrenamiento')
    ax2.plot(history.history['val_loss'], label='Pérdida validación')
    ax2.set_title('Pérdida del modelo')
    ax2.set_xlabel('Época')
    ax2.set_ylabel('Pérdida')
    ax2.legend()
    ax2.grid(True)

    plt.tight_layout()
    plt.show()

plot_training_history(history)

# Paso 6: Predicciones y métricas
# Hacer predicciones
y_pred_proba = modelo_basico.predict(X_test_scaled)
y_pred = np.argmax(y_pred_proba, axis=1)

# Reporte de clasificación
print("Reporte de clasificación:")
print(classification_report(y_test, y_pred, target_names=target_names))

# Matriz de confusión
def plot_confusion_matrix(y_true, y_pred, class_names):
    cm = confusion_matrix(y_true, y_pred)
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', 
                xticklabels=class_names, yticklabels=class_names)
    plt.title('Matriz de Confusión - Iris Dataset')
    plt.ylabel('Etiqueta Real')
    plt.xlabel('Etiqueta Predicha')
    plt.show()

plot_confusion_matrix(y_test, y_pred, target_names)

# Probabilidades de predicción
print("\nProbabilidades de predicción (primeras 5 muestras):")
for i in range(5):
    print(f"Muestra {i+1}: {y_pred_proba[i]} → Predicción: {target_names[y_pred[i]]}")
