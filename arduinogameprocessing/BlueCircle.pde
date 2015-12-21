class BlueCircle{
  float xPos;
  float yPos;
  float size; 
  float speed;
  PImage coin;
   
 BlueCircle(float xPos, float yPos, float size, float speed){
  this.xPos = xPos;
  this.yPos = yPos;
   this.size = size;
   this.speed = speed;
   
   coin = loadImage("coin.png");
 }
  
  void draw(){
   fill(0,0,255);
    ellipse(xPos, yPos, size, size);
    image(coin, xPos - 50, yPos - 30, 70,70);
    
    yPos = yPos + speed;
    
    //to loop back up
    if(yPos > height +size){
        yPos = random(-400,-50);
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