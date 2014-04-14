import de.voidplus.leapmotion.*;

LeapMotion leap;
float x,y,z;
float memPitch;
PImage planeImage;

float[][] smoothValues = new float[3][5];
int smoothSize = 5;
int PITCH = 0;
int YAW = 1;
int ROLL = 2;

void setup(){
    size(640,360,OPENGL);    
    background(0);
    noStroke(); 
    fill(50);
    
    frameRate(60);
    
    // Leap motion initialization
    leap = new LeapMotion(this);

    // P3D initialization
    lights();
    x = width/2;
    y = height/2;
    z = 0;
    memPitch = 0;
    
    float fov = PI/3.0; 
    float cameraZ = (height/2.0) / tan(fov/2.0); 
    perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0); 
 
    planeImage = loadImage("hand.jpeg");
 
}

void draw(){
    background(0);
    
    int fps = leap.getFrameRate();

    for(Hand hand : leap.getHands()){
        PVector palmPosition = hand.getStabilizedPalmPosition();
        float   hand_roll        = hand.getRoll();
        float   hand_pitch       = hand.getPitch();
        float   hand_yaw         = hand.getYaw();
        float stabilizedPitch = stabilizedValue(hand_pitch, PITCH);
        float stabilizedYaw = stabilizedValue(hand_yaw, YAW);
        float stabilizedRoll = stabilizedValue(hand_roll, ROLL);
        println("pitch=" + stabilizedPitch + " yaw=" + stabilizedYaw
          + " roll=" + stabilizedRoll);
        drawPlane(palmPosition, stabilizedPitch, stabilizedYaw, 
          stabilizedRoll);
    }
}

float stabilizedValue(float value, int serie) {
    int which = frameCount % smoothSize;
    smoothValues[serie][which] = value;
    float sum = 0; 
    for(int i = 0; i < smoothSize; i++) {
        sum += smoothValues[serie][i]; 
    }
    float avg = sum/smoothSize;
    return avg;
}



void drawPlane(PVector center, float pitch, float yaw, float roll) {

  pushMatrix();
  ambientLight(255, 255, 255);
  pointLight(192, 255, 192, 1, 1, 1);
  translate(center.x, center.y, center.z);
  float invertedRoll = -roll; 
  rotateX(radians(invertedRoll) - HALF_PI);
  float invertedPitch = pitch; 
  rotateY(radians(invertedPitch));
  float invertedYaw = -yaw; 
  rotateZ( radians(invertedYaw) - HALF_PI/2);
  beginShape();
  textureMode(IMAGE);
  texture(planeImage);
  vertex(-200, -200, 0, 0,   0);
  vertex( 200, -200, 0, 225, 0);
  vertex( 200,  200, 0, 225, 225);
  vertex(-200,  200, 0, 0,   225);  
  endShape();
  popMatrix();

}


