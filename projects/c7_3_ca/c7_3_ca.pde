import java.util.List;
import java.util.ArrayList;


Cell[][] cellArray;
int NUM_X;
int NUM_Y;
final int CELL_SIZE = 10;

void setup(){
    size(500,300);
    NUM_X = floor(width/CELL_SIZE);
    NUM_Y = floor(height/CELL_SIZE);
    restart();
}

void restart(){
    cellArray = new Cell[NUM_X][NUM_Y];
    for(int x=0; x<NUM_X; x++){
        for(int y=0; y<NUM_Y; y++){
            cellArray[x][y] = new Cell(x, y);
        }
    }

    for(int x=0; x<NUM_X; x++){
        for(int y=0; y<NUM_Y; y++){
            int above = y-1;
            int below = y+1;
            int left = x-1;
            int right = x+1;
            if(above < 0){
                above = NUM_Y-1;
            }
            if(below == NUM_Y){
                below = 0;
            }
            if(left < 0){
                left = NUM_X-1;
            }
            if(right == NUM_X){
                right = 0;
            }
            cellArray[x][y].addNeighbour(cellArray[left][above]);
            cellArray[x][y].addNeighbour(cellArray[left][y]);
            cellArray[x][y].addNeighbour(cellArray[left][below]);
            cellArray[x][y].addNeighbour(cellArray[x][above]);
            cellArray[x][y].addNeighbour(cellArray[x][below]);
            cellArray[x][y].addNeighbour(cellArray[right][above]);
            cellArray[x][y].addNeighbour(cellArray[right][y]);
            cellArray[x][y].addNeighbour(cellArray[right][below]);
        }
    }
}

void draw(){
    background(255);
    for(int x=0; x<NUM_X; x++){
        for(int y=0; y<NUM_Y; y++){
            cellArray[x][y].calcNextState();
        }
    }
    translate(CELL_SIZE/2, CELL_SIZE/2);

    for(int x=0; x<NUM_X; x++){
        for(int y=0; y<NUM_Y; y++){
            cellArray[x][y].draw();
        }
    }
}

void mousePressed(){
    restart();
}

class Cell{
    private int age = 0;
    private float x, y;
    private boolean state;
    private boolean nextState;
    List<Cell> neighbours;
    color fillCol;
    color blankCol;
    

    Cell(float ex, float why){
        this.x = ex * CELL_SIZE;
        this.y = why * CELL_SIZE;
        this.nextState = random(2)>1;
        this.state = nextState;
        this.neighbours = new ArrayList();
        this.fillCol = color(random(255), random(255), random(255));
        this.blankCol = color(255);
    }

    void addNeighbour(Cell cell){
        this.neighbours.add(cell);
    }

    private int getLiveCount(){
        int n = 0;
        for(Cell c : this.neighbours){
            if(c.state){
                n++;
            }
        }
        return n;
    }

    void calcNextState(){
        boolean _nextState = true;
        int n = this.getLiveCount();
        if(this.state){
            // alive
            _nextState = (n == 2 || n == 3);
        }else{
            // dead
            _nextState = n == 3;
        }
        this.nextState = _nextState;

        if(this.nextState){
            this.age++;
        }
    }
    
    void draw(){
        this.state = this.nextState;
        color c = this.state ? this.fillCol : this.blankCol;
        fill(c, random(25));
        stroke(c, random(100));
        float size = this.getLiveCount();
        // ellipse(this.x, this.y, size*10, size*10);

        float x = this.x;
        float y = this.y;
        if(this.age % 3 == 0){
            x += this.age;
            y += this.age;
        }else if(this.age % 2 == 0){
            x -= this.age;
            y -= this.age;
        }
        // line(this.x, this.y, x+random(-5, 5), y+random(-5, 5));
        triangle(this.x-this.age, this.y+this.age, this.x+this.age/2, this.y+this.age, this.x-this.age, this.y-this.age);
    }
}