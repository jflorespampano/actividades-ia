# DEAL

deal (Danish Electronic Aid for Learning) es un paquete de R para el aprendizaje de redes bayesianas a partir de datos. Es especialmente útil para:

* Aprendizaje de estructura de redes
* Estimación de parámetros
* Manejo de datos missing
* Variables discretas y continuas

```r
# Instalar desde CRAN
install.packages("deal")

# Cargar el paquete
library(deal)

# Crear una red vacía
net <- network(iris)

# Ver la red
print(net)
plot(net)  # Visualización básica

# Definir variables (discretas/continuas)
# Para iris, Species es discreta, las demás continuas
net <- network(iris, discrete = c(5))  # Columna 5 es discreta

# Ver especificación de variables
net$nodes

# Ajustar parámetros (probabilidades condicionales)
net <- getnetwork(learn(net, iris))

# Ver parámetros estimados
net$nodes$Sepal.Length$condmean

# Aprender estructura de la red
learned_net <- learn(net, iris)

# Obtener la mejor red
best_net <- getnetwork(learned_net)

# Ver arcos aprendidos
best_net$arcs


```

## ejemplo completo con iris

```r
library(deal)

# Preparar datos
data(iris)
iris_df <- iris

# Especificar que Species es discreta
iris_df$Species <- as.factor(iris_df$Species)

# Crear red inicial
net <- network(iris_df, discrete = which(sapply(iris_df, is.factor)))

# is.factor Verifica qué columnas son factores por  ejemplo
# is.factor(iris_df$Species)  # TRUE
# is.factor(iris_df$Sepal.Length)  # FALSE

# sapply(iris_df, is.factor) Aplica is.factor a cada columna del data frame
# sapply(iris_df, is.factor)
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species 
#        FALSE        FALSE        FALSE        FALSE         TRUE 

# which(sapply(iris_df, is.factor)) Encuentra los ÍNDICES de las columnas que son factores
# Species 
#       5 

# discrete = ...
# discrete: Parámetro que indica qué variables son discretas/categóricas

# Recibe: Un vector con los índices de las columnas discretas

# Aprender parámetros
net_param <- getnetwork(learn(net, iris_df))

# Aprender estructura (usando score de BDe)
learned <- learn(net, iris_df, method = "bayes")

# Obtener mejor red
best_net <- getnetwork(learned)

# Ver resultados
print(best_net$arcs)  # Arcos aprendidos
plot(best_net)        # Visualizar estructura
```
