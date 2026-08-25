# Clasificar con arboles

## python

```bash
where python # ver donde apunta la variable de entorno python
python --version
# si no muestra 3.12.x , deberas instalar la version 3.12

```

## instala Python 3.12.x 

Desde su sitio oficial isnstala python

[Descargar](https://www.python.org/downloads/)

## Lanzador py

Si estas en Windows puedes usa `py` (solo en windows) que es el lanzador de python independientemente de la versión que por default que este activa.

```bash
py -0 # muestra las versiones de python instaldas 

# Ejecutar un script con Python 3.12
py -3.12 mi_script.py

# Ejecutar el mismo script con Python 3.10
py -3.10 mi_script.py

# Abrir el intérprete interactivo de Python 3.12
py -3.12

# actualizar pip
py -3.12 -m pip install --upgrade pip
```

Instalar bibliotecas con py (ejemplos):
```bash
py -<versión> -m pip install <nombre_del_paquete>

# Instalar la biblioteca pandas en Python 3.12
py -3.12 -m pip install pandas

# Instalar requests en Python 3.10
py -3.10 -m pip install requests

# Instalar múltiples paquetes a la vez en Python 3.12
py -3.12 -m pip install numpy matplotlib scikit-learn

# Instalar una versión específica de un paquete
py -3.12 -m pip install django==4.2.0

# ver paquetes instalados
py -3.12 -m pip list

# desinstalar paquete
py -3.12 -m pip uninstall pandas
```


## Entornos virtuales

Para evitar colisiones en bibliotecas es recomendable usar entornos virtuales

```bash
# Crear un entorno virtual con Python 3.12
py -3.12 -m venv mi_entorno

# Activar el entorno (Windows)
mi_entorno\Scripts\activate

# Ahora pip instala solo dentro de este entorno
pip install pandas


# desactivar entorno
deactivate
```

## Actividad 1 árbol

Si aun no la has hecho, instala python 3.12.x

### Crear ambiente virtual
0. instala python 3.12.x
1. crea una carpeta llamada clasificarIris, copia ahi los archivos: `irisArbol.py`, `irisTF.py`
2. abre una ventana de bash en esa carpeta
3. crea el ambiente así:
```bash
# Crear un entorno virtual con Python 3.12
py -3.12 -m venv mi_entorno

# Activar el entorno (Windows)
source mi_entorno/Scripts/activate

# actualiza pip
py -3.12 -m pip install --upgrade pip

# instala bibliotecas
pip install tensorflow pandas matplotlib seaborn scikit-learn

# ver que hay instalado
pip list
```
4. Ejecuta el archivo `irisArbol.py`
```bash
# como tienes activo tu entorno puedes usar el comando `python`
# prueba poner:
python --version # deberas ver: Python 3.12.10
# ejecuta rutina de clasificacion por árbol de decisión
python irisArbol.py

# desactiva entorno
deactivate
```

## Actividad 2 (Tensor Flow)

Para esta actividad ya no tendras que crear la carpeta ni el ambiente ni cargar bibliotecas, pues ya lo hiciste en la actividad 1. Ahora solamente, activa el entorno y ejecuta el archivo:

```bash
# Activar el entorno (Windows)
source mi_entorno/Scripts/activate

#ejecutar rutina d redes neuronales
python irisTF.py

deactivate
```