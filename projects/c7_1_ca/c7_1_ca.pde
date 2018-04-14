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
    private float x, y;
    private boolean state;
    private boolean nextState;
    List<Cell> neighbours;

    Cell(float ex, float why){
        this.x = ex * CELL_SIZE;
        this.y = why * CELL_SIZE;
        this.nextState = random(2)>1;
        this.state = nextState;
        this.neighbours = new ArrayList();
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
    }
    
    void draw(){
        this.state = this.nextState;
        stroke(0);
        int c = this.state ? 0 : 255;
        fill(c);
        ellipse(this.x, this.y, CELL_SIZE, CELL_SIZE);
    }
}