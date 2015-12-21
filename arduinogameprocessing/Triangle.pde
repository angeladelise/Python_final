 class Triangle{
  float xPos;
  float yPos; 
  float speed;
  
  PImage heart;
   
 Triangle(float xPos, float yPos, float speed){
  this.xPos = xPos;
  this.yPos = yPos;
  this.speed = speed;
  
   heart = loadImage("heart.png");
 }
  
  void draw(){
   fill(0,255,0);
  // triangle(xPos, yPos+50, xPos+25, yPos, xPos+50, yPos+50);
   image(heart, xPos-10, yPos-20, 70, 70);

    
    yPos = yPos + speed;
    
    //to loop back up
    if(yPos > height +50){
        yPos = random(-1000,-500);
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