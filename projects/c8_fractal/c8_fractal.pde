import java.util.List;
import java.util.ArrayList;

int NUM_CHILDREN = 4;
int MAX_LEVELS = 6;

Branch trunk;

void setup(){
    size(750, 500);
    background(255);
    noFill();
    smooth();
    newTree();
}

void draw(){
    background(255);
    trunk.updateMe(width/2, height/2);
    trunk.draw();
}

void mousePressed(){
    newTree();
}

void newTree(){
    trunk = new Branch(1, 0, width/2, height/2);
    trunk.draw();
}

class Branch {
    float level, index;
    float x, y;
    float endX, endY;
    List<Branch> children = new ArrayList();

    float strokeW, alpha;
    float length, lenChange, maxLength;
    float rotation, rotChange;

    Branch(float level, float index, float x, float y){
        this.level = level;
        this.index = index;

        this.strokeW = (1/this.level)*10;
        // this.strokeW = (1/this.level)*40;
        this.alpha = 255/this.level;
        this.maxLength = 200;
        this.length = (1/this.level)*random(this.maxLength);
        this.rotation = random(360);
        this.lenChange = random(10)-5;
        this.rotChange = random(10)-5;

        updateMe(x, y);
        if(this.level < MAX_LEVELS){
            for(int _x=0; _x<NUM_CHILDREN; _x++){
                this.children.add(new Branch(this.level+1, _x, this.endX, this.endY));
            }
        }
    }

    void updateMe(float x, float y){
        this.x = x;
        this.y = y;

        this.rotation += this.rotChange;
        if(this.rotation>360){
            this.rotation = 0;
        }else if(this.rotation<0){
            this.rotation = 360;
        }

        this.length -= this.lenChange;
        if(this.length<0){
            this.lenChange *= -1;
        }else if(this.length > this.maxLength){
            this.lenChange *= -1;
        }

        float radian = radians(this.rotation);
        this.endX = this.x + (this.length*cos(radian));
        this.endY = this.y + (this.length*sin(radian));

        for(Branch b : this.children){
            b.updateMe(this.endX, this.endY);
        }

    }

    void draw(){
        if(this.level > 1){
            strokeWeight(this.strokeW);
            stroke(0, this.alpha);
            fill(255, this.alpha);
            line(this.x, this.y, this.endX, this.endY);
            ellipse(this.endX, this.endY, this.length/12, this.length/12);
        }
        for(Branch b : this.children){
            b.draw();
        }
    }
}