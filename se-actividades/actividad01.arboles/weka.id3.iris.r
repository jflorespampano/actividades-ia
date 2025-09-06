###################################
# ID3 usando la biblioteca Weka
###################################
# previo a ejecutar este script, 
# si no tiene instalados los paquetes: RWeka, partykit
# debe instalarlos
# install.packages("RWeka")
# install.packages("partykit")
###################################

# inicio del script
# cargar el paquete ("RWeka")
library(RWeka)

# Cargar los datos
data(iris)

# Aplicar el algoritmo ID3
id3_model <- J48(Species ~ ., data = iris, control = Weka_control(U = TRUE))

# Ver el árbol
print(id3_model)
summary(id3_model)

# Visualizar el árbol (cargar el paquete partykit)
library(partykit)
windows()
plot(id3_model)
