 //<>//
public class Snake {

  double[] vision;
  double[] decision;
  PVector head;
  ArrayList<PVector> body;
  PVector speed;
  boolean isDead;
  int size = 1;
  int lifeLeft = 200;
  int lifeTime = 0;
  int score = 0;
  double fitness;

  Food food;
  NeuralNetwork brain;

  Snake() {
    this.food = new Food();
    this.brain = new NeuralNetwork(new int[] {24, 18, 4});
    this.head = new PVector(800, height/2);
    this.body = new ArrayList<PVector>();
    this.isDead = false;
    this.speed = new PVector(0, -SIZE);

    body.add(new PVector(800, (height/2)+SIZE));  
    body.add(new PVector(800, (height/2)+(2*SIZE)));
    size+=2;
  }

  void move() { //<>//
    if (!isDead) {

      for (int i=body.size()-1; i>0; i--) {
        body.set(i, body.get(i-1));
      }

      body.set(0, head.copy());
      head.add(speed);


      if (collidesFood(head.x, head.y)) {
        eat();
      }

      if (collidesBody(head.x, head.y) || collidesWall(head.x, head.y)) {
        isDead = true;
      }
      lifeLeft--;
      lifeTime++;
    }
  }

  void eat() {
    score++;
    int len = this.body.size()-1;
    body.add(new PVector(body.get(len).x, body.get(len).y));

    if (lifeLeft < 500) {
      lifeLeft+=100;
    } else {
      lifeLeft+=50;
    }

    food = new Food();
    while (collidesBody(food.pos.x, food.pos.y)) {
      food = new Food();
    }
  }

  void show() {
    food.show();

    stroke(255);
    fill(200);
    rect(head.x, head.y, SIZE, SIZE);
    fill(150);
    for (PVector pos : body) {
      rect(pos.x, pos.y, SIZE, SIZE);
    }
  }

  double[] lookInDir(PVector dir) {
    double[] res = new double[3];
    PVector pos = head.copy();
    boolean foundFood = false;
    boolean foundBody = false;
    float distance = 1;
    pos.add(dir);

    while (!collidesWall(pos.x, pos.y)) {
      if (!foundFood && collidesFood(pos.x, pos.y)) {
        foundFood = true;
        res[0] = 1 / distance;
      }
      if (!foundBody && collidesBody(pos.x, pos.y)) {
        foundBody = true;
        res[1] = 1 / distance;
      }
      distance++;
      pos.add(dir);
    }

    res[2] = 1 / distance;

    return res;
  }  

  void look() { //regarde dans les 8 directions pour chercher des obstacles, nourriture ou lui même
    vision = new double[24];
    double[] temp = lookInDir(new PVector(SIZE, 0));
    vision[0] = temp[0];
    vision[1] = temp[1];
    vision[2] = temp[2];
    temp = lookInDir(new PVector(SIZE, -SIZE));
    vision[3] = temp[0];
    vision[4] = temp[1];
    vision[5] = temp[2];
    temp = lookInDir(new PVector(0, -SIZE));
    vision[6] = temp[0];
    vision[7] = temp[1];
    vision[8] = temp[2];
    temp = lookInDir(new PVector(-SIZE, -SIZE));
    vision[9] = temp[0];
    vision[10] = temp[1];
    vision[11] = temp[2];
    temp = lookInDir(new PVector(-SIZE, 0));
    vision[12] = temp[0];
    vision[13] = temp[1];
    vision[14] = temp[2];
    temp = lookInDir(new PVector(-SIZE, SIZE));
    vision[15] = temp[0];
    vision[16] = temp[1];
    vision[17] = temp[2];
    temp = lookInDir(new PVector(0, SIZE));
    vision[18] = temp[0];
    vision[19] = temp[1];
    vision[20] = temp[2];
    temp = lookInDir(new PVector(SIZE, SIZE));
    vision[21] = temp[0];
    vision[22] = temp[1];
    vision[23] = temp[2];
  }

  void think() { //Utilise la vision pour produire un input au réseau de neurones et l'utiliser pour se déplacer
    double[] decision = brain.predict(vision);
    int choosenDir = 0;
    double maxChoice = decision[0];
    for (int i=1; i<decision.length; i++) {
      if (decision[i] >= maxChoice) {
        choosenDir = i;
        maxChoice = decision[i];
      }
    }

    switch(choosenDir) {
    case 0 : 
      goUp(); 
      break;
    case 1 : 
      goDown(); 
      break;
    case 2 : 
      goLeft(); 
      break;
    case 3 : 
      goRight(); 
      break;
    }
  }

  void mutate() { //Mute le cerveau du snake
    brain.mutate(MR);
  }

  void calcFitness() {
    if (score < 10) {
      fitness = (lifeTime * lifeTime) * pow(2, score);
    } else {
      fitness = lifeTime * lifeTime;
      fitness *= pow(2, 10);
      fitness *= (score-9);
    }
  }

  boolean collidesWall(float x, float y) {
    return x < 400+SIZE || x > width-SIZE || y < SIZE || y > height-SIZE;
  }

  boolean collidesFood(float x, float y) {
    return x == food.pos.x && y == food.pos.y;
  }

  boolean collidesBody(float x, float y) {
    for (int i=0; i<body.size(); i++) {
      if (x == body.get(i).x && y == body.get(i).y) {
        return true;
      }
    }
    return false;
  }

  void goUp() {
    if (speed.y != SIZE) {
      speed.x = 0;
      speed.y = -SIZE;
    }
  }

  void goDown() {
    if (speed.y != -SIZE) {
      speed.x = 0;
      speed.y = SIZE;
    }
  }

  void goLeft() {
    if (speed.x != SIZE) {
      speed.x = -SIZE;
      speed.y = 0;
    }
  }

  void goRight() {
    if (speed.x != -SIZE) {
      speed.x = SIZE;
      speed.y = 0;
    }
  }
}
