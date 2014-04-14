import de.voidplus.leapmotion.*;

LeapMotion leap;

void setup(){
    size(640,360,P3D);    
    background(0);
    noStroke(); 
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
    
    int fps = leap.getFrameRate();

    for(Hand hand : leap.getHands()){
        PVector palmPosition = hand.getStabilizedPalmPosition();
        float   sphere_radius    = hand.getSphereRadius();
        println("position=" + palmPosition 
              + " radius=" + sphere_radius);
        drawSphere(palmPosition, sphere_radius );
    }
    
}

void drawSphere(PVector center, float radius) {
    pushMatrix();
    pointLight(51, 102, 126, 0, 1, 0);
    translate(center.x, center.y, center.z/10*-1);
    stroke( color(192,255,192));
    scale((-1*center.z/100) + 0.8);
    sphere(radius);
    popMatrix();
}

