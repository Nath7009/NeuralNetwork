final int SIZE = 20; //<>//
final double MR = 0.1; //Fréquence de mutation
Snake s;

void setup() {
  size(1200, 800);
  randomSeed(2);
  frameRate(3);

  s = new Snake();

  background(0);
  printArray(s.lookInDir(new PVector(0, SIZE)));
  s.show(); //<>//



  /*int[] layers = {2,2,2,2,2,1};
   double[] inputs = {1,1};
   NeuralNetwork nn = new NeuralNetwork(layers);
   println(nn.predict(inputs));
   int time = millis();
   
   for(int i=0;i<1200;i++){
   for(int j=0;j<800;j++){
   inputs[0] = i/100.0;
   inputs[1] = j/100.0;
   double res = nn.predict(inputs)[0];
   //println(res);
   res/=3.0;
   res*=255.0;
   stroke(floor((float)res));
   rect(i,j,1,1);
   }  
   }
   
   println("Temps pris = " + (millis()-time));*/
}

void draw() {
  //background(0);
  s.show();
  //s.move();
}

void keyPressed() {
  switch(keyCode) {
  case UP : 
    s.goUp(); 
    break;     
  case DOWN : 
    s.goDown(); 
    break;     
  case LEFT : 
    s.goLeft(); 
    break;     
  case RIGHT : 
    s.goRight(); 
    break;
  }
}
