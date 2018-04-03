import java.util.List;
import java.util.ArrayList;

int circleNum = 10;
final int maxCircleNum = 150;
List<Circle> circleList;

void setup(){
    size(500, 300);
    background(255);
    smooth();
    strokeWeight(1);
    fill(150, 50);
    circleList = new ArrayList();
}

void draw(){
    background(255);
    for(Circle c : circleList){
        c.update();
    }
}

void mouseReleased(){
    drawCircles();
}

void drawCircles(){
    if(circleList.size() > maxCircleNum){
        circleList.subList(0, circleNum).clear();
    }
    for(int i=0; i<circleNum; i++){
        circleList.add(new Circle());
    }
}

class Circle {
    float x, y;
    float radius;
    color lineCol, fillCol;
    float alpha;
    float xMove, yMove;

    Circle(){
        this.x = random(width);
        this.y = random(height);
        this.radius = random(100) + 10;
        this.lineCol = color(random(255), random(255), random(255));
        this.fillCol = color(random(255), random(255), random(255));
        this.alpha = random(225);
        this.xMove = random(10)-5;
        this.yMove = random(10)-5;
    }

    void update(){
        this.x += this.xMove;
        this.y += this.yMove;
        this.draw();

        if(this.x > (width+this.radius) ){
            this.x = 0 - this.radius;
        }
        if(this.x < (0-this.radius)){
            this.x = width + this.radius;
        }
        if(this.y > (height+this.radius)){
            this.y = 0-this.radius;
        }
        if(this.y < (0-radius)){
            this.y = height + this.radius;
        }
    }

    void draw(){
        noStroke();
        fill(this.fillCol, this.alpha);
        ellipse(this.x, this.y, this.radius*2, this.radius*2);
        stroke(this.lineCol, 150);
        noFill();
        ellipse(this.x, this.y, 10, 10);
    }
}