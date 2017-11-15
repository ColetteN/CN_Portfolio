Cloud cloud1;
Cloud cloud2;
void setup() {
  background(59, 226, 255);
  size(800, 800);
  smooth();
  noStroke();
  int ground = 20;
  color grass = #1EFF00;
  fill(color(grass));
  rect(0, height-ground, width, ground); // sets up grass ground
  Tree tree1 = new Tree(Tree.TLL); // draws the different trees and shapes
  tree1.drawTree(width-600, 530, 50, 250);
  Tree  tree2 = new Tree(Tree.SHRT);
  tree2.drawTree(width-400, 685, 50, 100);
  Tree tree3 = new Tree(Tree.TLL);
  tree3.drawTree(width-200, 530, 50, 250 );
  Tree tree4 = new Tree(Tree.SHRT);
  tree4.drawTree(width-100, 685, 50, 100);
  Rock rock1 = new Rock(Rock.STONE);
  rock1.drawRock(width-500, 755, 100, 50);
  Rock rock2 = new Rock(Rock.STONE);
  rock2.drawRock(width-280, 770, 100, 25);
  cloud1 = new Cloud(Cloud.FLF);
  cloud2 = new Cloud(Cloud.FLF);
  cloud2.Ypos=300;
  cloud2.Xspeed=19;
}
void draw() { // Draws these when mouse is pressed
  if (mousePressed) {
    background(41, 51, 50);
    noStroke();
    //ck  Cloud cloud1 = new Cloud(Cloud.FLF);
    //ck  cloud1.drawCloud(200, 100, 300, 100);
    //cloud1.drawCloud(200, 100, 300, 100, 0, 10, 3);
    cloud1.drive();
    //cloud1.display();
    cloud1.drawCloud(200, 100, 300, 100, 0, 10, 3);
    // cloud2.drawCloud(600, 250, 160, 90, 0, 100, 3 );
    cloud2.drive();
    //cloud2.display();
    cloud2.drawCloud(100, 250, 160, 90, 0, 100, 3 );
    Moon moon1 = new Moon(700, 200, 50, 50);
    moon1.drawMoon(700, 100, 100, 100);
    Firefly Firefly1 = new Firefly();
    Firefly1.update();
    Firefly1.display();
    for (int i = 0; i<10; i++) {
      int ground = 20;
      //color grass = (30, 255, );
      fill(30*1.5, 255/2, 0);
      rect(0, height-ground, width, ground);
      Tree tree1 = new Tree(Tree.TLL);
      tree1.drawTree(width-600, 530, 50, 250);
      Tree  tree2 = new Tree(Tree.SHRT);
      tree2.drawTree(width-400, 685, 50, 100);
      Tree tree3 = new Tree(Tree.TLL);
      tree3.drawTree(width-200, 530, 50, 250 );
      Tree tree4 = new Tree(Tree.SHRT);
      tree4.drawTree(width-100, 685, 50, 100);
      Rock rock1 = new Rock(Rock.STONE);
      rock1.drawRock(width-500, 755, 100, 50);
      Rock rock2 = new Rock(Rock.STONE);
      rock2.drawRock(width-280, 770, 100, 25);
    }
  }
  else { // redraws everything when mouse is released
    background(59, 226, 255);
    int ground = 20;
    color grass = #1EFF00;
    fill(color(grass));
    rect(0, height-ground, width, ground);
    Sun sun1 = new Sun(20, 20, 300, 300);
    sun1.drawSun(20, 20, 300, 300, 150, 25, 300, 20, 125, 100, 400, 150, 80, 150, 220, 300);
    noStroke();
    Tree tree1 = new Tree(Tree.TLL);
    tree1.drawTree(width-600, 530, 50, 250);
    Tree  tree2 = new Tree(Tree.SHRT);
    tree2.drawTree(width-400, 685, 50, 100);
    Tree tree3 = new Tree(Tree.TLL);
    tree3.drawTree(width-200, 530, 50, 250 );
    Tree tree4 = new Tree(Tree.SHRT);
    tree4.drawTree(width-100, 685, 50, 100);
    Rock rock1 = new Rock(Rock.STONE);
    rock1.drawRock(width-500, 755, 100, 50);
    Rock rock2 = new Rock(Rock.STONE);
    rock2.drawRock(width-280, 770, 100, 25);
  }
}
class Tree { // class for tree
  int x;
  int y;
  int w;
  int h;
  int style = 0;
  color leaves = #018A02;
  color bark = #542300;
  final static int TLL = 0;
  final static int SHRT = 1;
  //Tree(){
  //}
  Tree(int style) {
    this.style = style;
  }
  void drawTree( int x, int y, int w, int h) {
    switch(style) { // different styles
    case 0:
      fill(color(bark));
      rect(x, y, w, h);
      fill(color(leaves));
      ellipse(x+25, y-w, w+25, h-100);
      fill(color(leaves));
      ellipse(x+25, y-w, w+50, h);
      break;
    case 1:
      fill(color(bark));
      rect(x, y, w, h-5);
      fill(color(leaves));
      ellipse(x+25, y-20, w, h-10);
      fill(color(leaves));
      ellipse(x+25, y-30, w+35, h-20);
      break;
    }
  }
  void setStyle(int style) {
    this.style = style;
  }
}
class Rock { // Rock class
  int x;
  int y;
  int w;
  int h;
  int style = 0;
  color stone = #878582;
  final static int STONE = 0;
  Rock(int style) {
    this.style = style;
  }
  void drawRock(int x, int y, int w, int h) {
    switch(style) { // sets style
    case 0:
      fill(color(stone));
      ellipse(x, y, w, h);
      break;
    }
  }
  void setStyle(int style) {
    this.style = style;
  }
}
class Cloud { //cloud class
  int x;
  int y;
  int w=200;
  int h=100;
  int style = 0;
  // int Xspeed = 2;
  float Xpos;
  float Ypos;
  float Xspeed=10;
  //float xpos = tempXpos;
  //float ypos = tempYpos;
  //float xspeed =tempXSpeed;
  final static int FLF = 0;
  Cloud(int style) {
    //   this.style = style;
    //int Xspeed = Xspeed;
  }
  //ck void drawCloud(int x, int y, int w, int h, float xpos, float ypos,  float xspeed)
  void drawCloud(int x, int y, int w, int h, float tempXpos, float tempYpos, float tempXspeed)
  {
    switch(style) {
    case 0:
      fill(255);
      rect(Xpos, Ypos, w, h, 20);
      break;
    }
    //    Xpos = tempXpos;
    //    Ypos = tempYpos;
    //  Xspeed =tempXspeed;
  }
  void drive() {
    Xpos = Xpos + Xspeed;
    if (Xpos > width) {
      Xpos = 0;
    }
  }
  void display() {
    //ck rect(x, y, w, h, 20);
    fill(255);
    //rect(Xpos, Ypos, 20, 10);
    rect(x, y, w, h, 20);
    // rect(xpos,ypos,20,10);
  }
  void setStyle(int style) {
    this.style = style;
  }
}
class Moon { // moon class
  int x;
  int y;
  int w;
  int h;
  Moon(int x, int y, int w, int h) {
    this.x = x;
    this.y= y;
    this.w = w;
    this.h = h;
  }
  void drawMoon(int x, int y, int w, int h) {
    fill(252, 249, 224);
    ellipse(x, y, w, h);
    fill(41, 51, 50);
    ellipse(x-20, y-20, w, h);
  }
}
class Sun {
  int x;
  int y;
  int w;
  int h;
  int x1;
  int x2;
  int x3;
  int x4;
  int x5;
  int x6;
  int y1;
  int y2;
  int y3;
  int y4;
  int y5;
  int y6;
  Sun(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void drawSun( int x, int y, int w, int h, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4, int x5, int y5, int x6, int y6) {
    fill(#FF9F18);
    ellipse(x, y, w, h);
    stroke(#FF9F18);
    line(x1, y1, x2, y2);
    line(x3, y3, x4, y4);
    line(x5, y5, x6, y6);
  }
}
class Firefly {
  int x;
  int y;
  int w;
  int h;
  Firefly(int x, int y) {
    this.x = x;
    this.y = y;
  }
  // The Firefly tracks location, velocity, and acceleration
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Fireflies's maximum speed
  float topspeed;
  Firefly() {
    // Start in the center
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    topspeed = 5;
  }
  void update() {
    // Compute a vector that points from location to mouse
    PVector mouse = new PVector(mouseX, mouseY);
    PVector acceleration = PVector.sub(mouse, location);
    // Set magnitude of acceleration
    acceleration.setMag(.2);
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
  }
  void display() {
    ;
    strokeWeight(2);
    fill(#FFF610);
    ;
    ellipse(location.x, location.y, 10, 10);
  }
}