//Importing the library of video so we can use our webcam
import processing.video.*;

//References to our cam and graphics

Capture cam;
Scattered_Clouds myClouds;
ClearSky mySky;
Few_Cloud myFewClouds;
Broken_Cloud myBrokenClouds;

// Pulling our information from the online apis for eacgh location
String Aziziya = "http://api.openweathermap.org/data/2.5/weather?q=Aziziya&APPID=d4133a486a98f68a0ec664960ac1c164&mode=xml";
String Washington = "http://api.openweathermap.org/data/2.5/weather?q=Washington&APPID=d4133a486a98f68a0ec664960ac1c164&mode=xml";
String Helsinki = "http://api.openweathermap.org/data/2.5/weather?q=Helsinki&APPID=d4133a486a98f68a0ec664960ac1c164&mode=xml";
String Canberra = "http://api.openweathermap.org/data/2.5/weather?q=Canberra&APPID=d4133a486a98f68a0ec664960ac1c164&mode=xml";

// These strings will be used to pull the name of the location from the api the value is associated with it.
String locationAziziyaNode;
String locationWashingtonNode;
String locationHelsinkiNode;
String locationCanberraNode;

// These strings will be used to pull the value of the weather from the api that is associated with.
String locationAziziyaWeatherNode;
String locationWashingtonWeatherNode;
String locationHelsinkiWeatherNode;
String locationCanberraWeatherNode;

void setup() {
  size(640, 480);
  
  // Access our other classes that hold our graphics
  myClouds = new Scattered_Clouds();
  mySky = new ClearSky();
  myFewClouds = new Few_Cloud();
  myBrokenClouds = new Broken_Cloud();
  
  // Draws all geometry with smooth (anti-aliased) edges.
  smooth();
  
  // Setting the font type and size
  PFont generalFont = createFont("Times New Roman", 20, true); // Arial, 20 point, anti-aliasing on
  textFont(generalFont);

  // Storing the amout of cameras in an arry so that we can list them.
  // If there are no cameras in my computer we will get no video
  // But if there is a camera we can choose which camera we want by using the for loop in
  // Line 57 to loop through what cameras we have.
  // Line 61/62 will capture our camera and select the first camera in the array
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    exit();
    
  } 
  
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, cameras[0]);
    cam.start(); 
    
    // This String will call a function called on the startup which will load my key for my api key which will help me to access openweather api.
    
    String apiKey = getAPIKey();
    
    // We replace the string APIKEY to our actual apiKey for each location
    Aziziya = Aziziya.replace("APIKEY", apiKey);
    Washington = Washington.replace("APIKEY", apiKey);
    Helsinki = Helsinki.replace("APIKEY", apiKey);
    Canberra = Canberra.replace("APIKEY", apiKey);
    
    //I am loading the XML for each of our locations
    XML AziziyaxmlResponse = loadXML(Aziziya);
    XML WashingtonxmlResponse = loadXML(Washington);
    XML HelsinkixmlResponse = loadXML(Helsinki);
    XML CanberraxmlResponse = loadXML(Canberra);
    
    // Getting all the children elements for the parent tag of city
    XML AziziyalocationNode = AziziyaxmlResponse.getChild("city");
    XML WashingtonlocationNode = WashingtonxmlResponse.getChild("city");
    XML HelsinkilocationNode = HelsinkixmlResponse.getChild("city");
    XML CanberralocationNode = CanberraxmlResponse.getChild("city");
    
    //Getting the string of the child tag name
    locationAziziyaNode = AziziyalocationNode.getString("name");
    locationWashingtonNode = WashingtonlocationNode.getString("name");
    locationHelsinkiNode = HelsinkilocationNode.getString("name");
    locationCanberraNode = CanberralocationNode.getString("name");
    
    // Getting all the children elements for the parent tag of weather 
    XML AziziyaWeather = AziziyaxmlResponse.getChild("weather");
    XML WashingtonWeather = WashingtonxmlResponse.getChild("weather");
    XML HelsinkiWeather = HelsinkixmlResponse.getChild("weather");
    XML CanberraWeather = CanberraxmlResponse.getChild("weather");
    
    //Getting the string of the value tag name
    locationAziziyaWeatherNode = AziziyaWeather.getString("value");
    locationWashingtonWeatherNode = WashingtonWeather.getString("value");
    locationHelsinkiWeatherNode = HelsinkiWeather.getString("value");
    locationCanberraWeatherNode = CanberraWeather.getString("value");
    
    //Changes the way Processing interprets color data 
    colorMode(RGB, 255);
    
  }      
}

void draw() {
  
  // If there is a camera available the camera will be read
  if (cam.available() == true) {
    cam.read();
  }
  
  // cam will be the PImage read and the next two values are the x and y position of the camera
  image(cam, 0, 0);
  
  // if the key that is press is the Up key then all of the following code will run.
  // The rest of this code is the same if statement but with different keyCode values
  if ((keyPressed == true) && (keyCode == UP)) {
    
    if (locationCanberraWeatherNode.equals("clear sky") == true) {
      // Calling the void inside the class ClearSky
      mySky.ClearSkys();
    }
    
    if (locationCanberraWeatherNode.equals("few clouds") == true) {
      myFewClouds.FewClouds();
    }
    
    if (locationCanberraWeatherNode.equals("scattered clouds") == true) {
      myClouds.Clouds();
    }
    
    if (locationCanberraWeatherNode.equals("broken clouds") == true) {
      myBrokenClouds.BrokenCloud();
    }
    
    // If none of the values above are called the text will display whats inside the else statement
    else {
      textAlign(CENTER);
      text("Weather description is not available", width/2, 100);
    }
    
    // Lines 148 - 154 will display the text in the color black.
    color c = color(255, 0, 0);
    fill(c);
    textAlign(CENTER);
    text("Weather in: " + locationCanberraNode, width/2, 20);
    
    textAlign(CENTER);
    text("Weather description: " + locationCanberraWeatherNode, width/2, 60);
       
    }
    
    if ((keyPressed == true) && (keyCode == DOWN)) {
      
      if (locationWashingtonWeatherNode.equals("clear sky") == true) {
        mySky.ClearSkys();
      }
    
      if (locationWashingtonWeatherNode.equals("few clouds") == true) {
        myFewClouds.FewClouds();
      }
    
      if (locationWashingtonWeatherNode.equals("scattered clouds") == true) {
        myClouds.Clouds();
      }
    
      if (locationWashingtonWeatherNode.equals("broken clouds") == true) {
        myBrokenClouds.BrokenCloud();
      }
    
      else {
        textAlign(CENTER);
        text("Weather description is not available", width/2, 100);
      }
    
    color c = color(255, 0, 0);
    fill(c);
    textAlign(CENTER);
    text("Weather in: " + locationWashingtonNode, width/2, 20);
    
    textAlign(CENTER);
    text("Weather description: " + locationWashingtonWeatherNode, width/2, 60);
       
    }
    
    if ((keyPressed == true) && (keyCode == LEFT)) {
      
      if (locationHelsinkiWeatherNode.equals("clear sky") == true) {
        mySky.ClearSkys();
      }
    
      if (locationHelsinkiWeatherNode.equals("few clouds") == true) {
        myFewClouds.FewClouds();
      }
    
      if (locationHelsinkiWeatherNode.equals("scattered clouds") == true) {
        myClouds.Clouds();
      }
    
      if (locationHelsinkiWeatherNode.equals("broken clouds") == true) {
        myBrokenClouds.BrokenCloud();
      }
    
      else {
        textAlign(CENTER);
        text("Weather description is not available", width/2, 100);
      }
    
      textAlign(CENTER);
      text("Weather in: " + locationHelsinkiNode, width/2, 20);
    
      textAlign(CENTER);
      text("Weather description: " + locationHelsinkiWeatherNode, width/2, 60);
       
    }
    
    if ((keyPressed == true) && (keyCode == RIGHT)) {
      
      if (locationAziziyaWeatherNode.equals("clear sky") == true) {
        mySky.ClearSkys();
      }
    
      if (locationAziziyaWeatherNode.equals("few clouds") == true) {
        myFewClouds.FewClouds();
      }
    
      if (locationAziziyaWeatherNode.equals("scattered clouds") == true) {
        myClouds.Clouds();
      }
    
      if (locationAziziyaWeatherNode.equals("broken clouds") == true) {
        myBrokenClouds.BrokenCloud();
      }
    
      else {
        textAlign(CENTER);
        text("Weather description is not available", width/2, 100);
      }
    
      textAlign(CENTER);
      text("Weather in: " + locationAziziyaNode, width/2, 20);
    
      textAlign(CENTER);
      text("Weather description: " + locationAziziyaWeatherNode, width/2, 60);
       
    }
}

// The following function will replace the string of class key with the value of my APIKEY

String getAPIKey()
{
  String theKey = null;
  
  XML xml = loadXML("apikeys.xml");
  
  XML[] allKeys = xml.getChildren("key");
  
  for (int i=0; i<allKeys.length; i++)
    {
      if (allKeys[i].getString("provider").equals("openweathermap.org"))
      {        
        theKey = allKeys[i].getString("key");
        
        // we break out of the for loop when the above condition has been hit
        break;
      }
    }
  
  return theKey;
}