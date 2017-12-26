void setup(){
    size(500, 400);
    background(255);
    strokeWeight(0.5);
    smooth();
    
    int centx = width/2;
    int centy = height/2;

    stroke(random(20), random(50), random(70), 30);
    // noFill();
    // ellipse(centx, centy, radius*2, radius*2);
    // stroke(20, 50, 70);
    for(int i=0; i<100; i++){
        int startAngle = int(random(360));
        int endAngle = 360*4 + int(random(360*4));
        int stepAngle = 5 + int(random(3));

        float lastx = -999;
        float lasty = -999;
        float radiusNoise = random(10);
        float radius = 10;

        for(float angle = startAngle; angle <= endAngle; angle += stepAngle){
            radiusNoise += 0.05;
            radius += 0.5;
            float r = radius + (noise(radiusNoise)*200)-100;
            float rad = radians(angle);
            float x = centx + (r*cos(rad));
            float y = centy + (r*sin(rad));
            if(lastx > -999){
                line(x, y, lastx, lasty);
            }
            lastx = x;
            lasty = y;
        }
    }


}