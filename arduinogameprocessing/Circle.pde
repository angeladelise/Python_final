class Circle{
  float xPos; 
  float yPos;
  float size;
  float speed;
   
  PImage ice;
  
 Circle(float xPos, float yPos, float size, float speed){
  this.xPos = xPos;
  this.yPos = yPos;
   this.size = size;
   this.speed = speed;
   
   ice = loadImage("ice.png");

 }
  
  void draw(){
   fill(255,0,0);
    //ellipse(xPos, yPos, size, size);
    image(ice, xPos-50, yPos-30, 110, 70);

    
    yPos = yPos + speed;
    
    //to loop back up
    if(yPos > height +size){
        yPos = random(-300,-50);
        xPos = random(0, width);
        
        if(speed < 5){
        speed = speed +.2; //increases in speed 
        }
        else{
        speed = 5;
        }
    }
  }
  
  
}