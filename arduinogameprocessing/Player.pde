class Player{
  float xPos;
  float yPos; 
  PVector location;
  PVector velocity;
  PVector speed;
  PVector friction;
  
  PImage car; 
  
  float angle;
  
  Player(float xPos, float yPos){
    this.xPos = xPos;
    this.yPos = yPos;
    
    location = new PVector(400,600); // initial position
    //location = new PVector(200,300); // initial position with translate
    velocity = new PVector(10,0); //moves only in x direction
    speed = new PVector(1, 0); //adds speed
    friction = new PVector(0.1,0); //friction to stop player
    
    car = loadImage("Car.png");
  }
  
  void draw(){
    fill(255);
    rectMode(CENTER);
   // rect(xPos, yPos, 50,50); 
   //pushMatrix();
   //translate(location.x-200,location.y-350);
   //line(location.x-52, location.y-35, 200,300);
   //rotate(radians(angle));
    rect(location.x, location.y, 50,50);
    image(car, location.x-52, location.y-35, 120, 150);
  //   ellipse (xPos+10, yPos+30, 50,50);
    xPos = location.x; // to work with the collisions
    yPos = location.y;
    
   // popMatrix();
    
    if(xPos <25){
   xPos = 25; 
    }
    
     if(xPos > (width - 25)){
   xPos = width-25; 
    }
  }
  
  void left() { //move to the left
      velocity.x = -4;
      speed.x = -1.5;
      angle = -5;
     // angle = angle ++;
      location.add(velocity);
      velocity.add(speed);
      if(location.x <40){
       location.x = 40; 
        }
        
     break1.play();
     break1.rewind();
    }
    
    void moveLeft(){
       location.add(velocity);
       friction.x = 0.08;
      if (velocity.x <0) {  //if you are still moving add friction until you stop
        velocity.add(friction);
        if(location.x <40){
       location.x = 40; 
        }
      } 
      else {
        velocity.x =0; //then stop
        if(location.x <40){
       location.x = 40; 
        }
      }
    }

    void right() { //move to the right
      velocity.x = 4; //move in the positive x direction
      speed.x = 1.5;
      angle = 5;
      location.add(velocity);
      velocity.add(speed);  
          
     if(location.x > (width - 60)){
       location.x = width-60; 
      }
     break2.play();
     break2.rewind();
    }
    
    void moveRight(){
      location.add(velocity);
      friction.x = -0.08; 
      
      //for (float i = 0; i < 10; i ++){
      //  angle = angle -.1; //slowly change angle when sliding
        
      //  if (angle < -5){
      //  angle = -5;
      //  }
      //} 
      
      if (velocity.x >0) { //if you are still moving add friction until you stop
        velocity.add(friction);
         if(location.x > (width - 60)){
         location.x = width-60; 
        }
      } else {
        velocity.x =0; //then stop 
        if(location.x > (width - 60)){
       location.x = width-60; 
        }
      }
    }
  
  //void left(){
  // xPos = xPos -10; 
  // if(xPos <25){
  //  xPos = 25; 
  // }
  //}
  
  //void right(){
  //  xPos = xPos +10;
  //  if (xPos > (width-25)){
  //   xPos = width-25; 
  //  }
  //}
  
}