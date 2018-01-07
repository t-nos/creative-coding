interface MarbleShape {
    boolean isHover(int x, int y);
}

class CircleShape implements MarbleShape{
    private int x,y,r;
    CircleShape(int x, int y, int r){
        this.x = x;
        this.y = y;
        this.r = r;
    }
    boolean isHover(int x, int y){
        int _x = x - this.x;
        int _y = this.y - y;
        return _x*_x + _y*_y - this.r*this.r <= 0;
    }
}

class RectShape implements MarbleShape{
    private int x,y,width,height;
    RectShape(int x, int y, int width, int height){
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }
    boolean isHover(int x, int y){
        return this.x <= x && x <= this.x+this.width &&
               this.y <= y && y <= this.y+this.height;
    }
}
