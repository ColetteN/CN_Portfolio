//The Rain Class
//Drawing the rain drops

class Rain {
  int xPos, yPos;
  int size;
  color c;
  
  Rain(){
      size = (int)random(1,5);//random sized rain drops
      xPos = (int)random(width);//position random along x axis
      yPos = (int)random(height);
      c = color(120, 120, 120, 255);
  }//Construct the class
  
  void drawRain(){
    noStroke();  
    fill(c);
    ellipse(xPos, yPos, size, size*5);
  }
  
  void rainFall() {
    yPos += random(0,200);
    
    if (yPos >= width){
      yPos = -size;
    }
  }
  
  void rainSound(){
    rain.play();
  }
  
} //close the Rain() class