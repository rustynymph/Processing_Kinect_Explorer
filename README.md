# Kinect Explorer for Processing

This is a [Processing](https://processing.org/) project that interfaces with a Kinect v1 and contains a series of keyboard events that enable/disable different options and methods of Processing's OpenKinect library. 

#### What you need  
* A Kinect
    * There are some methods in this project that will only work for Kinect v1, but if you are using v2 it should be easy to change. Check out [http://shiffman.net/p5/kinect/](http://shiffman.net/p5/kinect/) to see the slight differences between the two versions.
    * If you are wondering if you can use a Kinect and this project with OSX the answer is YES. See below for a list of instructions for getting this set up.
* A Kinect to USB adapter
* [Processing](https://processing.org/) (Note: this project has only been built and tested on Processing 3.2.3)
* The following Processing libraries
    * Open Kinect Processing library 
    * Syphon Processing library
    * These libraries can be installed in Processing by going to `Sketch --> Import Library.. --> Add Library...` and then searching for "Open Kinect" and then "Syphon". Click install for each of these.
    
#### How to use
* Make sure your Kinect is powered on and plugged into a USB port
* Run this Processing project
* You can play around by using the following key commands
    * `up arrow key`:
    * `down arrow key`:
    * `r`: toggles rgb camera (normal video feed)
    * `d`: toggles depth camera
    * `c`: toggles depth camera color
    * `i`: toggles IR
    * `e`: toggles edge detection
    * `m`: toggles mirroring
    * `s`: toggles sending frames via a [Syphon](http://syphon.v002.info/) server (OSX only)
