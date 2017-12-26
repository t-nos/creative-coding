
void setup(){
  
   size(500, 500);
   background(0);
   fill(255);
   translate(width/2, height/2);
   int scale = 200;
   int noiseScale = 50;
   int n = 500;
   float rad = TWO_PI/n;
   for(int i=0; i<n; i++){
      float x = sin(i*rad)*scale;
      float y = cos(i*rad)*scale;
      println(x);
      int cr = (int)(noise(0.2*i)*255);
      int cg = (int)(noise(0.21*i)*255);
      int cb = (int)(noise(0.22*i)*255);
      fill(cr, cg, cb);
      int noiseX = (int)(noise(i)*noiseScale);
      int noiseY = (int)(noise(i)*noiseScale);
      ellipse(x+noiseX,y+noiseY,4,4);     
     
   }
}