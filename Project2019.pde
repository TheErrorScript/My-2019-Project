

//developer mode
boolean devMode = true;

float fps = 0;
float mils = 0;
float altMils = 0;
float frameDif = 0;


//the player
Player p1;


//ArrayList to store all the barriers
ArrayList<Barrier> barriers = new ArrayList<Barrier>();

//ArrayList to store all the containers IRONIC?
ArrayList<Container> containers = new ArrayList<Container>();


//how far the is translated
//x direction
float screenTransX = 0;
//y direction
float screenTransY = 0;

//the translated mouse coords
//x coord
float aMouseX = 0;
//y coord
float aMouseY = 0;


//keeps track of if W, A, S, or D are being pressed
boolean[] keys = {false, false, false, false};


void setup() {
   size(1200, 700);
   
   
   if (devMode) {
      p1 = new Player(0, 0);
      barriers.add(new Barrier(250, 250, 80, 80));
      containers.add(new Container(0, 500, 250));
   }
   
   
};


void draw() {
   
   
   //developer mode
   if (devMode) {
      background(0);
      
      //change how far the screen is translated depending on the mouse and the player's coords
      //x direction
      screenTransX = (width/2 - (p1.w/2)) - p1.x - ((-width/2 + mouseX)/2);
      //y direction
      screenTransY = (height/2 - (p1.h/2)) - p1.y - ((-height/2 + mouseY)/2);
      
      //a translated mouse position depending on the screen translation
      //x coord
      aMouseX = -screenTransX + mouseX;
      //y coord
      aMouseY = -screenTransY + mouseY;
      
      
      pushMatrix();
      translate(screenTransX, screenTransY);
      
      stroke(255);
      line(-100, 0, 100, 0);
      line(0, -100, 0, 100);
      
      
      //drawing barriers witch are usually invisible
      for (int i = 0; i < barriers.size(); i++) {
         noFill();
         stroke(255, 0, 0);
         
         rect(barriers.get(i).x, barriers.get(i).y, barriers.get(i).w, barriers.get(i).h);
         
         textAlign(CENTER, CENTER);
         textSize(10);
         
         fill(255, 0, 0);
         text("Barrier", barriers.get(i).x + (barriers.get(i).w/2), barriers.get(i).y - 15);
      }
      
      
      //show the containers
      for (int i = 0; i < containers.size(); i++) {
         containers.get(i).show();
      }
      
      
      //drawing the player
      p1.show();
      
      
      //the translated mouse
      noStroke();
      fill(255);
      ellipse(aMouseX, aMouseY, 10, 10);
      
      
      popMatrix();
      
      
      textAlign(LEFT, BOTTOM);
      textSize(15);
      
      //the debug menu
      text("Developer Mode: " + devMode, 5, 20);
      text("Player Coordinates: X " + floor(p1.x) + ", Y " + floor(p1.y), 5, 40);
      text("Keys Pressed: W " + keys[0] + ", A " + keys[1] + ", S " + keys[2] + ", D " + keys[3], 5, 60);
      
      
      //some simple math to detrmine the FPS
      altMils = mils;
      mils = millis();
      frameDif = mils - altMils;
      
      if (frameCount%10 == 0) {
         fps = floor(1/(frameDif/1000.0));
      }
      
      text("FPS: " + fps, 5, 80);
      
   }
   
   
};


void keyPressed() { 
   //listens for certain keys to be pressed and does something
   //w listener
   if (key == 'w') {
      keys[0] = true;
   }
   
   //a listener
   if (key == 'a') {
      keys[1] = true;
   }
   
   //s listener
   if (key == 's') {
      keys[2] = true;
   }
   
   //d listener
   if (key == 'd') {
      keys[3] = true;
   }
   
};


void keyReleased() {
   //listens for certain keys to be released and does something
   //w listener
   if (key == 'w') {
      keys[0] = false;
   }
   
   //a listener
   if (key == 'a') {
      keys[1] = false;
   }
   
   //s listener
   if (key == 's') {
      keys[2] = false;
   }
   
   //d listener
   if (key == 'd') {
      keys[3] = false;
   }
   
};
