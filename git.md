# git

**Git** es un sistema de control de versiones muy utilizado en el desarrollo de software. Fue creado por Linus Torvalds y es conocido por su eficiencia, flexibilidad y capacidad para gestionar proyectos de cualquier tamaño.


## crear cuenta GitHub

GitHub es un repositorio en la nube (como Google Drive o Dropbox) pero diseñada específicamente para código. GitHub se basa en una herramienta llamada Git (de ahí el nombre). Git es un sistema de control de versiones que corre en tu computadora. GitHub es simplemente un sitio web que aloja (guarda) tus proyectos de Git en la nube.

Crear cuenta.

* Ir a la página web: Abre tu navegador y ve a https://github.com.
* Iniciar el registro: Haz clic en el botón "Sign up" (Registrarse).
* Rellenar el formulario: Introduce la siguiente información:
    * Correo electrónico: Usa una dirección que revises con frecuencia, ya que recibirás notificaciones importantes.
    * Contraseña: Crea una contraseña segura y única.
    * Nombre de usuario: Elige un nombre único que te identifique. Aparecerá en la URL de tus repositorios (ej: github.com/tu-usuario). Una vez elegido, cambiarlo es complicado, así que tómate tu tiempo.
* Verificar que eres humano: Completa el pequeño rompecabezas o prueba de audio para demostrar que no eres un robot.
* Crear la cuenta: Haz clic en el botón "Create account" (Crear cuenta).
* Confirmar tu correo: Revisa la bandeja de entrada de tu correo electrónico. GitHub te enviará un código de verificación. Introdúcelo en la página para finalizar el registro.

## instalar git

[Instala desde](https://git-scm.com/downloads)

## configurar

```bash
# revisar la instalación
git --version
# configurar su nombre de usuario y mail que tiene en github
# para todos los repos de tu usuario windows
git config --global user.name "mi nombre en git hub"
git config --global user.email "miemail@mail"

# configurar como editor predeterminaddo a VSCode
git config --global core.editor "code --wait"
```

## clonar

```bash
git clone https://github.com/jflorespampano/actividades-ia.git
```

## actualizar

```bash
git pull
```

## etc

```bash
# cargar el editor desde la consola
core .
```

## Abrir una ventana de bash

1. ir a la carpeta
2. clic derecho/git bash here

## crear carpeta de entregas en GitHub

1. en su repositorio de Github de lado derecho, de clic en su foto de perfil.
2. seleccione `Repositories`
3. de clic en el botón verde `new`
4. elija el nombre de su repositorio por ejemplo `entregasia`
5. en la la seccion `Configuration/Choose visivility` elija `Public`
6. de clic en el botón `create repository`
7. copie la direccion de su repositorio que se muestra en la venta se verá algo como: `https://github.com/suusuario/entregasia.git`

## crear la carpeta de entregas en local

Para usar el repositorio que acaba de crear en GitHub tiene varias opciones, si aun no tiene un repositorio en local, la mas sencilla es clonarlo:

1. vaya a la carpeta de trabajo (abra una ventana de bash en su carpeta de trabajo)
2. para clonar el repositorio, en su ventana de bash ejecute:
```
git clone https://github.com/suusuario/entregasia.git
```

## primera entrega

1. en su repositorio clonado, crear la estructura de carpetas siguiente:
```text
entregasia/
├── recpat/    # Reconocimiento de Patrones
├── se/        # Sistemas Expertos
├── alg/       # Algoritmos de IA
└── pp/        # Programación en paralelo
    readme.md  # datos como su matrucla, nombre, materia, nombre del profesor, etc.
```
2. Para la primera actividad haga: crear una carpeta dentro de su repositorio local donde ubicara la entrega, por ejemplo, la actividad 1 ira: en:
```text
entregasia/
├── recpat/    # Reconocimiento de Patrones
├── se/        # Sistemas Expertos
     └── actividad1
├── alg/       # Algoritmos de IA
└── pp/        # Programación en paralelo
    readme.md
```
3. en la carpeta actividad1, iran los archivos de la actividad, como ejemplo en la carpeta actividad1 ponga un archivo *readme.md* y dentro coloque su matricula y su nombre (imagine que esa es la actividad solicitada).
4. Para subir la actividad, abra una consola de bash en la carpeta raiz `entregasia` y ejecute los comandos:
   ```bash
   # si esta dentro de Vscode, aegurese que tiene todo guardado o de *ctrl+s* para guardar archivo.
   # ejecute
   git add .
   # ejecute
   git commit -m "subiento actividad 1"
   # ejecute
   git push
   ```
5. listo ha subido su actividad, copie la direccion de su repositorio y entreguela en la tarea solicitada en Teams.

## entregas posteriores

1. crear la carpeta de su acticvidad y cargue sus archivos.
2. ejecute.
   ```
   git add .
   git commit -m "subiendo actividad i"
   git push
   ```
3. listo ha subido su actividadi

>nota: En su repositorio de GitGHub no puede subir archivos mayores de 1Mb, no suba videos, si puede subir archivos pdf, word, ppt, excell, archivos de código, imagenes, mark down. Aunque puede subir archivos word y ppt, yo nunca le pediré subirlos en su lugar pedire archivos pdf. Para la actividad de árboles si le pedire un archivo Excell.

Para entender el significado de los comandos: `git add .` , `git commit -m "subiendo actividad i"` y `git push`, consulte con su profesor en clase.