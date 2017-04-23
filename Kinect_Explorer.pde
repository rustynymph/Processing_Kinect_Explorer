import processing.opengl.*; // For implementing edge detection
import SimpleOpenNI.*;
import codeanticode.syphon.*; // For using syphon to send frames out

SimpleOpenNI kinect;
SobelEdgeDetection sobel;
SyphonServer server;
PImage kinectImage;
boolean sendFrames = false;
boolean rgbEnabled = false;
boolean depthEnabled = true;
boolean edgesEnabled = false;
boolean colorDepthEnabled = false;
boolean userSkeletonTrackingEnabled = false;
color[]       userClr = new color[]{ color(255,0,0),
                                     color(0,255,0),
                                     color(0,0,255),
                                     color(255,255,0),
                                     color(255,0,255),
                                     color(0,255,255)
                                   };
PVector com = new PVector();                                   
PVector com2d = new PVector(); 

void settings(){
  size(640, 480, P2D);
  PJOGL.profile=1; // prevents OPENGL error 1282 when sending frames through Syphon
}

void setup(){
  kinect = new SimpleOpenNI(this);
  if(kinect.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  kinect.enableDepth();
  kinect.enableRGB(); // TO DO: cannot enable IR at same time as RGB, find a workaround
  kinect.enableUser();
  sobel = new SobelEdgeDetection();
  server = new SyphonServer(this, "Kinect Processing");
}

void draw(){
  kinect.update();
  kinect.setDepthToColor(colorDepthEnabled);
  
  if (rgbEnabled){
    kinectImage = kinect.rgbImage();
  }
  if (depthEnabled){
    kinectImage = kinect.depthImage();
  } 
  if (userSkeletonTrackingEnabled){
    kinectImage = kinect.userImage();
    // draw the skeleton if it's available
    int[] userList = kinect.getUsers();
    for(int i=0;i<userList.length;i++)
    {
      if(kinect.isTrackingSkeleton(userList[i]))
      {
        stroke(userClr[ (userList[i] - 1) % userClr.length ] );
        drawSkeleton(userList[i]);
      }      
        
      // draw the center of mass
      if(kinect.getCoM(userList[i],com))
      {
        kinect.convertRealWorldToProjective(com,com2d);
        stroke(100,255,0);
        strokeWeight(1);
        beginShape(LINES);
          vertex(com2d.x,com2d.y - 5);
          vertex(com2d.x,com2d.y + 5);
  
          vertex(com2d.x - 5,com2d.y);
          vertex(com2d.x + 5,com2d.y);
        endShape();
        
        fill(0,255,100);
        text(Integer.toString(userList[i]),com2d.x,com2d.y);
      }
    }    
  }
  if (edgesEnabled){
    kinectImage = getEdges(kinectImage);
  }
  image(kinectImage, 0, 0, width, height);
  
  if (sendFrames){
    server.sendScreen();
  }
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data
  /*
  PVector jointPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
  println(jointPos);
  */
  
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
}

PImage getEdges(PImage img){
  kinectImage = sobel.findEdgesAll(img, 90);
  kinectImage = sobel.noiseReduction(kinectImage, 1);
  return kinectImage;
}

void keyPressed(){
  if (key == 's' || key == 'S'){
    sendFrames = !sendFrames;
  }
  else if (key == 'd' || key == 'D'){ // switch between RGB and depth
    depthEnabled = true;
    rgbEnabled = false;
    userSkeletonTrackingEnabled = false;
  }
  else if (key =='r' || key == 'R'){
    rgbEnabled = true;
    depthEnabled = false;
    userSkeletonTrackingEnabled = false;
  }
  else if (key == 'u' || key == 'U'){
    userSkeletonTrackingEnabled = true;   
    rgbEnabled = false;
    depthEnabled = false; 
  }
  else if (key == 'e' || key == 'E'){
    edgesEnabled = !edgesEnabled;
  }
  else if (key == 'c' || key == 'C'){
    colorDepthEnabled = !colorDepthEnabled;
  }
}

// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}