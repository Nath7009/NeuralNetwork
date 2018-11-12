class Population {
  final int nbSpecies;
  final int popSize;
  Snake[][] snakes;

  Population(int nbSpecies, int popSize) {
    this.nbSpecies = nbSpecies;
    this.popSize = popSize;

    snakes = new Snake[nbSpecies][popSize];

    for (int i=0; i<nbSpecies; i++ ) {
      for (int j=0; j < popSize; j++) {
        snakes[i][j] = new Snake();
      }
    }
  }
}
