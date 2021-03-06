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
    protected int state;
    protected int nextState;
    List<Cell> neighbours;

    Cell(float ex, float why){
        this.x = ex * CELL_SIZE;
        this.y = why * CELL_SIZE;
        this.nextState = int(random(2));
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
            if(c.state == 1){
                n++;
            }
        }
        return n;
    }

    void draw(){
        this.state = this.nextState;
        stroke(0);
        int c = 255;
        switch(this.state){
            case 1:
                c = 0;
                break;
            case 2:
                c = 150;
                break;
        }
        fill(c);
        ellipse(this.x, this.y, CELL_SIZE, CELL_SIZE);
    }

    void calcNextState(){
        switch(this.state){
            case 0:
                this.nextState = this.getLiveCount() == 2 ? 1 : this.state;
                break;
            case 1:
                this.nextState = 2;
                break;
            case 2:
                this.nextState = 0;
                break;
            default:
                // do nothing
        }
    }

}

