  //Creating a class for the user buttons
  class Button{
    
  int xPos = 0;
  int yPos = 0;
  int buttonSize;
  String buttonText;
 
    Button(){
      buttonSize = (200);
      xPos = (200);
      yPos = (680);
      buttonText = "Click";
      
   } //Construct the class
 
  void makeButton(){

    fill(255);
    text("Press Spacebar", 200, 700);
    text("to save image", 200, 740);
    text("then Click to tweet!", 200, 780);
    
 }//close makeButton()
  
}// close the class