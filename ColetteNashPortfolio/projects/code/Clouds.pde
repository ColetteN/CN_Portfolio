//The Cloud Class
//Drawing the clouds

class Cloud{
  int xPos, yPos;
  int size;
  color c;
  
    Cloud(){
      size = (int)random(80,200);//making clouds random sizes
      xPos = (int)random(-size, width);
      yPos = (int)random(0, height/4);
      c = 240;
  }//Construct the class
  
  void drawClouds(){
    noStroke();  
    fill(c);
    rect(xPos, yPos, size, size/2, 150);//rectangle with rounded edges
  }
  
  void drift() {
    xPos += random(1, 5);  
    if (xPos >= width){ //loop the clouds
      xPos = -size;
    }
  }
  
}//Close the clouds class