import de.voidplus.leapmotion.*;

LeapMotion leap;

void setup(){
    size(640,360,P3D);    
    background(0);
    //noStroke(); 
    fill(50);
    
    frameRate(60);
    
    // Leap motion initialization
    leap = new LeapMotion(this);

    // P3D initialization
    lights();    
    spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 2);

    float fov = PI/3.0; 
    float cameraZ = (height/2.0) / tan(fov/2.0); 
    perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0); 
}

void draw(){
    background(0);
    color penColor = color(255,0,0);
    color fingerColor = color(0,255,0);
    color handColor = color(0,0,255);
    stroke(penColor);
    strokeWeight(10);
    
    int fps = leap.getFrameRate();

    for(Hand hand : leap.getHands()){
        PVector palmPosition = hand.getPalmPosition();
        PVector handDirection = hand.getDirection();
        //PVector palmNormal = hand.getPalmNormal();
        //println("position=" + palmPosition 
        //      + " direction=" + handDirection);
        pushMatrix();
        stroke(penColor);
        //strokeWeight(20);
        //line(palmPosition.x, palmPosition.y, -palmPosition.z, 
        //    handDirection.x, handDirection.y, -handDirection.z);
        translate(palmPosition.x, palmPosition.y, -palmPosition.z);
        float pitch = hand.getRoll();
        float yaw = hand.getYaw();
        float roll = hand.getPitch();
        println("pitch=" + pitch + " yaw=" + yaw + " roll=" + roll);
  rotateX(- radians(pitch) - HALF_PI);
  rotateY(- radians(roll));
  rotateZ( - radians(yaw)); //- HALF_PI/2);
        beginShape();
        strokeWeight(3);
        int palmSize = 25;
        stroke(color(255,0,0));
  vertex(-palmSize, -2 * palmSize, 0);
        stroke(color(128,128,0));
  vertex( palmSize, -2 * palmSize, 0);
        stroke(color(0,256,0));
  vertex( palmSize,  0, 0);
        stroke(color(0,128, 128));
  vertex(-palmSize,  0, 0);  
        stroke(color(0,0, 256));
  vertex(-palmSize, -2 * palmSize, 0);
  endShape();
 
        popMatrix();
        pushMatrix();
        stroke(handColor);
        //hand.draw();
        popMatrix();
        //println("finger count: " + hand.getFingers().size());
        int nbFingers = hand.getFingers().size();
        int iFinger = 0;
        PVector previousLerp = null;
        for(Finger finger : hand.getFingers()) {
          PVector tipPosition = finger.getPosition();
          PVector tipDirection = finger.getDirection();
          float length = finger.getLength();
          //println("tipDirection: " + tipDirection);
          pushMatrix();
          stroke(fingerColor);
          //line(palmPosition.x, palmPosition.y, -palmPosition.z, 
          //  tipPosition.x, tipPosition.y, -tipPosition.z);
          PVector tip = tipPosition.get();
          tip.sub(palmPosition);
        translate(palmPosition.x, palmPosition.y, -palmPosition.z);
          line(0, 2*palmSize/nbFingers * iFinger, 0, 
            tip.x, tip.y, -tip.z);
           popMatrix();
          pushMatrix();
       translate(palmPosition.x, palmPosition.y, -palmPosition.z);
          
          //finger.draw();
          stroke(color(0,0,256));
          PVector lerp = PVector.lerp(tipPosition, palmPosition, 0.7);
          line(lerp.x, lerp.y, -lerp.z, 
            tip.x, tip.y, -tip.z);
            if (previousLerp != null) line(lerp.x, lerp.y, -lerp.z, 
                    previousLerp.x, previousLerp.y, -previousLerp.z);
            previousLerp = lerp;
          popMatrix();
          iFinger++;
        }
    }
    
}


