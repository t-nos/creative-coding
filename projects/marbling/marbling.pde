float noiseX, noiseY;
Marble marble;
boolean DEBUG = true;
int _n = 0;
void setup(){
    // System.setProperty("apple.awt.graphics.UseQuartz","false");
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
    size(500,500);
    noStroke();
    smooth();
    colorMode(HSB, 1); // http://tomari.org/main/java/color/hsb.html

    MarbleShape shape = new CircleShape(width/2, height/2, width/2);
    // MarbleShape shape = new RectShape(100, 100, 300, 300);
    int dotSize = 4;
    int dotMargin = dotSize;
    marble = new Marble(width, height, dotSize, dotMargin, shape);
    // marble.setBaseHue(0.25);
}

void draw(){
    background(0);
    marble.draw();
    marble.setBaseHue(sin(radians(_n)));
    _n++;
}

void testMethod(){
    CircleShape c = new CircleShape(150, 150, 150);
    assert c.isHover(150, 150) == true : "1";
    assert c.isHover(300, 300) == false : "2";
    assert c.isHover(0, 0) == false : "3";
    assert c.isHover(300, 0) == false : "4";
    assert c.isHover(200, 200) == true : "5";
}
