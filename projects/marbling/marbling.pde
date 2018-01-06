float noiseX, noiseY;
CircleEdge circleEdge;
boolean DEBUG = true;
void setup(){
    if(DEBUG){
        try {
            testMethod();
        }catch(AssertionError e){
        e.printStackTrace();
        System.exit(0);
        }
    }

    noiseX = random(10000);
    noiseY = random(10000);
    size(300,300);
    noStroke();
    smooth();
    colorMode(HSB, 1); // http://tomari.org/main/java/color/hsb.html
    circleEdge = new CircleEdge(150, 150, 150);
}

void draw(){
    float radius = 2;
    float d = radius*2;
    float step = 1;
    //   float step = radius;
    background(0);
    for(int x = 0; x < width; x+=step){
        for(int y = 0; y < height; y+=step){
            if(circleEdge.isHover(x, y)){

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
}

class CircleEdge{
    private int x,y,r;
    CircleEdge(int x, int y, int r){
        this.x = x;
        this.y = y;
        this.r = r;
    }
    boolean isHover(int x, int y){
        int _x = x - this.x;
        int _y = this.y - y;
        return _x*_x + _y*_y - this.r*this.r <= 0;
    }
}

void testMethod(){
    CircleEdge c = new CircleEdge(150, 150, 150);
    assert c.isHover(150, 150) == true : "1";
    assert c.isHover(300, 300) == false : "2";
    assert c.isHover(0, 0) == false : "3";
    assert c.isHover(300, 0) == false : "4";
    assert c.isHover(200, 200) == true : "5";
}

