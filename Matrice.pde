public class Matrix { //<>//
  public int m, n;
  public double[][] mat;

  Matrix(int m, int n) {
    this.m=m;
    this.n=n;
    mat = new double[m][n];
  }

  Matrix(double[] arr) { //Construit une matrice de arr.length lignes et de une colonne
    this.m=arr.length;
    this.n=1;
    mat = new double[m][n];

    for (int i=0; i<this.m; i++) {
      this.mat[i][0]=arr[i];
    }
  }

  void randomize() { //Met tous les élements de la matrice entre -1 et 1
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        mat[i][j] = random(-2, 2);
      }
    }
  }

  void addMat(Matrix m1) {
    if (this.n != m1.n || this.m != m1.m) {
      println("Impossible de faire l'addition, les tailles des matrices ne correspondent pas");
    } else {
      for (int i=0; i<m; i++) { //Pour chaque ligne
        for (int j=0; j<n; j++) { //Afficher les colonnes
          this.mat[i][j]+=m1.mat[i][j];
        }
      }
    }
  }

  void addSc(double a) {
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        this.mat[i][j]+=a;
      }
    }
  }

  void subMat(Matrix m1) { //Soutrait m1 à la matrice actuelle
    if (this.n != m1.n || this.m != m1.m) {
      println("Impossible de faire la soustraction, les tailles des matrices ne correspondent pas");
    } else {
      for (int i=0; i<m; i++) { //Pour chaque ligne
        for (int j=0; j<n; j++) { //Afficher les colonnes
          this.mat[i][j]-=m1.mat[i][j];
        }
      }
    }
  }

  void subSc(double a) {
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        this.mat[i][j]-=a;
      }
    }
  }

  void multSc(double a) { //Multiplie tous les élements de la matrice par a
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        this.mat[i][j]*=a;
      }
    }
  }

  void multMat(Matrix m1) { //Multiplication élement par élement des deux matrices
    if (this.n != m1.n || this.m != m1.m) {
      println("Impossible de faire la multiplication, les tailles des matrices ne correspondent pas");
    } else {
      for (int i=0; i<m; i++) { //Pour chaque ligne
        for (int j=0; j<n; j++) { //Afficher les colonnes
          this.mat[i][j]*=m1.mat[i][j];
        }
      }
    }
  }

  void mapMat() { //Applique la fonction d'activation à la matrice
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        this.mat[i][j]=activation(this.mat[i][j]);
      }
    }
  }

  void mapdMat() { //Applique la dérivée de la fonction d'activation à la matrice
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        this.mat[i][j]=dactivation(this.mat[i][j]);
      }
    }
  }

  Matrix transpose() {
    Matrix trans = new Matrix(this.n, this.m); //On crée une nouvelle matrice dont les dimensions sont inversées
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        trans.mat[j][i] = this.mat[i][j];
      }
    }
    return trans;
  }

  void copyMat(Matrix m1) { //Copie m1 dans la matrice actuelle
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        this.mat[i][j]=m1.mat[i][j];
      }
    }
  }

  double[] toArr() {
    double[] array = new double[this.m*this.n]; //On crée un tableau qui a autant de cases que la matrice
    int index=0;
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        array[index]=this.mat[i][j];
        index++;
      }
    }
    return array; //array contient la première ligne au début, puis la deuxième et ainsi de suite
  }

  void printMat() {
    println();
    println("Lignes : " + m + " Colonnes : " + n);
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        print(mat[i][j] + " ");
      }
      println();
    }
  }

  Matrix copyMat() {
    Matrix ret = new Matrix(this.m, this.n);
    for (int i=0; i<m; i++) { //Pour chaque ligne
      for (int j=0; j<n; j++) { //Afficher les colonnes
        ret.mat[i][j]=this.mat[i][j];
      }
    }
    return ret;
  }

  void mutate(double mutationRate) {
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        double rand = random(1);
        if (rand<mutationRate) {
          mat[i][j] += randomGaussian()/5;
        }
      }
    }
  }

  Matrix crossover(Matrix partner) {
    Matrix child = this.copyMat();
    int stopm = floor(random(this.m));
    int stopn = floor(random(this.n));

    for (int i=0; i<stopm; i++) {
      for (int j=0; j<stopn; j++) {
        child.mat[i][j] = partner.mat[i][j];
      }
    }
    
    return child;
  }
}



Matrix multMat(Matrix m1, Matrix m2) {
  // Matrix product
  if (m1.n != m2.m) {
    println("Le nombre de colonnes de la première matrice doit être égal au nombre de lignes de la deuxième");
    return new Matrix(0, 0);
  } else {
    Matrix m3 = new Matrix(m1.m, m2.n);
    for (int i=0; i<m3.m; i++) { //Pour chaque ligne
      for (int j=0; j<m3.n; j++) { //Afficher les colonnes
        double somme=0;
        for (int k=0; k<m1.n; k++) {
          somme+=m1.mat[i][k]*m2.mat[k][j];
        }
        m3.mat[i][j]=somme;
      }
    }
    return m3;
  }
}
