import java.util.Random;
Random generator;
Random generatorY;

void setup(){
    size(640, 360);
    generator = new Random();
    generatorY = new Random();
    colorMode(HSB, 1); // http://tomari.org/main/java/color/hsb.html

}

void draw(){
    float num = (float)generator.nextGaussian();
    float sd = 60;
    float mean = 320;

    float x = sd * num + mean;
    float baseHue = 0.45;
    color c = color(baseHue, 0.4, 0.1);

    float prob = 0.1;
    float y = 180;
    if (random(1)<prob){
        float numY = (float)generatorY.nextGaussian();
        y =  30 * numY + 180;
    }

    noStroke();
    fill(c, 0.1);
    ellipse(x, y, 16, 16);

}