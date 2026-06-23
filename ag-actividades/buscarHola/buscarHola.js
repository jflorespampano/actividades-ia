// Definimos los parámetros del algoritmo genético
const TARGET = "Hola";
const POPULATION_SIZE = 200;
const MUTATION_RATE = 0.01;

// Genera una cadena aleatoria de la misma longitud que la meta
function randomString(length) {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
    return Array.from({ length }, () => chars.charAt(Math.floor(Math.random() * chars.length))).join('');
}

// Calcula la "aptitud" de un individuo, más cercano al objetivo = mayor aptitud
function fitness(individual) {
    return Array.from(individual).reduce((score, char, index) => {
        return char === TARGET[index] ? score + 1 : score;
    }, 0);
}

// Crea una nueva generación mediante selección, cruce y mutación
function createNextGeneration(population) {
    const matingPool = [];
    population.forEach(individual => {
        const fitScore = fitness(individual);
        for (let i = 0; i < fitScore; i++) matingPool.push(individual);
    });

    const nextGeneration = [];
    for (let i = 0; i < population.length; i++) {
        const parent1 = matingPool[Math.floor(Math.random() * matingPool.length)];
        const parent2 = matingPool[Math.floor(Math.random() * matingPool.length)];
        let child = crossover(parent1, parent2);
        child = mutate(child);
        nextGeneration.push(child);
    }
    return nextGeneration;
}

// Realiza el cruce entre dos padres
function crossover(parent1, parent2) {
    const midpoint = Math.floor(Math.random() * parent1.length);
    return parent1.slice(0, midpoint) + parent2.slice(midpoint);
}

// Aplica mutación a un individuo
function mutate(individual) {
    return Array.from(individual).map(char => {
        return Math.random() < MUTATION_RATE
            ? randomString(1)
            : char;
    }).join('');
}

// Algoritmo principal
function geneticAlgorithm() {
    let population = Array.from({ length: POPULATION_SIZE }, () => randomString(TARGET.length));
    let generation = 0;

    while (true) {
        generation++;
        population.sort((a, b) => fitness(b) - fitness(a));
        console.log(`Generación ${generation}: Mejor individuo: ${population[0]}`);
        if (fitness(population[0]) === TARGET.length) break;
        population = createNextGeneration(population);
    }

    console.log(`¡Encontrado! Generación ${generation}, Solución: ${population[0]}`);
}

// Ejecutamos el algoritmo
geneticAlgorithm();
