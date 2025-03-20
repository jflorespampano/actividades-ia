# instalar la caja de herramientas ANN en scilab

1. En el menu de scilab ir a Aplications/Module manager - Atoms
2. Seleccionar carpeta "All modules"/"ANN tool box"
3. listo, una vez instalada, Scilab debería cargar la toolbox automáticamente. Si no es así, puedes hacerlo manualmente desde la línea de comandos.

## Desde la Línea de Comandos

Instalar la Toolbox: Puedes instalar una toolbox utilizando el comando atomsInstall. 

atomsInstall("nombre_de_la_toolbox")

Cargar la Toolbox: Después de instalar la toolbox, necesitas cargarla para poder usarla:

atomsLoad("nombre_de_la_toolbox")

## Por ejemplo, para instalar la toolbox ANN, usarías:

// Instalar la toolbox ANN
atomsInstall("ann")

// Cargar la toolbox ANN
atomsLoad("ann")