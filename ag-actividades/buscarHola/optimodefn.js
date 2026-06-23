// Definir la función objetivo
function fitnessFunction(x) {
    return Math.sin(x) * Math.cos(x); // Calcula el valor de fitness
}

// Generar una población inicial aleatoria
function generatePopulation(size, lowerBound, upperBound) {
    let population = [];
    for (let i = 0; i < size; i++) {
        population.push(Math.random() * (upperBound - lowerBound) + lowerBound);
    }
    return population;
}

// Selección basada en el fitness
function selectParents(population, fitnessFunction) {
    return population.sort((a, b) => fitnessFunction(b) - fitnessFunction(a)).slice(0, 2);
}

// Cruza para generar descendencia
function crossover(parent1, parent2) {
    return (parent1 + parent2) / 2; // Promedio simple para descendencia
}

// Mutación para explorar
function mutate(individual, mutationRate, lowerBound, upperBound) {
    if (Math.random() < mutationRate) {
        return Math.random() * (upperBound - lowerBound) + lowerBound;
    }
    return individual;
}

// Algoritmo genético
function geneticAlgorithm(fitnessFunction, lowerBound, upperBound, populationSize, generations, mutationRate) {
    let population = generatePopulation(populationSize, lowerBound, upperBound);

    for (let generation = 0; generation < generations; generation++) {
        // Evaluar la población
        population = population.sort((a, b) => fitnessFunction(b) - fitnessFunction(a));
        
        // Seleccionar a los mejores padres
        let [parent1, parent2] = selectParents(population, fitnessFunction);
        
        // Generar nueva población
        let newPopulation = [];
        for (let i = 0; i < populationSize; i++) {
            let child = crossover(parent1, parent2);
            child = mutate(child, mutationRate, lowerBound, upperBound);
            newPopulation.push(child);
        }
        population = newPopulation;
    }

    // Devolver el mejor resultado
    return population.sort((a, b) => fitnessFunction(b) - fitnessFunction(a))[0];
}

// Ejecutar el algoritmo genético
const bestSolution = geneticAlgorithm(fitnessFunction, -10, 10, 50, 100, 0.1);
console.log("La mejor solución encontrada es:", bestSolution);
