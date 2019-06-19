/*
   Things to do:
      
      ***GET THE FILE SYSTEM WORKING***
      
      Make some UIs for inventory
      Get the item things done


*/

//developer mode
boolean devMode = true;

float fps = 0;
float mils = 0;
float altMils = 0;
float frameDif = 0;


//what save file?
int saveNum = 1;


//the player
Player p1;


//loads the chunk that the player is in
void loadChunk() {
   //loop through the stored chunks
   for (int i = 0; i < storedChunks.size(); i ++) {
      //if the player is inside the chunk
      if (storedChunks.get(i).x + 5000 > p1.x && storedChunks.get(i).x < p1.x + p1.w && storedChunks.get(i).y + 5000 > p1.y && storedChunks.get(i).y < p1.y + p1.h) {
         
         //if there is a chunk already loaded then...
         if (loadedChunk != null) {
            //...put it back into storage
            storedChunks.add(loadedChunk);
         }
         
         //load the selected chunk...
         loadedChunk = storedChunks.get(i);
         //...and remove it from storage
         storedChunks.remove(i);
         
         //and then exit
         return;
      }
   }
};


//the currently loaded chunk
Chunk loadedChunk;
//array list for all stored chunks
ArrayList<Chunk> storedChunks = new ArrayList<Chunk>();


//function for unpacking data from saved files
void loadSave() {
   //load the file
   JSONObject file = loadJSONObject(sketchPath() + "\\data\\save" + saveNum + ".json");
   //get the "data" object
   JSONObject data = file.getJSONObject("data");
   
   
   //get the "chunks" array
   JSONArray chunks = data.getJSONArray("chunks");
   
   //Loop through the chunks
   for (int i = 0; i < chunks.size(); i++) {
      //the currently selected chunk data
      JSONObject current = chunks.getJSONObject(i);
      
      
      //position of the chunk
      JSONObject position = current.getJSONObject("position");
      //x coord
      float chunkX = position.getFloat("x");
      //y coord
      float chunkY = position.getFloat("y");
      
      
      //Make the chunk
      storedChunks.add(new Chunk(chunkX, chunkY));
      
      
      //get the "blocks" array
      JSONArray blocks = current.getJSONArray("blocks");
      
      
      
      //get the "barriers" array
      JSONArray barriers = current.getJSONArray("barriers");
      
      for (int ba = 0; ba < barriers.size(); ba++) {
         //the current selected barrier
         JSONObject baCurrent = barriers.getJSONObject(ba);
         
         //get the values
         //x
         float baX = baCurrent.getFloat("x");
         //y
         float baY = baCurrent.getFloat("y");
         //width
         float baW = baCurrent.getFloat("w");
         //height
         float baH = baCurrent.getFloat("h");
         
         //import the data into the chunk
         storedChunks.get(i).barriers.add(new Barrier(baX, baY, baW, baH));
      }
      
      
      
      //get the "containers" array
      JSONArray containers = current.getJSONArray("containers");
      
      for (int co = 0; co < containers.size(); co++) {
         JSONObject coCurrent = containers.getJSONObject(co);
         
         int coType = coCurrent.getInt("type");
         float coX = coCurrent.getFloat("x");
         float coY = coCurrent.getFloat("y");
         
         storedChunks.get(i).containers.add(new Container(coType, coX, coY));
         
         /*JSONArray contents = coCurrent.getJSONArray("contents");
         
         
         for (int j = 0; j < contents.size(); j++) {
            int[] tempArr = {};
            
            JSONArray arrCurrent = contents.getJSONArray(j);
            
            for (int n = 0; n < arrCurrent.size(); n++) {
               int curNum = arrCurrent.getInt(n);
               tempArr = splice(tempArr, n, curNum);
               
            }
            
            
         storedChunks.get(i).containers.get(j).contents.add(tempArr);
            
         }*/
         
         
      }
      
      
      
   }
   
   //load the chunk the player is in
   loadChunk();
   
};



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

//mouse item
int mouseItem = 0;


//keeps track of if W, A, S, D, or E are being pressed
boolean[] keys = {false, false, false, false, false};


void setup() {
   size(1200, 700);
   
   
   p1 = new Player(0, 0);
   
};


void draw() {
   
   if (frameCount == 1) {
      loadSave();
   }
   
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
   
   
   //show the currently loaded chunk
   loadedChunk.show();
   
   
   //drawing the player
   p1.show();
   
   
   //the translated mouse
   noStroke();
   fill(255);
   ellipse(aMouseX, aMouseY, 10, 10);
   
   
   popMatrix();
   
   if (devMode) {
      textAlign(LEFT, BOTTOM);
      textSize(15);
      
      //the debug menu
      text("Developer Mode: " + devMode, 5, 20);
      text("Player Coordinates: X " + floor(p1.x) + ", Y " + floor(p1.y), 5, 40);
      text("Keys Pressed: W " + keys[0] + ", A " + keys[1] + ", S " + keys[2] + ", D " + keys[3], 5, 60);
      
      
      //some simple math to determine the FPS
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
