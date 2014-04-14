import de.voidplus.leapmotion.*;

LeapMotion leap;

void setup(){
    size(640,360,OPENGL);    
    background(0);
    noStroke(); 
    fill(50);
    
    // Leap motion initialization
    // your code

    // P3D initialization
    lights();    
    spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 2);

    float fov = PI/3.0; 
    float cameraZ = (height/2.0) / tan(fov/2.0); 
    perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0); 
}

void draw(){
    background(0);
    
   
    // your code
}

void drawSphere(PVector center, float radius) {
    pushMatrix();
    pointLight(51, 102, 126, 0, 1, 0);
    translate(center.x, center.y, center.z/10*-1);
    stroke( color(192,255,192));
    sphere(radius);
    popMatrix();
}

