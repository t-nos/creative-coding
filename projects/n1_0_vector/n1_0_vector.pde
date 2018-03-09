import java.util.List;
import java.util.ArrayList;

class Mover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float topSpeed;
    color _color;

    Mover(float x, float y){
        this.location = new PVector(x, y);
        this.velocity = new PVector(0, 0);
        this.topSpeed = 10;
        this.acceleration = new PVector(0.001, 0.01);

        float baseHue = random(0, 1);
        this._color = color(baseHue, 0.5, 0.8);
    }

    void update(){
        // this.acceleration = PVector.random2D();
        // this.acceleration.mult(random(2));

        this.velocity.add(this.acceleration);
        this.velocity.limit(this.topSpeed);
        this.location.add(this.velocity);
        this.checkEdges();
    }

    void display(){
        stroke(this._color);
        fill(this._color);
        ellipse(this.location.x, this.location.y, 16, 16);
    }

    void checkEdges(){
        // if(this.location.x > width){
        //     this.location.x = 0;
        // } else if(this.location.x < 0){
        //     this.location.x = width;
        // }
        // if(this.location.y > height){
        //     this.location.y = 0;
        // } else if(this.location.y < 0){
        //     this.location.y = height;
        // } 
        PVector mouse = new PVector(mouseX, mouseY);
        PVector dir = PVector.sub(mouse, location);
        dir.normalize();
        dir.mult(0.5);
        this.acceleration = dir;

        if(this.location.x < 0 || width < this.location.x){
            this.acceleration.x *= -1;
            this.velocity.x *= -1;
        }
        if(this.location.y < 0 || height < this.location.y){
            this.acceleration.y *= -1;
            this.velocity.y *= -1;
        }

    }

}

List<Mover> moverList;
void setup(){
    colorMode(HSB, 1); // http://tomari.org/main/java/color/hsb.html

    moverList = new ArrayList();
    size(640, 360);
    for(int i=0; i<20; i++){
        moverList.add(new Mover(random(width), random(height)));
    }
}

void draw(){
    background(color(1, 0, 1));
    for(Mover m : moverList){
        m.update();
        m.display();
    }
}