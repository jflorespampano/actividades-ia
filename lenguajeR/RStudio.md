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

R Markdown es una herramienta poderosa que combina análisis de datos, código y documentación en un solo documento. R Markdown provee un marco de escritura para ciencia de datos, que combina tu código, sus resultados y tus comentarios en prosa. Los documentos de R Markdown son completamente reproducibles y soportan formatos de salida tales como PDFs, archivos de Word.

Los archivos R Markdown están diseñados para ser usados de tres maneras:

* Para comunicarse con quienes toman decisiones, que desean enfocarse en las conclusiones, no en el código que subyace al análisis.

* Para colaborar con otras personas que hacen ciencia de datosdatos (¡incluyendo a tu yo futuro!), quienes están interesados tanto en tus conclusiones como en el modo en el que llegaste a ellas (es decir, el código).

* Como un ambiente en el cual hacer ciencia de datos, como si fuera un notebook de laboratorio moderno donde puedes capturar no solo que hiciste, sino también lo que estabas pensando cuando lo hacías.

**Rmarkdown**

Sirve para crear documentos reproducibles que integran:

* Código (R)
* Resultados (tablas, gráficos, modelos)
* Texto explicativo (narrativa, conclusiones)

Contiene tres tipos importantes de contenido:

Un encabezado YAML (opcional) rodeado de ---
Bloques de código de R rodeados de ```.
Texto mezclado con formateos de texto simple como # Encabezado e _itálicas_.

Cuando haces knit el documento (knit significa tejer en inglés), R Markdown envía el .Rmd a knitr (http://yihui.name/knitr/) que ejecuta todos los bloques de código y crea un nuevo documento markdown (.md) que incluye el código y su output. Teniendo el archivo md, puedes crear un muy amplio rango de formatos de salida usando pandoc (`pandoc documento.md -o documento.pdf`).



![Texto alternativo](./RMarkdownFlow.png)

## Crear archivo mark down

* En Rstudio clic en: files/new/R mark down

## Abrir un archivo Rmd

* En Rstudio clic en: files/open file


## teclas importantes en los archivo '.Rmd'

* Crear nuevo segmento de código ctr+alt+i o el ícono insert en la barra de edición
* Generar resultados selecciona opcion knit/knit to html

**Ejemplos de segmento de código:**

<pre style="background-color: #c0c0c0">
```{r}

tu código aqui

```
</pre>



o

<pre style="background-color: #c0c0c0">
```{r message=FALSE, warning=FALSE}

tu código aqui

```
</pre>


o

<pre style="background-color: #c0c0c0">
```{r message=FALSE, warning=FALSE, rows.print = 20}

tu código aqui

```
</pre>

o

<pre style="background-color: #c0c0c0">
```{r eval=FALSE}

Este código se mostrará pero no ejecutará
x <- 5
print(x)

```
</pre>

Puedes poner opcionalmente nobre a los bloque de código y despues navegar más fácilmente a bloques específicos usando el navegador de código desplegable abajo a la izquierda en el editor de script:

<pre style="background-color: #c0c0c0">
```{r nombre}

x <- 5
print(x)

```
</pre>

### Opciones de los boque de código

El conjunto más importante de opciones controla si tu bloque de código es ejecutado y qué resultados estarán insertos en el reporte final:

* eval = FALSE evita que el código sea evaluado. (Y, obviamente, si el código no es ejecutado no se generaran resultados). Esto es útil para mostrar códigos de ejemplo, o para deshabilitar un gran bloque de código sin comentar cada línea.

* include = FALSE ejecuta el código, pero no muestra el código o los resultados en el documento final. Usa esto para código de configuración que no quieres que abarrote tu reporte.

* echo = FALSE evita que se vea el código, pero sí muestra los resultados en el archivo final. Utiliza esto cuando quieres escribir reportes enfocados a personas que no quieren ver el código subyacente de R.

* message = FALSE o warning = FALSE evita que aparezcan mensajes o advertencias en el archivo final.

* results = 'hide' oculta el output impreso; fig.show = 'hide' oculta gráficos.

* error = TRUE causa que el render continúe incluso si el código devuelve un error. Esto es algo que raramente quieres incluir en la versión final de tu reporte, pero puede ser muy útil si necesitas depurar exactamente qué ocurre dentro de tu .Rmd. Es también útil si estás enseñando R y quieres incluir deliberadamente un error. Por defecto, error = FALSE provoca que el knitting falle si hay incluso un error en el documento.

Las tablas tiene un formato de salida, por ejemplo en código siguiente imprime una tabla:

<pre style="background-color: #c0c0c0">
```{r nombre}

mtcars[1:5, ]

```
</pre>

Puede formatear la salida de esta forma:

<pre style="background-color: #c0c0c0">
```{r nombre}

knitr::kable(
  mtcars[1:5, ],
  caption = "Un kable de knitr."
)

```
</pre>

## encabezado del archivo RMarkdown mejorado

```yaml
output: 
  html_document:
    toc: true #tabla de contenido
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

## Ejemplo

* Vea el archivo: './ejemploRMd.Rmd'
* Y su resultado: 'ejemploRMd.html'

## algunos tips

Crear subindices y superinddices
- con latex $a \cdot b +x_2 \cdot y^3$
- con html:
- x<sup>3</sup>
- H<sub>2</sub>SO<sub>4</sub> - Ácido sulfúrico
- C<sub>6</sub>H<sub>12</sub>O<sub>6</sub> - Glucosa
- NH<sub>3</sub> - Amoníaco
- CaCO<sub>3</sub> - Carbonato de calcio

## ligas

* [ref 1](https://es.r4ds.hadley.nz/27-rmarkdown.html)