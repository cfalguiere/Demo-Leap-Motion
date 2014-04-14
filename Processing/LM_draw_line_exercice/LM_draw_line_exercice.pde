import de.voidplus.leapmotion.*;

LeapMotion leap;

float memX = 0;
float memY = 0;

color penColor = color(255,0,0);
boolean isPenActive = false;

long timeToWaitMs = 0;
long lastTime;

void setup(){
    size(640,360,P3D);    
    background(0);
    stroke(penColor); 
    strokeWeight(2);
    
    // Leap motion initialization
    // your code
}

void draw(){
    if (millis() - lastTime < timeToWaitMs) return;
       
    timeToWaitMs = 0;
    
    // your code
    
    lastTime = millis();
}

Finger getPointingFinger(Hand hand) {
  Finger selectedFinger = null;
  for(Finger finger : hand.getFingers()){
    if (finger.getLength() > 30.0f) {
        selectedFinger = finger;
    } 
  }
  return selectedFinger;
}  


void startPen(PVector startPosition) {
  isPenActive = true;
  memX = startPosition.x;
  memY = startPosition.y;
}

void usePen(PVector newPosition) {
  line(memX, memY, newPosition.x, newPosition.y);
  memX = newPosition.x;
  memY = newPosition.y;
}

void stopPen() {
  isPenActive = false;
}

void resetDrawing() {
    println("Resetting drawing");
    background(0);
    isPenActive = false;
    // your code
}


