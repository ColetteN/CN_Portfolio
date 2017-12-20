//The Sunny Class
//Drawing the sky and sun

class Sunny{
  int xPos, yPos;
  int size;
  color c;
  
    Sunny(){
      size = (120);
      xPos = (120);
      yPos = (120);
      c = color(255,255,127);
  }//Construct the class
  
  void drawSunnyDay(){
    noStroke();  
    fill(c);
    ellipse(xPos, yPos, size, size);
  }
  
  void sunnyDaySound(){
    sun.play();
  }
  
}//Close the sunny class