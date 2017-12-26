void setup(){
    size(500, 400);
    background(255);
    strokeWeight(0.5);
    smooth();
    
    float radius = 100;
    int centx = width/2;
    int centy = height/2;

    stroke(0, 30);

    noFill();
    ellipse(centx, centy, radius*2, radius*2);
    stroke(20, 50, 70);
    strokeWeight(1);


    float noiseVal = random(10);
    beginShape();
    fill(20, 50, 70, 50);
    int startAngle = 0;
    int endAngle = 360;
    int stepAngle = 1;
    for(float angle=startAngle; angle<=endAngle; angle+=stepAngle){
        noiseVal += 0.1;
        float r = radius + 30*customNoise(noiseVal);
        float rad = radians(angle);
        float x = centx + (r*cos(rad));
        float y = centy + (r*sin(rad));
        curveVertex(x,y);
    }
    endShape();
}

float customNoise(float value){
    return pow(sin(value), 3);
}