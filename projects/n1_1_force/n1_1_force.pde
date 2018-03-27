import java.util.List;
import java.util.ArrayList;

class Mover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float topSpeed;
    color _color;
    float mass = 10.0;

    Mover(float x, float y, float mass){
        this.mass = mass;
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

        this.acceleration.mult(0);

        this.checkEdges();
    }

    void display(){
        stroke(this._color);
        fill(this._color);
        ellipse(this.location.x, this.location.y, 16, 16);
    }

    void applyForce(PVector force){
        PVector f = force.get();
        f.div(this.mass);
        this.acceleration.add(f);
    }

    void checkEdges(){
        PVector mouse = new PVector(mouseX, mouseY);
        PVector dir = PVector.sub(mouse, location);
        dir.normalize();
        dir.mult(0.5);
        this.acceleration = dir;

        boolean reflectX = false;
        if(this.location.x <= 0){
            this.location.x = 0;
            reflectX = true;
        }else if(width <= this.location.x){
            this.location.x = width;
            reflectX = true;
        }
        if(reflectX){
            this.acceleration.x *= -1;
            this.velocity.x *= -1;
        }

        boolean reflectY = false;
        if(this.location.y <= 0){
            this.location.y = 0;
            reflectY = true;
        }else if(height <= this.location.y){
            this.location.y = height;
            reflectY = true;
        }
        if(reflectY){
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
        moverList.add(new Mover(random(width), random(height), random(0.5, 3)));
    }
}

void draw(){
    background(color(1, 0, 1));
    for(Mover m : moverList){

        if(mousePressed){
            PVector wind = new PVector(0.5, 0);
            m.applyForce(wind);
        }
        m.update();
        m.display();
    }
}