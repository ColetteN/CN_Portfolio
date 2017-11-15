class ClearSky {
  
  void ClearSkys () {
    
    color c = color(244, 150, 49);  // Define color 'c'
    fill(c);  // Use color variable 'c' as fill color
    noStroke();  // Don't draw a stroke around shapes
    triangle(width/2 - 20, height/2 - 100, width/2 + 20, height/2 - 100, width/2, height/2 - 150);
    triangle(width/2 , height/2 - 120, width/2, height/2 - 80, width/2 + 50, height/2 - 100);
    triangle(width/2 - 20, height/2 - 100, width/2 + 20, height/2 - 100, width/2, height/2 - 50);
    triangle(width/2 , height/2 - 120, width/2, height/2 - 80, width/2 - 50, height/2 - 100);
    
  }
  
}