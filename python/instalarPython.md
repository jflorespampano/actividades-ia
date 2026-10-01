# python

Puedes usar Python 3.13+ para machine learning, siempre que instales las versiones más recientes de TensorFlow y PyTorch. Si por alguna razón no toienes oporte en las bibliotecas de ML, te conviene usar Python 3.12, que tiene un ecosistema más maduro y sin sorpresas.

## Descargar versión anterior de Python

Para Tensor Flow, necesitaremos la version 3.12.x

Para usar esta versión tenemos 2 opciones

## Opcion A

Ver que versiones de python tienes instaladas
```bash
where python
```
Debes tener instalada una versión de python compatible con tensorflow (versiones 3.12 o menor), si no la tienes, instalala desde [python 3.12](https://www.python.org/downloads/windows/), para esto haz lo siguiente:

1. Ve a la página oficial de descargas: python.org/downloads/windows
2. Busca la versión Python 3.12.x (la última de la serie 3.12) y descarga el instalador (Windows installer - 64-bit).
3. Ejecuta el instalador y marca la opción "Add Python to PATH" en la primera pantalla.
4. Haz clic en "Install Now" y espera a que termine la instalación.

Verificar la instlación:
```bash
py -3.12 --version
#Python 3.12.10
```
>! Nota: observa que estamos usando el comando **py** y no **python**, **py.exe** es un manejador de versiones de python incluido en las instalaciones de python para windows

## Crear entorno virtual para una versión específica de python

Es recomendable crear un entorno virtual para evitar colisiones con bibliotecas

Crear entorno virtual para la version 3.12, en una consola de bash, haz lo siguiente:
```bash
# en una consola de bash:
# crea un entorno virtual con el comando
# py -3.12 -m venv nombre_mi_entorno # por ejemplo: 
py -3.12 -m venv entorno3.12
#activa entorno virtual
source entorno3.12/Scripts/activate
#verifica que estamos usando python 3.12 dentro del entorno
python --version
```

## instalar bibliotecas

Para realizar nuestros ejercicios necesitaremos varias bibliotecas que descargamos con el comando pip.

1. con el entorno virtual activado
2. instala las bibliotecas:

```sh
# Actualizar pip del entorno virtual si en necesario
C:/trabajo/ia/python/prueba1/entorno3.12/Scripts/python.exe -m pip install --upgrade pip #antes de python.exe pon la ruta de la carpeta Scripts de tu entorno virtual en mi caso: `C:/trabajo/ia/python/prueba1/entorno3.12`

# instalar las bibliotecas
pip install tensorflow
pip install pandas
pip install matplotlib
pip install seaborn scikit-learn

# ver que hay instalado
pip freeze
```
3. Ahora puedes programar usando tu entorno virtual

4. Salir del enotrno virtual
```bash
deactivate
```

Ahora cada vez que quieras trabajar con el entorno virtual deberás activarlo solamente (`source entorno3.12/Scripts/activate`):

## Opcion B

si tienes instalada la version 3.13.x o superior

* instala la version 3.12.x y agregala al path
* en la variable de entorno path pon las carpetas `python3.12.x/Scripts` y `pyton3.12.x` antes de sus respectivas carpetas de `python3.13.x`.