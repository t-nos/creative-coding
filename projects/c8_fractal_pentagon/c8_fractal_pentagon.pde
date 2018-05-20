FractalRoot pentagon;
int MAX_LEVELS = 5;
int POLYGON_NUM = 5; // "360%POLYGON_NUM must be 0!"
float STRUT_FACTOR = 0.2;

void setup(){
    size(600, 600);
    smooth();
    pentagon = new FractalRoot();
    pentagon.draw();
}

class FractalRoot {
    PVector[] points = new PVector[POLYGON_NUM];
    Branch rootBranch;
    int angle = 360/POLYGON_NUM;

    FractalRoot(){
        float centX = width/2;
        float centY = height/2;
        float w = width-20; // margin
        float h = height-20; // margin
        int count = 0;
        for(int i=0; i<360; i+=angle){
            // 割り切れないパターン
            if(count>this.points.length-1){
                break;
            }
            float x = centX + (w/2 * cos(radians(i)));
            float y = centY + (h/2 * sin(radians(i)));
            this.points[count] = new PVector(x, y);
            count++;
        }
        this.rootBranch = new Branch(0, 0, points);
    }

    void draw(){
        rootBranch.draw();
    }
}

class Branch {
    int level, num;
    PVector[] points = {};
    PVector[] midPoints = {};

    Branch(int level, int num, PVector[] points){
        this.level = level;
        this.num = num;
        this.points = points;
        this.midPoints = this.calcMidPoints();
    }

    void draw(){
        strokeWeight(MAX_LEVELS-this.level);
        for(int i=0; i<this.points.length; i++){
            int next = i+1;
            if(next == this.points.length){
                next = 0;
            }
            PVector p1 = this.points[i];
            PVector p2 = this.points[next];
            line(p1.x, p1.y, p2.x, p2.y);
        }

        strokeWeight(0.5);
        fill(255, 150);
        for(PVector vec : this.midPoints){
            ellipse(vec.x, vec.y, 15, 15);
        }
    }

    PVector[] calcMidPoints(){
        PVector[] midPoints = new PVector[this.points.length];
        for(int i=0; i<this.points.length; i++){
            int next = i+1;
            if(next == this.points.length){
                next = 0;
            }
            PVector p1 = this.points[i].copy();
            PVector p2 = this.points[next].copy();
            midPoints[i] = p1.add(p2).div(2);
        }
        return midPoints;
    }
}