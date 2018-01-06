float noiseX, noiseY;
void setup(){
  noiseX = random(10000);
  noiseY = random(10000);
  size(300,300);
  noStroke();
//   frameRate(30);
  smooth();
  colorMode(HSB, 1); // http://tomari.org/main/java/color/hsb.html
}

void draw(){
  float radius = 2;
  float d = radius*2;
  float step = 1;
//   float step = radius;
  background(0);
  for(int x = 0; x < width; x+=step){
    for(int y = 0; y < height; y+=step){
      float n = noise(x * 0.003 + noiseX, y * 0.003 + noiseY, frameCount * 0.004);
      float v = int(n*200);
      if(v%2 == 0 || v%3==0 || v%5==0){
        color c;
        float h = 0.83;
        if(v%2 == 0){
            c = color(h, 0.9, 0.1);
        }else if(v%3==0){
            c = color(h, 0.85, 0.99);
        }else if(v%5==0){
            c = color(h, 0.9, 0.75);
        }else{
            c = color(h, 0.9, 0.01);
        }
        fill(c);
        ellipse(x, y, d, d);
      }
    }
  }
}

