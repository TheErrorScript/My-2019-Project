class Chunk {
   
   //position of chunk
   //x coord
   float x;
   //y coord
   float y;
   
   //every chunk is 5000x5000
   
   //array list to store the blocks inside the chunk
   ArrayList<Block> blocks = new ArrayList<Block>();
   
   //array list to store the barriers inside the chunk
   ArrayList<Barrier> barriers = new ArrayList<Barrier>();
   
   //array list to store the containers inside the chunk
   ArrayList<Container> containers = new ArrayList<Container>();
   
   //array list to store the items inside the chunk
   ArrayList<Item> items = new ArrayList<Item>();
   
   
   //constructor
   Chunk(float tempX, float tempY) {
      x = tempX;
      y = tempY;
   };
   
   
   //shows everything in the chunk
   void show() {
      
      
      //shows the blocks
      for (int i = 0; i < blocks.size(); i++) {
         //blocks.get(i).show();
      }
      
      
      //if dev mode is enabled then show the barrier borders 
      if (devMode) {
         for (int i = 0; i < barriers.size(); i++) {
            stroke(255, 0, 0);
            
            noFill();
            rect(barriers.get(i).x, barriers.get(i).y, barriers.get(i).w, barriers.get(i).h);
         }
      }
      
      
      //shows the containers
      for (int i = 0; i < containers.size(); i++) {
         containers.get(i).show();
      }
      
      //shows the items on the ground
      for (int i = 0; i < items.size(); i++) {
         //items.get(i).show();
      }
      
   };
   
   
};
