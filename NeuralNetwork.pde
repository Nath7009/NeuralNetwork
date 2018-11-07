class NeuralNetwork { //<>//

  Matrix[] weights;
  Matrix[] biases;

  int size;
  int inputs;
  int outputs;

  NeuralNetwork(int[] layers) {
    this.size = layers.length;
    for (int i=0; i<size; i++) {
      if (layers[i] <= 0) {
        println("Impossible de créer le réseau de neurones avec des niveaux de taille négative ou nulle");
        return;
      }
    }
    if (size<2) {
      println("Le réseau de neurones doit avoir au minimum deux niveaux");
      return;
    } else {
      this.weights = new Matrix[size-1];
      this.biases = new Matrix[size-1];
      this.inputs = layers[0];
      this.outputs = layers[size-1];

      //INITIALISATION
      for (int i=0; i<size-1; i++) {
        //INITIALISATION DES POIDS
        weights[i] = new Matrix(layers[i+1], layers[i]);
        weights[i].randomize();

        //INITIALISATION DES BIAIS
        biases[i] = new Matrix(layers[i+1], 1);
        biases[i].randomize();

       /*println("Poids du niveau " + i + " au niveau " + (i+1));
        weights[i].printMat();
        biases[i].printMat();*/
      }

      println("Réseau de neurones comprenant " + size + " niveaux avec " + inputs + " neurones d'entrée et " + outputs + " neurones de sortie réussie");
    }
  }


  double[] predict(double[] inputArr) {
    if (this.inputs !=  inputArr.length) {
      return null;
    }
    
    Matrix currLayer = new Matrix(inputArr);
    Matrix nextLayer = new Matrix(1,1);
    
    for(int i=0;i<size-1;i++){
      nextLayer = multMat(weights[i],currLayer);
      nextLayer.addMat(biases[i]);
      nextLayer.mapMat();
      currLayer = nextLayer;
    }
    
    return nextLayer.toArr();
    /*Matrix inputs = new Matrix(inputArr);
    Matrix[] layers = new Matrix[this.size];
    layers[0] = inputs;
    
    for(int i=0;i<size-1;i++){ //Pour chaque niveau
      //layers[i+1] = weights[i] * layers[i]
      layers[i+1] = multMat(weights[i], layers[i]);
      //layers[i] += biais
      layers[i+1].addMat(biases[i]);
      
      layers[i+1].mapMat(); //On applique la fonction
    }
    return layers[this.size-1].toArr();*/
   
  }
  
  int[] getLayers(){
     int[] layers = new int[size];
     for(int i=0;i<layers.length;i++){
        layers[i] = weights[i].n;
     }
     return layers;
  }
  
  NeuralNetwork crossover(NeuralNetwork partner){
    if(!this.getLayers().equals(partner.getLayers())){
      println("Impossible de réaliser le crossover car les réseaux de neurones sont différents");
      return null;
    }
    NeuralNetwork child = new NeuralNetwork(this.getLayers());
    
    for(int i=0;i<this.size;i++){
       child.weights[i] = this.weights[i].crossover(partner.weights[i]);
       child.biases[i] = this.biases[i].crossover(partner.biases[i]);
    }
    return child;
  }
  
  void mutate(double mr){
    for(int i=0;i<this.size;i++){
       weights[i].mutate(mr);
       weights[i].mutate(mr);
    }
  }
}

public double activation(double x) {
  //return 1/(1+Math.exp(-x));
  return x>0 ? x : 0;
}

public double dactivation(double x) {
  return x*(1-x);
}
