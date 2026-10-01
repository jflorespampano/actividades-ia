# Google colab

El problema de la capacidad del equipo, los requerimientos para ejecutar modelos de Machine Learning:

| Nivel | Componente | Especificación Sugerida | ¿Para qué alcanza? |
| :--- | :--- | :--- | :--- |
| **Inicial** | GPU | NVIDIA con 8 GB VRAM (ej. RTX 5060) | Ejecutar modelos pequeños (7B cuantizados), aprendizaje y pruebas. |
| | CPU | Ryzen 5 / Core i5 (6 núcleos) | |
| | RAM | 16 GB | |
| | Almacenamiento | SSD NVMe 500 GB - 1 TB | |
| **Intermedio** | GPU | NVIDIA con 12-16 GB VRAM (ej. RTX 5070 Ti) | Fine-tuning de modelos medianos, ejecución fluida de modelos 13B. |
| | CPU | Ryzen 7 / Core i7 (8 núcleos) | |
| | RAM | 32 GB | |
| | Almacenamiento | SSD NVMe 1-2 TB | |
| **Avanzado** | GPU | NVIDIA con 24+ GB VRAM (ej. RTX 4090/5090) | Fine-tuning eficiente de LLMs (7B-13B) con QLoRA, entrenamiento serio. |
| | CPU | Ryzen 9 / Core i9 o superior | |
| | RAM | 64 GB o más | |
| | Almacenamiento | SSD NVMe 2 TB+ | |

Una opción es usar un servicio de computo en la nube.

**Google Colab (Google Colaboratory)** es un servicio gratuito en la nube de Google que permite escribir y ejecutar código Python directamente en el navegador, sin instalar nada en tu computadora.

Está basado en Jupyter Notebook, así que los archivos tienen extensión .ipynb y se organizan en celdas: unas para código y otras para texto.

**Se usa mucho para:**
* Análisis de datos
* Machine Learning e Inteligencia Artificial
* Deep Learning con TensorFlow, PyTorch, etc.
* Visualización de datos
* Tareas académicas y proyectos
* Prototipos rápidos
* Enseñar programación

**Características principales:**
* No requiere instalación: solo necesitas una cuenta de Google y un navegador.
* Se ejecuta en servidores de Google, no en tu PC.
* GPU y TPU gratis (con límites de uso), útil para entrenar modelos.
* Integración con Google Drive: puedes guardar y leer archivos.
* Bibliotecas preinstaladas: NumPy, pandas, matplotlib, TensorFlow, PyTorch, etc.
* Colaboración en tiempo real, como en Google Docs.
* Puedes instalar paquetes con !pip install.
* Se puede conectar con GitHub, Kaggle y otros servicios.

# Crear un archivo en Google Colab 

Para crear un cuaderno de Colab (.ipynb), tienes las opciones:

## Desde la web de Colab

1. Entra a: https://colab.research.google.com
2. Inicia sesión con tu cuenta de Google.
3. Haz clic en *Nuevo cuaderno / New notebook*.
4. Se abrirá un cuaderno nuevo llamado algo como *Untitled.ipynb*.
5. Haz clic en ese nombre para cambiarlo, por ejemplo: *mi_analisis.ipynb*.
6. Para guardarlo: Archivo > Guardar o Ctrl + S.
    * Se guarda en tu Google Drive, dentro de la carpeta Colab Notebooks.
7. Para descargarlo: *Archivo > Descargar > Descargar .ipynb*.

## Desde Google Drive
1. Abre Google Drive.
2. Clic en Nuevo > Más > Google Colaboratory.
3. Si no aparece:
    * Clic en *Nuevo > Más > Conectar más apps*.
    * Busca *Colaboratory* y conéctala.
4. Luego crea el cuaderno normalmente.
