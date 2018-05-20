import java.util.List;
import java.util.ArrayList;


Cell[][] cellArray;
int NUM_X;
int NUM_Y;
final int CELL_SIZE = 3;

void setup(){
    size(500,300);
    NUM_X = floor(width/CELL_SIZE);
    NUM_Y = floor(height/CELL_SIZE);
    restart();
    frameRate(10);
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

class Cell {
    protected int age = 0;
    color fillCol;
    color blankCol;

    protected float x, y;
    protected float state;
    protected float nextState;
    protected float lastState = 0;
    List<Cell> neighbours;

    Cell(float ex, float why){
        this.x = ex * CELL_SIZE;
        this.y = why * CELL_SIZE;
        this.nextState = ((x/500)+(y/300))*14;
        this.state = nextState;
        this.neighbours = new ArrayList();
        this.fillCol = color(random(255), random(255), random(255));
        this.blankCol = color(255);

    }

    void addNeighbour(Cell cell){
        this.neighbours.add(cell);
    }

    protected int getLiveCount(){
        int n = 0;
        for(Cell c : this.neighbours){
            n += c.state;
        }
        return n;
    }

    void draw(){
        this.state = this.nextState;
        color c = color(100+this.state/2, 40, 80+(this.state)/4, 200);
        stroke(c);
        // fill(this.state);
        fill(c);
        ellipse(this.x, this.y, CELL_SIZE, CELL_SIZE);
    }

    void calcNextState(){
        int mean = int(this.getLiveCount()/8);

        switch(mean){
            case 0:
                this.nextState = 255;
                break;
            case 255:
                this.nextState = 0;
                break;
            default:
                this.nextState = this.state + mean;
                if(this.lastState > 0){
                    this.nextState -= this.lastState;
                }
                if(this.nextState > 255){
                    this.nextState = 255;
                }else if (this.nextState < 0){
                    this.nextState = 0;
                }
                break;
        }
        this.lastState = this.state;
    }

}

