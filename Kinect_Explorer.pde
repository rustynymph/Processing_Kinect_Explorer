import org.openkinect.processing.*; // For interfacing with the Kinect
import processing.opengl.*; // For implementing edge detection
import codeanticode.syphon.*; // For using syphon to send frames out

Kinect kinect;
SobelEdgeDetection sobel;
SyphonServer server;
PImage kinectImage;
int flag = 0;
boolean sendFrames = false;
boolean rgbEnabled = true;
boolean depthEnabled = false;
boolean edgesEnabled = false;
boolean colorDepthEnabled = false;
boolean irEnabled = false;
boolean mirrorEnabled = false;
float deg;

void settings(){
  size(640, 480, P2D);
  PJOGL.profile=1; // prevents OPENGL error 1282
}

void setup(){
  kinect = new Kinect(this);
  deg = kinect.getTilt();
  kinect.initVideo();
  kinect.initDepth();
  sobel = new SobelEdgeDetection();
  server = new SyphonServer(this, "Kinect Processing");
}

void draw(){
  kinect.enableIR(irEnabled);
  kinect.enableColorDepth(colorDepthEnabled);
  kinect.enableMirror(mirrorEnabled);
  
  if (rgbEnabled){
    kinectImage = kinect.getVideoImage();
  }
  if (depthEnabled){
    kinectImage = kinect.getDepthImage();
  } 
  if (edgesEnabled){
    kinectImage = getEdges(kinectImage);
  }
  image(kinectImage, 0, 0, width, height);
  
  if (sendFrames){
    server.sendScreen();
  }
}

PImage getEdges(PImage img){
  kinectImage = sobel.findEdgesAll(img, 90);
  kinectImage = sobel.noiseReduction(kinectImage, 1);
  return kinectImage;
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP) {
      deg++;
    } else if (keyCode == DOWN) {
      deg--;
    }
    kinect.setTilt(deg);
  }
  else if (key == 's' || key == 'S'){
    sendFrames = !sendFrames;
  }
  else if (key == 'd' || key == 'D' || key == 'r' || key == 'R'){ // switch between RGB and depth
    depthEnabled = !depthEnabled;
    rgbEnabled = !rgbEnabled;
  }
  else if (key == 'e' || key == 'E'){
    edgesEnabled = !edgesEnabled;
  }
  else if (key == 'c' || key == 'C'){
    colorDepthEnabled = !colorDepthEnabled;
  }
  else if (key == 'i' || key == 'I'){
    irEnabled = !irEnabled;
  }
  else if (key == 'm' || key == 'M'){
    mirrorEnabled = !mirrorEnabled;
  }
}