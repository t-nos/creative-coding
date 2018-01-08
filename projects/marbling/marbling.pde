Marble marbleCircle;
Marble marbleRect;
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
    size(500,500);
    noStroke();
    smooth();
    colorMode(HSB, 1); // http://tomari.org/main/java/color/hsb.html

    MarbleShape shapeCircle = new CircleShape(width/2, height/2, width/2);
    MarbleShape shapeRect = new RectShape(100, 100, 300, 300);
    int dotSize = 4;
    int dotMargin = dotSize;
    marbleCircle = new Marble(width, height, dotSize, dotMargin, shapeCircle);
    marbleRect = new Marble(width, height, dotSize, dotMargin, shapeRect);
    marbleRect.setAlpha(0.75);
    marbleRect.setNoiseX(marbleCircle.noiseX);
    marbleRect.setNoiseY(marbleCircle.noiseY);
    // marble.setBaseHue(0.25);
}

void draw(){
    background(0);

    fill(color(1,0.4,0.4), 1.0);
    ellipse(width/2, height/2, width, width);

    marbleCircle.draw();
    marbleCircle.setBaseHue(sin(radians(_n)));

    marbleRect.draw();
    marbleRect.setBaseHue(cos(radians(_n*2)));
    
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
