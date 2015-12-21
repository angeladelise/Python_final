import processing.serial.*;
Serial port;
    
Player player;
Circle c1;
Circle c2;
Circle c3;
Circle c4;
Circle c5;
Circle c6;
Circle c7;
Circle c8;
Circle c9;
Triangle t1;
Triangle t2;
Triangle t3;
BlueCircle b1;
BlueCircle b2;
BlueCircle b3;
BlueCircle b4;
BlueCircle b5;
roadLines line1;
roadLines line1_2; // all of the lines that are in the first column
roadLines line1_3;
roadLines line1_4;
roadLines line2;
roadLines line2_2; // all of the lines that are in the first column
roadLines line2_3;
roadLines line2_4;
roadLines line3;
roadLines line3_2; // all of the lines that are in the first column
roadLines line3_3;
roadLines line3_4;
roadLines line4;
roadLines line4_2; // all of the lines that are in the first column
roadLines line4_3;
roadLines line4_4;
roadLines line5;
roadLines line5_2; // all of the lines that are in the first column
roadLines line5_3;
roadLines line5_4;

int state;
int lives;
int score;

float xPos = 0;
float yPos = 0;
String xIn;
String yIn;

boolean moveLeft;
boolean moveRight;

PImage title;
PImage lose;
PImage win;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;

AudioPlayer music;

AudioPlayer break1;
AudioPlayer break2;

void setup(){
  size(1000,750);
  port = new Serial(this, "/dev/cu.usbmodem1421", 250000);
  port.bufferUntil('\n');
  

  line1 = new roadLines(width/6, 0, 1.5);
  line1_2 = new roadLines(width/6, 200, 1.5);
  line1_3 = new roadLines(width/6, 400, 1.5);
  line1_4 = new roadLines(width/6, 600, 1.5);

  line2 = new roadLines(width/3, 0, 1.5);
  line2_2 = new roadLines(width/3, 200, 1.5);
  line2_3 = new roadLines(width/3, 400, 1.5);
  line2_4 = new roadLines(width/3, 600, 1.5);
  
  line3 = new roadLines(3*width/6, 0, 1.5);
  line3_2 = new roadLines(width/2, 200, 1.5);
  line3_3 = new roadLines(width/2, 400, 1.5);
  line3_4 = new roadLines(width/2, 600, 1.5);
  
  line4 = new roadLines(4*width/6, 0, 1.5);
  line4_2 = new roadLines(2*width/3, 200, 1.5);
  line4_3 = new roadLines(2*width/3, 400, 1.5);
  line4_4 = new roadLines(2*width/3, 600, 1.5);
  
  line5 = new roadLines(5*width/6, 0, 1.5);
  line5_2 = new roadLines(5*width/6, 200, 1.5);
  line5_3 = new roadLines(5*width/6, 400, 1.5);
  line5_4 = new roadLines(5*width/6, 600, 1.5);
  
  player = new Player(400,400);
  c1 = new Circle (120, -30, 40, 1.5);
  c2 = new Circle (560, -170, 50, 1.5);
  c3 = new Circle (850, -150, 20, 1.5);
  c4 = new Circle (230, -280, 30, 1.5);
  c5 = new Circle (460, -300, 40, 1.5);
  c6 = new Circle (600, -30, 60, 1.5);
  c7 = new Circle (680, -450, 30, 1.5);
  c8 = new Circle (510, -100, 40, 1.5);
  c9 = new Circle (300, -40, 60, 1.5);
  t1 = new Triangle (300,-90, 1.5);
  t2 = new Triangle (100,-480, 1.5);
  t3 = new Triangle (450,-750, 1.5);
  b1 = new BlueCircle (580, -250, 30, 1.5);
  b2 = new BlueCircle (110, -80, 30, 1.5);
  b3 = new BlueCircle (200, -60, 20, 1.5);
  b4 = new BlueCircle (340, -150, 35, 1.5);
  b5 = new BlueCircle (630, -280, 25, 1.5);

  state = 1;
  //lives = 3;
  //score = 0;
  
  title = loadImage("icyroads.png");
  lose = loadImage("sign.png");
  win = loadImage("win.png");
  
  minim = new Minim (this);
  music = minim.loadFile("Transportation.mp3");
  //music.loop();
  
  minim = new Minim (this);
  break1 = minim.loadFile("Break1.wav");
  //powerup.loop();
  
  minim = new Minim (this);
  break2 = minim.loadFile("Break2.wav");
}

void draw(){
  
  //intro screen
  if (state == 1){
    background(100); //gray background
    fill(255);
    textSize(30);
    text("Welcome!", width/3+30, height/3);
    textSize(20);
    fill(255,0,0);
    text("Use the Left and Right arrows to avoid the red circles", 100, height/2);
    fill(90,220,255);
    text("Catch the blue circles to increase your score!", 120, height/2+30);
    fill(0,255,0);
    text("Catch the green triangles to get more lives", 120, height/2+55);
    
    fill(255,130,50);
    textSize(20);
    text("Click to play!", width/3+40, height/2+100);
    
    image(title, 0,0);
    
    lives = 3;
    score = 0;
    music.play();
    
    //every 3minutes replay the song
    if(millis() % 190000 == 0){
      music.rewind();
    music.play();
    }
    
    //randomize y position every time you replay
    c1.yPos = random(0, -400);
    c2.yPos = random(-150, -400);
    c3.yPos = random(-200, -400);
    c4.yPos = random(-450, -600);
    c5.yPos = random(-200, -600);

    t1.yPos = random(-500, -1000);

    b1.yPos = random(-100, -400);
    b2.yPos = random(-300, -500);
    
    c1.speed = 2.2;
    c2.speed = 2.2;
    c3.speed = 2.2;
    c4.speed = 2.2;
    c5.speed = 2.2;
    
    b1.speed = 2.2;
    b2.speed = 2.2;

    t1.speed = 2.2;
    
    line1.speed = 2.2;
    line1_2.speed = 2.2;
    line1_3.speed = 2.2;
    line1_4.speed = 2.2;
    line2.speed = 2.2;
    line2_2.speed = 2.2;
    line2_3.speed = 2.2;
    line2_4.speed = 2.2;
    line3.speed = 2.2;
    line3_2.speed = 2.2;
    line3_3.speed = 2.2;
    line3_4.speed = 2.2;
    line4.speed = 2.2;
    line4_2.speed = 2.2;
    line4_3.speed = 2.2;
    line4_4.speed = 2.2;
    line5.speed = 2.2;
    line5_2.speed = 2.2;
    line5_3.speed = 2.2;
    line5_4.speed = 2.2;
      
    if (mousePressed){
     state = 2; //go to next state 
    }
    
  }
  
  
  if (state == 2){
  fill(0, 10);
  background(100); //gray background
  
     //every 3minutes replay the song
    if(millis() % 190000 == 0){
    music.rewind();
    music.play();
    }
  //music.play();

  
  //replay song
  
 // println(music.isPlaying());
  
  //if(music.isPlaying() == false){
  //  //music.pause();
  //  music.rewind();
  //  music.play();
  //}
  
  line1.draw();
  line1_2.draw();
  line1_3.draw();
  line1_4.draw();
  line2.draw();
  line2_2.draw();
  line2_3.draw();
  line2_4.draw();
  line3.draw();
  line3_2.draw();
  line3_3.draw();
  line3_4.draw();
  line4.draw();
  line4_2.draw();
  line4_3.draw();
  line4_4.draw();
  line5.draw();
  line5_2.draw();
  line5_3.draw();
  line5_4.draw();
  
  c1.draw();
  c2.draw();
  c3.draw();
  c4.draw();
  c5.draw();
//  c6.draw();
 // c7.draw();
 // c8.draw();
 // c9.draw();
  
  t1.draw();
//  t2.draw();
//  t3.draw();
  
  b1.draw();
  b2.draw();
//  b3.draw();


  
  player.draw();

  
  fill(255);
  text("Lives: " + lives, width -100, 30);
  text("Score: " + score, width -250, 30);
  
   if(port.available()>0){
    xIn = port.readStringUntil('\n');
    yIn = port.readStringUntil('\n');
   
    if(xIn != null && yIn != null){
      xPos = float(xIn);
      yPos = float(yIn);
      println(xIn);
      println(yIn);  
      
      if(xPos> 0){
        player.right();
        moveRight = true;
        moveLeft = false;
      }
      
      if(xPos < 0){
        player.left();
        moveLeft = true;
        moveRight = false;
       }
     }

    } // end of port loop
    
    
     if(moveLeft == true){
      player.moveLeft(); 
    }
     if(moveRight == true){
      player.moveRight(); 
    }


  //if (keyPressed){
  //  if (key == CODED){
  //   if(keyCode == LEFT){
  //    player.left(); 
  //   }
     
  //   if (keyCode == RIGHT){
  //    player.right(); 
  //   }
  //  }
  //}
  
  //to test collisions
  
  //line(c1.xPos, c1.yPos, player.xPos, player.yPos+40);
  //ellipse(player.xPos+10, player.yPos+40, c1.size/2+70, c1.size/2+70);
  
   if(dist(c1.xPos, c1.yPos, player.xPos+10, player.yPos+40) < c1.size/2+70 )
   {
  lives = lives -1;
  c1.yPos = random(-100,-50);
  c1.xPos = random(0, width);
    }
    
  
   if(dist(c2.xPos, c2.yPos, player.xPos+10, player.yPos+40) < c2.size/2+70 )
   {
  lives = lives -1;
    c2.yPos = random(-100,-50);
     c2.xPos = random(0, width);
    }
    
  
   if(dist(c3.xPos, c3.yPos, player.xPos+10, player.yPos+40) < c3.size/2+70 )
   {
  lives = lives -1;
    c3.yPos = random(-100,-50);
     c3.xPos = random(0, width);
    }
    
  
   if(dist(c4.xPos, c4.yPos, player.xPos+10, player.yPos+40) < c4.size/2+70 )
   {
  lives = lives -1;
    c4.yPos = random(-100,-50);
     c4.xPos = random(0, width);
    }
    
    
  
   if(dist(c5.xPos, c5.yPos, player.xPos+10, player.yPos+40) < c5.size/2+70 )
   {
  lives = lives -1;
    c5.yPos = random(-100,-50);
     c5.xPos = random(0, width);
    }
    

   if(dist(c6.xPos, c6.yPos, player.xPos+10, player.yPos+40) < c6.size/2+70 )
   {
  lives = lives -1;
    c6.yPos = random(-100,-50);
     c6.xPos = random(0, width);
    }
  
   if(dist(c7.xPos, c7.yPos, player.xPos+10, player.yPos+40) < c7.size/2 +70)
   {
  lives = lives -1;
    c7.yPos = random(-100,-50);
     c7.xPos = random(0, width);
    }

  
   if(dist(c8.xPos, c8.yPos, player.xPos+10, player.yPos+40) < c8.size/2 +70)
   {
  lives = lives -1;
    c8.yPos = random(-100,-50);
     c8.xPos = random(0, width);
    }
    
  
   if(dist(c9.xPos, c9.yPos, player.xPos+10, player.yPos+40) < c9.size/2 +70)
   {
  lives = lives -1;
    c9.yPos = random(-100,-50);
     c9.xPos = random(0, width);
    }
    
    
    if(dist(t1.xPos, t1.yPos, player.xPos+10, player.yPos+40) < 25 + 70 )
   {
  lives = lives +1;
  t1.yPos = random(-100,-50);
   t1.xPos = random(0, width);
    }
    
  
   if(dist(t2.xPos, t2.yPos, player.xPos+10, player.yPos+40) < 25+ 70 )
   {
  lives = lives +1;
    t2.yPos = random(-100,-50);
     t2.xPos = random(0, width);
    }
    
  
   if(dist(t3.xPos, t3.yPos, player.xPos+10, player.yPos+40) < 25 + 70 )
   {
  lives = lives +1;
    t3.yPos = random(-100,-50);
     t3.xPos = random(0, width);
    }
    
    
    if(dist(b1.xPos, b1.yPos, player.xPos+10, player.yPos+40) < b1.size/2+70 )
   {
    score = score +10;
  b1.yPos = random(-100,-50);
   b1.xPos = random(0, width);
    }
    
  
   if(dist(b2.xPos, b2.yPos, player.xPos+10, player.yPos+40) < b2.size/2+70 )
   {
  score = score +10;
    b2.yPos = random(-100,-50);
     b2.xPos = random(0, width);
    }
    
  
   if(dist(b3.xPos, b3.yPos, player.xPos+10, player.yPos+40) < b3.size/2+70 )
   {
    score = score +10;
    b3.yPos = random(-100,-50);
     b3.xPos = random(0, width);
    }
    
  
   if(dist(b4.xPos, b4.yPos, player.xPos+10, player.yPos+40) < b4.size/2+70 )
   {
    score = score +10;
    b4.yPos = random(-100,-50);
     b4.xPos = random(0, width);
    }
    
    
  
   if(dist(b5.xPos, b5.yPos, player.xPos+10, player.yPos+40) < b5.size/2+70 )
   {
  score = score +10;
    b5.yPos = random(-100,-50);
     b5.xPos = random(0, width);
    }
    
    
    
    if (lives ==0){
     state = 3; 
    }
    
    if (score == 500){
     state = 4; 
    }
    
}


  if (state ==3){
   background(255,0,0);
   fill(255);
   textSize(50);
    text("You Lose!", width/2-100, height/2);
   textSize(20);
    text("Click to replay!", width/2-30, height*2/3);
    
    image(lose, 0, 0);
    
    if (mousePressed){
      state =1;
     // setup();
    }
    
    //every 3minutes replay the song
    if(millis() % 190000 == 0){
       music.rewind();
      music.play();
    }
  }
  
    if (state ==4){
   background(255,0,0);
   fill(255);
   textSize(50);
    text("You Lose!", width/2-100, height/2);
    
    image(win, 0, 0);
    
    if (mousePressed){
      state =1;
    }
    
    //every 3minutes replay the song
    if(millis() % 190000 == 0){
       music.rewind();
      music.play();
    }
    
  }

println(state);
}