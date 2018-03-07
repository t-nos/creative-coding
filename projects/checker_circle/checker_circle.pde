// ref: https://www.youtube.com/watch?v=VMOGIaS0GaE

import java.util.List;
import java.util.ArrayList;

List<Dot> dots = new ArrayList();

void setup(){
    int circleScale = 200;

    size(500,500);
    noStroke();
    smooth();
    colorMode(HSB, 1);
    color dotColor = color(0.66, 0.7, 0.7);

    translate(width/2, height/2);

    background(0, 0, 1);
    noFill();
    strokeWeight(1);
    stroke(dotColor);
    ellipse(0, 0, circleScale*2, circleScale*2);

    fill(dotColor);
    for(int i=0; i<360; i+=6){
        float theta = radians(i);
        int x = int(cos(theta)*circleScale);
        int y = int(sin(theta)*circleScale);
        Dot dot = new Dot(x, y, 4);
        dot.draw();
        dots.add(dot);
    }

    Dot dot1 = dots.get(45);
    for(Dot dot : dots){
        dot1.drawToDot(dot, dotColor);
    }

    Dot dot2 = dots.get(28);
    for(Dot dot : dots){
        dot2.drawToDot(dot, dotColor);
    }

    // Dot dot3 = dots.get(46);
    // fill(dotColor);
    // triangle(dot1.x, dot1.y, dot3.x, dot3.y, dot2.x, dot2.y);

    loadPixels();
    pixels[10] = color(0.2, 0.7, 0.7);
    pixels[20] = color(0.2, 0.7, 0.7);
    // fill(pixels[y*width + x]); //画面の点(x,y)の色情報を取得し、塗り色に設定
    // quad(dot1.x, dot1.y, dot3.x, dot3.y, dot2.x, dot2.y, dot2.x, dot2.y);
    updatePixels(); //画面の更新
}

class Dot{
    int x,y,r;
    Dot(int x, int y, int r){
        this.x = x;
        this.y = y;
        this.r = r;
    }

    void draw(){
        ellipse(this.x, this.y, this.r, this.r);
    }

    void drawToDot(Dot to, color strokeColor){
        line(this.x, this.y, to.x, to.y);
        stroke(strokeColor);
    }

}