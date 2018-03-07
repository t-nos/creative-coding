class Walker {
    int x;
    int y;

    Walker() {
        this.x = width/2;
        this.y = height/2;
    }

    void display(){
        stroke(0);
        point(this.x, this.y);
    }

    void step(){
        int choice = int(random(4));

        int xstep = 1;
        int ystep = 1;
        if(random(1)<0.01){
            int m = int(montecarlo()*50);
            println(m);
            xstep = m;
            ystep = m;
        }

        if(int(random(3))%3==0){
            xstep = mouseX > this.x ? xstep : -xstep;
            ystep = mouseY > this.y ? ystep : -ystep;
            this.x += xstep;
            this.y += ystep;
        }else{
            float r = random(1);
            if(r < 0.25){
                this.x += xstep;
            }else if(r < 0.5){
                this.y += ystep;
            }else if(r < 0.75){
                this.x -= xstep;
            }else{
                this.y -= ystep;
            }
        }
    }

    float montecarlo(){
        while(true){
            float r1 = random(1);
            float p = r1;
            float r2 = random(1);
            if(r2 < p){
                return r1;
            }
        }
    }
}

Walker w;
void setup(){
    size(640, 360);
    w = new Walker();
    background(255);
}

void draw(){
    w.step();
    w.display();
}