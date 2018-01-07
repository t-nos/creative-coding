class Marble {
    int width, height;
    int dotSize = 4;
    int dotMargin = 4;
    float baseHue = 0.83;
    MarbleShape shape = null;

    Marble(int width, int height, int dotSize, int dotMargin){
        this.width = width;
        this.height = height;
        this.dotSize = dotSize;
        this.dotMargin = dotMargin;
    }

    Marble(int width, int height, int dotSize, int dotMargin, MarbleShape shape){
        this(width, height, dotSize, dotMargin);
        this.setShape(shape);
    }

    void setShape(MarbleShape shape){
        this.shape = shape;
    }

    void setBaseHue(float h){
        this.baseHue = h;
    }

    float getBaseHue(){
        return this.baseHue;
    }

    void draw(){
        for(int x = 0; x < this.width; x+=this.dotMargin){
            for(int y = 0; y < this.height; y+=this.dotMargin){
                if(this.shape == null || !this.shape.isHover(x, y)){
                    continue;
                }
                float n = noise(x * 0.003 + noiseX, y * 0.003 + noiseY, frameCount * 0.004);

                this.drawDot(x, y, n);
            }
        }
    }

    void drawDot(int x, int y, float noise){
        float v = int(noise*200);
        if(v%2 == 0 || v%3==0 || v%5==0){
            color c;
            if(v%2 == 0){
                c = color(this.baseHue, 0.9, 0.1);
            }else if(v%3==0){
                c = color(this.baseHue, 0.85, 0.99);
            }else if(v%5==0){
                c = color(this.baseHue, 0.9, 0.75);
            }else{
                c = color(this.baseHue, 0.9, 0.01);
            }
            fill(c);
            this.drawDot(x, y);
        }
    }

    void drawDot(int x, int y){
        ellipse(x, y, this.dotSize, this.dotSize);
    }
}


