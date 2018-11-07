

void setup(){
  size(500,500);
  randomSeed(2);
  int[] layers = {2,2,2,2,2,1};
  double[] inputs = {1,1};
  NeuralNetwork nn = new NeuralNetwork(layers);
  println(nn.predict(inputs));
  int time = millis();
  
  for(int i=0;i<500;i++){
     for(int j=0;j<500;j++){
       inputs[0] = i/100.0;
       inputs[1] = j/100.0;
       double res = nn.predict(inputs)[0];
       //println(res);
       res/=3.0;
       res*=255.0;
       stroke(floor((float)res)); //<>//
       rect(i,j,1,1);
     }  
  }
  
  println("Temps pris = " + (millis()-time));
}

void draw(){
  
}
