void setup(){
    int split = 4;
    int interval = 3;
    size(800, 800);
    background(150);
    stroke(0, 50);
    fill(255, 200);
    float xstart = random(10);
    float ynoise = random(10);
    println(xstart);
    println(ynoise);
    translate(width/2, height/2);
    for(float y=-(height/split); y<=(height/split); y+=interval){
        ynoise += 0.02;
        float xnoise = xstart;
        for(float x=-(width/split); x<=(width/split); x+=interval){
            xnoise += 0.02;
            drawPoint(x, y, noise(xnoise, ynoise));
        }
    }
}

void drawPoint(float x, float y, float noiseFactor){
    pushMatrix();
    translate(x+noiseFactor*4, y*noiseFactor*4. -y);
    float edgeSize = noiseFactor*26;
    ellipse(0, 0, edgeSize, edgeSize);
    popMatrix();
}