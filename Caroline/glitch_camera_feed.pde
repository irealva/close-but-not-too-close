import processing.video.*;

Capture cam;

int N = 0;
int glitchAmount = 50;

void setup() {
  size (1200,600);
  background(255);
  colorMode(HSB);
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
 
    // Initialize camera
    cam = new Capture(this, cameras[0]);
    cam.start(); 
  } 
}

void draw(){
  if (cam.available() == true) {
    // Update canvas every 10 frames for some lag
    if (frameCount % 10==0) {
      cam.read();
      image(cam, 0, 0);
      set(width, height, cam);
      // Every glitchAmount / 20 frames, glitch the camera feed
      if ((glitchAmount / 20 != 0) && frameCount % (glitchAmount / 20) == 0) {
        glitchFeed();
      }
      // Every glitchAmount / 8 frames, add some rainbow stuff
      if(((glitchAmount/8)!=0) && frameCount%(glitchAmount/8)==0) {
        // Randomly fill in pretty colors
        for (int i = 0; i < 100; i++) {
          noStroke();
          fill(random(0,360),300,300,100);
          rect ((random (0, width)),(random (0, height)),(random (0,50)),(random(0,50)));
        }
      }
    }
  }

}

// Get a random number
int r(int a){
  return int(random(a));
}

// Scramble the camera feed
void glitchFeed() {
  for (int i=0; i<200; i++) {
    int x = r(width);
    int y = r(height);
    set(x+r(80)-1,y+r(3)-1,get(x,y,r(99),r(30)));
  }
}