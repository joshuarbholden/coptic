


// Global parameters

int blockwidth = 50;
int blockheight = 75;
int numcols = 4;

// Example: Two Column objects
Column[] columns = new Column[numcols];

public void setup() {
  smooth();
  size(600, 1500);


  // Parameters go inside the parentheses when the object is constructed.
  for (int i = 0; i < numcols; i = i+1) {
    columns[i] = new Column(color(255, 255, 0), color(50, 100, 50), i*blockwidth, (2*numcols-i)*blockwidth, 0);
  }
}

void draw() {
  for (int i = 0; i < numcols; i = i+1) {
    columns[i].step();
    columns[i].display();
  }
  noLoop();
}

void keyPressed() {
  if (key == 'q') {
    exit();
  } else {
    loop();
  }
}


// Even though there are multiple objects, we still only need one class. 
// No matter how many cookies we make, only one cookie cutter is needed.
class Column { 
  color BG;
  color FG;  
  float xpos;
  float xflipped;
  float ypos;
  int twist;
  boolean Zslash;

  // The Constructor is defined with arguments.
  Column(color tempBG, color tempFG, float tempXpos, float tempXflipped, float tempYpos) { 
    BG = tempBG;
    FG = tempFG;
    xpos = tempXpos;
    xflipped = tempXflipped;
    ypos = tempYpos-blockheight;
    twist = 0;
  }

  void display() {
    fill(BG);
    strokeWeight(1);
    rect(xpos, ypos, blockwidth, blockheight);
    rect(xflipped- blockwidth, ypos, blockwidth, blockheight);
    stroke(FG);
    strokeWeight(4);
    if (Zslash) {
      line(xpos, ypos, xpos+blockwidth, ypos+blockheight);
      line(xflipped, ypos, xflipped-blockwidth, ypos+blockheight);
    } else {
      line(xpos+blockwidth, ypos, xpos, ypos+blockheight);
      line(xflipped-blockwidth, ypos, xflipped, ypos+blockheight);
    }
    fill(FG);
    textAlign(LEFT, BOTTOM);
    textSize(32);
    text(str(twist), xpos, ypos+blockheight);
  }

  void step() {
    if (random(0, 1)<0.5-0.0625*twist) {
      Zslash = true;
      twist = twist + 1;
    } else {
      Zslash = false;
      twist = twist - 1;
    }
    ypos = ypos + blockheight;
    if (ypos >= height) {
      if (xpos == 0) {
        background(200);
      }
      ypos = 0;
    }
  }
}
