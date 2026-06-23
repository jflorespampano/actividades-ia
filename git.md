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

Abrir una ventana de bash

1. ir a la carpeta
2. clic derecho/git bash here