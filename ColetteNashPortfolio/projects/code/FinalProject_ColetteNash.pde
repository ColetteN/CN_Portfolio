 //<>//

// Colette Nash Weather App for Dungarvan

// Twitter library
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

// Sound and Video libraries
import ddf.minim.*;
import processing.video.*;

// Declare class object
Twitter twitter;
File file;
Minim minim;
AudioPlayer rain;
AudioPlayer sun;
Button myButton;
Sunny mySunnyDay;

// The following are to hold the current date
int d = day();    // Values from 1 - 31
int m = month();  // Values from 1 - 12
int y = year();   // 2017 etc.

// The following will hold the current weather values from Dungarvan
int currentRain;
int currentClouds;
String currentSunny;

// Create the arrays
int numCloud;
ArrayList<Cloud> myCloud = new ArrayList<Cloud>(); 

int numDrops;
ArrayList<Rain> myRain = new ArrayList<Rain>();

// Declare a Capture object
Capture cam;

//Link to the openweather API
String url="http://api.openweathermap.org/data/2.5/weather?q=Dungarvan&APPID=APIKEY&mode=xml";

// Variable to hold the name of the location whose weather we are reading
String locationName;

void setup(){ 

  //Set my screen size
  size(1200, 800);
  
  // Twitter keys and tokens
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("ItJF9MQjw2GyTRNBfCROKZDdM");
  cb.setOAuthConsumerSecret("BG26xe4Xx0PeJY0sgExXDLE6jkQJcYDfmEud7QsnFeH8a9aYHu");
  cb.setOAuthAccessToken("2858884641-UHgYH09MUCtTTLXs2h9aLGAm647Z4qua9sIARz9");
  cb.setOAuthAccessTokenSecret("GqMKcIlJjnx8DKSzskQQG9skA7UUMYEVR3YZjZHGfp2W7");

  TwitterFactory tf = new TwitterFactory(cb.build());

  twitter = tf.getInstance();
  
  // Create a new object
  myButton = new Button();
  mySunnyDay = new Sunny();
 
  cam = new Capture(this); 
  cam.start();
  
  minim = new Minim(this);
  rain = minim.loadFile("rain.mp3");
  sun = minim.loadFile("sun.wav");
  
  // Set the font to use for text
  PFont generalFont = createFont("Comic Sans MS", 28, true); //Comic Sans, 28 point, anti-aliasing on
  textFont(generalFont);
  
  // Get the api key (using the function I wrote) and replace the text APIKEY in the 
  // link with the key
  String apiKey = getAPIKey();
  
  if (apiKey == null)
  {
    println("Failed to find API KEY for openweathermap.org");
    exit();
  }
  
  url = url.replace("APIKEY", apiKey);
  
  // loadXML loads the xml at the given url (or file)
  XML xmlResponse = loadXML(url);
  
  // Make the xmlResponse that prints to console indent using 5
  // spaces, then print out the string, makes easier to read
  print(xmlResponse.format(5));

  
   //Get the child of the root node ('current' in this case) called 'city'. The
  //getChild() method returns an XML object that models the XML in question.
  XML locationNode = xmlResponse.getChild("city");

  //Get the String value of the attribute called 'name' 
  locationName = locationNode.getString("name");
  
  
  XML cloudsNode = xmlResponse.getChild("clouds");
  XML weatherNode = xmlResponse.getChild("weather");
  XML precipitationNode = xmlResponse.getChild("precipitation");
  
  // Get the value of the 'clouds' attribute as a float and cast to an int 
  //as we need it in that format later
  
  currentClouds = (int)(cloudsNode.getFloat("value"));
  currentRain = (int)(weatherNode.getFloat("number"));
  currentSunny = (precipitationNode.getString("value"));
  numCloud = currentClouds;
  numDrops = currentRain;
  
  // Testing the xml value is being captured
  println("current clouds", currentClouds);
  println("current rain mode", currentRain);
  println("current sunny mode", currentSunny);
  
  // Initalising the Cloud() for loop here to populate with the value in the xml data
    for (int i = 0; i < numCloud; i++) {
      myCloud.add (new Cloud());
    } 
    
        for (int i = 0; i < 50; i++) {
          myRain.add (new Rain());
        } 
}//close setup()

void draw() {
  
  image(cam, 0, 0, width, height);
  
  // Text to click on screen
  myButton.makeButton();
  
  // Default sunshine behind clouds
  mySunnyDay.drawSunnyDay(); //call the method from the class
  mySunnyDay.sunnyDaySound(); 
  
  // Text printed at bottom of output screen
  textAlign(CENTER);
  fill(255);
  text("Current Weather In", width/2, 710);// Print onto screen and position
  text(locationName, width/2, 740);
  
  //Current date printed at bottom of screen
  String currentDate = String.valueOf(d);
  text(currentDate, 550, 780);
  currentDate = String.valueOf(m);
  text(currentDate, 590, 780); 
  currentDate = String.valueOf(y);
  text(currentDate, 640, 780);
  
  //Access the array values and run the following methods
      for (Cloud currentClouds: myCloud) {     
        currentClouds.drawClouds();
        currentClouds.drift();
      }
  
    //Access the array values and run the following methods
      if(this.currentRain < 800){  //note I am accessing the weathernode which gives a value
        for (Rain currentRain: myRain) {     //anything over 800 is clear skies and anything below
           currentRain.rainSound();          //is rain or drizzle see url below
           currentRain.drawRain();            //https://openweathermap.org/weather-conditions
           currentRain.rainFall();                        
         }  
      }   
}//close draw()

//When spacebar pressed current image/frame gets saved
void keyPressed(){
  if (key == 32){
    saveFrame("weather_today.jpg");
    file = new File("weather_today.jpg");//Add new image
  }
}

void tweet(){
    try
    {    //Twitter wont allow repeat tweets (they blocked me), the random function creates a unique tweet each time                     
        StatusUpdate status = new StatusUpdate("This is a weather tweet sent from Processing!"+ random(100) + random(200) + random(500));
        status.setMedia(file);//Tried to add image, not working!!
        twitter.updateStatus(status);
        //System.out.println("Status updated to [" + status.getText() + "].");
    }
    catch (TwitterException te)
    {
        System.out.println("Error: "+ te.getMessage());
    }
}

// When you click on the mouse the tweet gets sent
void mousePressed(){ 
  tweet();
}


String getAPIKey()
{
  String theKey = null;
  //Read the apikeys.xml file that I have in the data folder
    
  XML xml = loadXML("apikeys.xml");
  
  if (xml == null)
  {
    // The file isn't there lets "abort"
    println("Failed to locate the file apikeys.xml");
    exit();
  }
  else
  {
    // Note in the sample xml above I have only one key so the array will only have one element.
    // In the future I may have many keys.
    XML[] allKeys = xml.getChildren("key");
    
    for (int i=0; i<allKeys.length; i++)
    {
      if (allKeys[i].getString("provider").equals("openweathermap.org"))
      {        
        // Bingo, found the one I'm looking for. Set the APIKEY 
        theKey = allKeys[i].getString("key");
        
        // break out of the for loop, we have found what we are looking for
        break;
      }
    }
  }
  
  return theKey;
}

 void captureEvent(Capture c) {
 
  c.read();
}