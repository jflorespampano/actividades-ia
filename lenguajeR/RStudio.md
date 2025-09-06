# RStudio

RStudio es un Entorno de Desarrollo Integrado (IDE) para el lenguaje de programación R. Es la herramienta más popular y ampliamente utilizada por la comunidad de R en todo el mundo.

Tiene 4 paneles principales:
* editor (esq. sup. izq.)
* consola de r (esq. inf. izq.)
* Environment/Historial (Esquina superior derecha)
    * Environment: Variables y datos cargados
    * History: Historial de comandos ejecutados
    * Connections: Conexiones a bases de datos
* Files/Plots/Paquetes/Ayuda (Esquina inferior derecha)
    * Files: Explorador de archivos
    * Plots: Visualización de gráficos
    * Packages: Gestión de paquetes
    * Help: Documentación y ayuda

## instalar

[Rstudio](https://posit.co/download/rstudio-desktop/)

## script

* Cargar script: menu/ file/ open file
* Ejecutar linea de script:
    * Coloca el cursor en la línea: ctr+enter
    * presionar el boton run
* Ejecutar bloque
    * marcar bloque y ctrl+enter / boton run
* Ejecutar todo el script:
    * ctr+shift+enter
    * source("mi_script.R")
* Ejecutar x secciones:
    * definir secciones
    ```r
    # Definir variables ----
    x <- 10
    y <- 20

    # Calcular resultados ----
    suma <- x + y
    promedio <- (x + y) / 2

    # Mostrar resultados ----
    ```
* Click en el triángulo ▸ junto al título de la sección
* O Ctrl + Alt + T para ejecutar la sección

## RMarkdown

R Markdown es una herramienta poderosa que combina análisis de datos, código y documentación en un solo documento.

Sirve para crear documentos reproducibles que integran:

* Código (R)
* Resultados (tablas, gráficos, modelos)
* Texto explicativo (narrativa, conclusiones)

## crear archivo mark down

* En Rstudio clic en: files/new/R mark down

## Abrir un archivo Rmd

* En Rstudio clic en: files/open file


## teclas importantes en los archivo '.Rmd'

* Crear nuevo segmento de código ctr+alt+i
* Generar resultados selecciona opcion knit/knit to html

**Ejemplos de segmento de código:**

<pre>
```{r}

tu código aqui

```
</pre>



o

<pre>
```{r message=FALSE, warning=FALSE}

tu código aqui

```
</pre>


o

<pre>
```{r message=FALSE, warning=FALSE, rows.print = 20}

tu código aqui

```
</pre>

o

<pre>
```{r eval=FALSE}

Este código se mostrará pero no ejecutará
x <- 5
print(x)

```
</pre>

## encabezado del archivo RMarkdown mejorado

```
output: 
  html_document:
    toc:true #tabla de contenido
    toc_depth: 3 
    toc_float: true 
    collapse: true 
    smooth_scroll: true 
    theme: journal
    highlight: kate
    df_print: paged
    code_folding: show
```

Significado:

    * toc:true #tabla de contenido
    * toc_depth: 3 # cuantos niveles
    * toc_float: true # tabla de contenido en todo el doc
    * collapse: true # que se presente el niver principal
    * smooth_scroll: true # en cada sección se muestra tabla de contenido
    * theme: journal # tema del documento
    * highlight: kate # usa el estilo kate para coolorear el código
    * df_print: paged # mustra las tablas de datos grandes con paginación
    * code_folding: show # permite al usuario mostrar/ ocultar bloques de código
## ejemplo

Vea el archivo: './ejemploRMd.Rmd'

Y su resultado: 'ejemploRMd.html'