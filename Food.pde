public class Food{
    PVector pos;
    
    Food(){
       int x = 400 + floor(random(39))*SIZE;
       int y = floor(random(39))*SIZE;
       pos = new PVector(x,y);
    }
    
    Food(float x, float y){
        this.pos = new PVector(x,y);
    }
    
    void show(){
       fill(255,0,0);
       noStroke();
       rect(pos.x,pos.y,SIZE,SIZE);        
    }
    
    Food clone(){
       return new Food(this.pos.x,this.pos.y); 
    }
}
