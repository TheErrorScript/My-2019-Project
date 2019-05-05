class Container {
   
   //the type of container
   int type;
   
   //the container's position
   //x coord
   float x;
   //y coord
   float y;
   
   //the velocities of the container
   //x direction
   float velX = 0;
   //y direction
   float velY = 0;
   
   //width and height of the container's hitbox
   //width
   float w = 0;
   //height
   float h = 0;
   
   
   //the contents of the container
   int[][] contents;
   
   
   //constructor
   Container(int tempType, float tempX, float tempY/*, int[][] tempContents*/) {
      type = tempType;
      x = tempX;
      y = tempY;
      //contents = tempContents;
   };
   
   
   //collision with barriers
   void collideWithBarrier(float VELX, float VELY) {
      for (int i = 0; i < barriers.size(); i++) {
         if (x > barriers.get(i).x - w && x < barriers.get(i).x + barriers.get(i).w && y > barriers.get(i).y - h && y < barriers.get(i).y + barriers.get(i).h) {
            if (VELX > 0) {
               x = barriers.get(i).x - w;
               velX = 0;
            }
            
            
            if (VELX < 0) {
               x = barriers.get(i).x + barriers.get(i).w;
               velX = 0;
            }
            
            
            if (VELY > 0) {
               y = barriers.get(i).y - h;
               velY = 0;
            }
            
            
            if (VELY < 0) {
               y = barriers.get(i).y + barriers.get(i).h;
               velY = 0;
            }
            
            
         }
      }
   };
   
   
   void update() {
      if (type == 0) {
         w = 30;
         h = 30;
      }
      
      //slowing the container if it is moved
      //x direction
      if (velX > 0) {
         velX -= ceil(velX/2);
      } else
      if (velX < 0) {
         velX -= floor(velX/2);
      }
      //y direction
      if (velY > 0) {
         velY -= ceil(velY/2);
      } else
      if (velY < 0) {
         velY -= floor(velY/2);
      }
      
      
      y += velY;
      collideWithBarrier(0, velY);
      x += velX;
      collideWithBarrier(velX, 0);
      
      
   };
   
   
   void display() {
      
      
      if (devMode) {
         noFill();
         
         stroke(255, 150, 0);
         
         rect(x, y, w, h);
         
         fill(255, 150, 0);
         textAlign(CENTER, CENTER);
         textSize(10);
         text("Container", x + w/2, y - 15);
         
         
      }
      
      
   };
   
   
   void show() {
      update();
      display();
   };
   
   
}
