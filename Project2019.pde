

//developer mode
boolean devMode = true;


//the player
Player p1;


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
      
      p1.show();
      
      
      //the translated mouse coords
      fill(255);
      ellipse(aMouseX, aMouseY, 10, 10);
      
      
      popMatrix();
      
      
      textAlign(LEFT, BOTTOM);
      textSize(15);
      
      //the debug menu
      text("Developer Mode: " + devMode, 5, 20);
      text("Player Coordinates: X " + floor(p1.x) + ", Y " + floor(p1.y), 5, 40);
      text("Keys Pressed: W " + keys[0] + ", A " + keys[1] + ", S " + keys[2] + ", D " + keys[3], 5, 60);
      
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
