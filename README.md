# Kinect Explorer for Processing

This is a [Processing](https://processing.org/) project that interfaces with a Kinect v1 and contains a series of keyboard events that enable/disable different options and methods of the SimpleOpenNI library, can toggle edge detection, and can toggle whether or not to send frames out to other applications via Syphon (OSX only).
  
Features:  
* RGB camera
* Depth camera
* Depth color camera
* Edge detection
* Skeleton tracking
* Syphon  

Additionally, I have added the option for users toggle whether or not to pipe their live video feed via a [Syphon](http://syphon.v002.info/) server. Syphon is an open-source OSX technology that allows applications to share frames in real-time.

[SimpleOpenNI](http://openni.ru/files/simpleopenni/index.html) is a wrapper around [OpenNI](https://en.wikipedia.org/wiki/OpenNI) and NiTE for Processing. While this project utilizes the SimpleOpenNI library to use Processing to interface with a Kinect, you might also want to check out the [OpenKinect](http://shiffman.net/p5/kinect/) library. It is better documented and a little more friendly to beginners, however I decided to go with SimpleOpenNI because of their methods they have for skeleton tracking.

This project also contains slightly modified code from [Ian Gorse](https://www.openprocessing.org/sketch/2301) to perform [Sobel edge detection](https://en.wikipedia.org/wiki/Sobel_operator). 


## What you need  
* A Kinect
    * There are some methods in this project that will only work for Kinect v1, but if you are using v2 it should be easy to change. Check out [http://shiffman.net/p5/kinect/](http://shiffman.net/p5/kinect/) to see the slight differences between the two versions.
    * If you are wondering if you can use a Kinect and this project with OSX the answer is YES. See below for a list of instructions for getting this set up.
* [A Kinect AC Adapter/Power Supply](https://www.amazon.com/gp/product/B004IXRXGY/ref=oh_aui_detailpage_o02_s00?ie=UTF8&psc=1)
* [Processing](https://processing.org/) (Note: this project has only been built and tested on Processing 3.2.3)
* The following Processing libraries
    * SimpleOpenNI library 
        * This can be installed in Processing by simply going to `Sketch --> Import Library... --> Add Library...` and then searching for "SimpleOpenNI". Click install.
        * If you are using Processing 3 and above, then the above download will not work. There are 2 ways to fix this:
            * Downgrade your version of Processing
            * Follow the instructions [here](https://www.toomanybees.com/storytime/simple-open-ni) to get the library working with Processing 3
    * Syphon Processing library
        * This can be installed in Processing by simply going to `Sketch --> Import Library... --> Add Library...` and then searching for "Syphon". Click install.
    
## How to use
* Make sure your Kinect is powered on and plugged into a USB port
* Run this Processing project
* You can play around by using the following key commands
    * `r`: enables RGB camera (normal video feed, disables depth camera)
    * `d`: enables depth camera (disables RGB camera)
    * `u`: enables depth and skeleton tracking (disables RGB camera and depth camera)
    * `c`: toggles depth camera color
    * `e`: toggles edge detection
    * `s`: toggles sending frames via a [Syphon](http://syphon.v002.info/) server (OSX only)
    
## Getting your Kinect to work on OSX (instructions based on [this guide](https://creativevreality.wordpress.com/2016/01/26/setting-up-the-kinect-on-osx-el-capitan/))

#### Disable System Integrity Proctection
* Restart your Mac in Recovery mode (while your Mac is restarting hold Cmd-R)
* In the Utilities menu select Terminal
* Type `csrutil disable` and press ENTER
* Restart your Mac

#### Download and install MacPorts
* [http://www.macports.org/install.php](http://www.macports.org/install.php)

#### Install dependencies
* Open Terminal
* Type `sudo port install libtool` and press ENTER
* Restart your Mac
* Open Terminal
* Type `sudo port install libusb-devel +universal` and press ENTER
* Restart your Mac again...

#### Download and install OpenNI
* Open Terminal
* Type `mkdir ~/Kinect` and press enter (this creates a folder named _Kinect_ in your _Home_ directory)
* Download [OpenNI SDK (V1.5.7.10)](https://mega.nz/#!yJwg1DJS!uJiLY4180QGXjKp7sze8S3eDVU71NHiMrXRq0TA7QpU)
    * Do not download OpenNI v2 beta, it relies on the Microsoft Kinect SDK which we cannot use
* Move the zip file you just downloaded into your _Kinect_ folder and uncompress it
* Rename the uncompressed folder to _OpenNI_ (optional)
* Open Terminal
* Type `cd ~/Kinect/OpenNI` and press ENTER (change filepath names where necessary)
    * TIP: we will be using the `cd` command several times in this tutorial, if you'd like you can simply drag your folder from finder into your Terminal window and then press ENTER
* Type `sudo ./install.sh` and press ENTER
    
#### Download and install SensorKinect
* Open Terminal
* Type `sudo ln -s /usr/local/bin/niReg /usr/bin/niReg` and press ENTER
    * If that fails, try `sudo ln -s /usr/bin/niReg /usr/local/bin/niReg` instead
* Go to [https://github.com/avin2/SensorKinect](https://github.com/avin2/SensorKinect) 
    * Click the green `Clone or download` button and select `Download Zip`
* Move the downloaded zip to your _Kinect_ folder and uncompress it
* Rename the uncompressed folder to _SensorKinect_ (optional)
* Inside of the _SensorKinect_ folder, open the Bin folder
* Uncompress the file _SensorKinect093-Bin-MacOSX-v5.1.2.1.tar.bz2_
* Open Terminal
* Type `cd ~/Kinect/SensorKinect/SensorKinect093-Bin-MacOSX-v5.1.2.1` (change filepath names where necessary)
* Type `sudo ./install.sh`
    * If this step worked properly it should have installed the Primesense sensor as well
  
#### Install NiTE
* Download [NITE-Bin-MacOSX-v1.5.2.21.tar.zip](https://onedrive.live.com/?cid=33B0FE678911B037&id=33B0FE678911B037%21573&parId=33B0FE678911B037%21574&action=locate)
* Move this file to your _Kinect_ folder and uncompress it
* Rename the uncompressed folder to _NiTE_ (optional)
* Open Terminal
* Type `cd ~/Kinect/NiTE` and press ENTER (change filepath names where necessary)
* Type `sudo ./install.sh` and press ENTER

#### Test
* Plug in and power on your Kinect
* Copy the sample XML files from _NiTE/Data_ over to the _Data_ folder in _SensorKinect_
* Open Terminal
* Type `cd ~/Kinect/NiTE/Samples/Bin/x64-Release` and press ENTER
* Type `./Sample-PointViewer` and press ENTER to run the demo
    * If every step in this guide was successful you should see a tracking demo
  
#### Enable System Integrity Proctection (Optional)
* Earlier we disabled System Integrity Protection, follow these steps to re-enable it
* Restart Mac in recovery mode
* Find Terminal in the Utilies menu
* Type `csrutil enable` and press ENTER
* Restart your Mac
