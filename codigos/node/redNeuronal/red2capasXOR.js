import {NeuralNetwork} from "./NeuralNetwork.js"
  
  // Ejemplo de uso
  let nn = new NeuralNetwork(2, 4, 1);
  
  // Datos de entrenamiento
//   let trainingData = [
//     { inputs: [0, 0], targets: [0] },
//     { inputs: [0, 1], targets: [1] },
//     { inputs: [1, 0], targets: [1] },
//     { inputs: [1, 1], targets: [1] }
//   ];
  let trainingData = [
    { inputs: [0, 0], targets: [0] },
    { inputs: [0, 1], targets: [1] },
    { inputs: [1, 0], targets: [1] },
    { inputs: [1, 1], targets: [0] }
  ];
  
  // Entrenamiento
  for (let i = 0; i < 10000; i++) {
    let data = trainingData[Math.floor(Math.random() * trainingData.length)];
    // if(i<10){
    //     console.log(`data :`,data)
    // }
    if(i===0){
      nn.train(data.inputs, data.targets,1);

    }else{
      nn.train(data.inputs, data.targets);

    }
  }
  
  function sgn(x) {
    if (x >= 0) return 1;
    if (x < 0) return 0;
    return 0;
  }
  // Prueba
  console.log(sgn(nn.predict([0, 0])-0.5)); // ~0
  console.log(sgn(nn.predict([0, 1])-0.5)); // ~1
  console.log(sgn(nn.predict([1, 0])-0.5)); // ~1
  console.log(sgn(nn.predict([1, 1])-0.5)); // ~0