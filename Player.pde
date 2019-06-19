class Player {
   
   float rotation = 0;
   
   //The coords of the player
   //x coord
   float x;
   //y coord
   float y;
   
   //the velocities of the x and y directions
   //x velocity
   float velX = 0;
   //y velocity
   float velY = 0;
   
   //the width and height of the player's hitbox
   //width
   float w = 40;
   //height
   float h = 40;
   
   
   //player's inventory
   int[][] playerInv = {
      {0, 0, 0, 0},
      {0, 0, 0, 0}
   };
   //player's hotbar
   int[] playerHotbar = {0, 0, 0, 0, 0};
   
   
   //constructor
   Player(float tempX, float tempY) {
      x = tempX;
      y = tempY;
   }
   
   
   //collision with barriers
   void collideWithBarrier(float VELX, float VELY) {
      for (int i = 0; i < loadedChunk.barriers.size(); i++) {
         if (x > loadedChunk.barriers.get(i).x - w && x < loadedChunk.barriers.get(i).x + loadedChunk.barriers.get(i).w && y > loadedChunk.barriers.get(i).y - h && y < loadedChunk.barriers.get(i).y + loadedChunk.barriers.get(i).h) {
            if (VELX > 0) {
               x = loadedChunk.barriers.get(i).x - w;
               velX = 0;
            }
            
            
            if (VELX < 0) {
               x = loadedChunk.barriers.get(i).x + loadedChunk.barriers.get(i).w;
               velX = 0;
            }
            
            
            if (VELY > 0) {
               y = loadedChunk.barriers.get(i).y - h;
               velY = 0;
            }
            
            
            if (VELY < 0) {
               y = loadedChunk.barriers.get(i).y + loadedChunk.barriers.get(i).h;
               velY = 0;
            }
            
            
         }
      }
   };
   
   
   //collision with containers
   void collideWithContainer(float VELX, float VELY) {
      for (int i = 0; i < loadedChunk.containers.size(); i++) {
         if (x > loadedChunk.containers.get(i).x - w && x < loadedChunk.containers.get(i).x + loadedChunk.containers.get(i).w && y > loadedChunk.containers.get(i).y - h && y < loadedChunk.containers.get(i).y + loadedChunk.containers.get(i).h) {
            if (VELX > 0) {
               x = loadedChunk.containers.get(i).x - w;
               loadedChunk.containers.get(i).velX = floor(velX);
            } else
            if (VELX < 0) {
               x = loadedChunk.containers.get(i).x + loadedChunk.containers.get(i).w;
               loadedChunk.containers.get(i).velX = ceil(velX);
            }
            
            
            if (VELY > 0) {
               y = loadedChunk.containers.get(i).y - h;
               loadedChunk.containers.get(i).velY = floor(velY);
            } else
            if (VELY < 0) {
               y = loadedChunk.containers.get(i).y + loadedChunk.containers.get(i).h;
               loadedChunk.containers.get(i).velY = ceil(velY);
            }
            
         }
      }
   };
   
   
   void update() {
      //updates the player's rotation based on the mouse coords
      rotation = atan2(y + (h/2) - aMouseY, x + (w/2) - aMouseX);
      
      
      //goes diffent directions depending on the mouse coords and what key is pressed
      //w goes towards the mouse
      if (keys[0]) {
         velX = -cos(rotation)*5;
         velY = -sin(rotation)*5;
      } else
      //s goes away from the mouse
      if (keys[2]) {
         velX = cos(rotation)*3;
         velY = sin(rotation)*3;
      } else
      //d goes to the right
      if (keys[3]) {
         velX = -cos(rotation + (PI/2))*4;
         velY = -sin(rotation + (PI/2))*4;
      } else
      //a goes to the left
      if (keys[1]) {
         velX = cos(rotation + (PI/2))*4;
         velY = sin(rotation + (PI/2))*4;
      } else
      //if no keys are being pressed then stop
      {
         velY = 0;
         velX = 0;
      }
      
      
      //moving
      //y direction
      y += velY;
      collideWithBarrier(0, velY);
      collideWithContainer(0, velY);
      //x direction
      x += velX;
      collideWithContainer(velX, 0);
      collideWithBarrier(velX, 0);
      
      
   };
   
   
   void display() {
      //developer mode
      if (devMode) {
         noFill();
         stroke(255);
         
         //hitbox
         rect(x, y, w, h);
         
         //graphics
         pushMatrix();
         translate(x + (w/2), y + (h/2));
         rotate(rotation);
         
         line(0, 0, -10, 0);
         
         popMatrix();
         
         fill(255);
         textAlign(CENTER, CENTER);
         textSize(10);
         text("Player", x + w/2, y - 15);
         
      }
   };
   
   
   //update and displays the player
   void show() {
      update();
      display();
   };
   
   
}
