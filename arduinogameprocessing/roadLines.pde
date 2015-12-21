class roadLines{
  float xPos;
  float yPos; 
  float speed;
   
 roadLines(float xPos, float yPos, float speed){
  this.xPos = xPos;
  this.yPos = yPos;
   this.speed = speed;
 }
  
  void draw(){
    fill(255,255,0);
    rect(xPos, yPos, 20, 80);
    
    yPos = yPos + speed;
    
    //to loop back up
    if(yPos > height + 80){
        yPos = -30;
       // xPos = xPos;
            
        if(speed < 5){
        speed = speed +.02; //increases in speed 
        }
        else{
        speed = 5;
        }
    }  
  }
}