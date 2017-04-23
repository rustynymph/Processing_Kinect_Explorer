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
    * `up arrow key`: increases tilt of the Kinect (Kinect v1 only)
    * `down arrow key`: decreases tilt of the Kinect (Kinect v1 only)
    * `r`: toggles rgb camera (normal video feed)
    * `d`: toggles depth camera
    * `c`: toggles depth camera color
    * `i`: toggles IR
    * `e`: toggles edge detection
    * `m`: toggles mirroring
    * `s`: toggles sending frames via a [Syphon](http://syphon.v002.info/) server (OSX only)
    
#### Getting your Kinect to work on OSX (instructions based on [this guide](https://creativevreality.wordpress.com/2016/01/26/setting-up-the-kinect-on-osx-el-capitan/))
1. Disable System Integrity Proctection
    * Restart your Mac in Recovery mode (while your Mac is restarting hold Cmd-R)
    * In the Utilities menu select Terminal
    * Type `csrutil disable` and press ENTER
    * Restart your Mac
2. Download and install MacPorts
    * [http://www.macports.org/install.php](http://www.macports.org/install.php)
3. Install dependencies
    * Open Terminal
    * Type `sudo port install libtool` and press ENTER
    * Restart your Mac
    * Open Terminal
    * Type `sudo port install libusb-devel +universal` and press ENTER
    * Restart your Mac again...
4. Download and install OpenNI
    * Open Terminal
    * Type `mkdir ~/Kinect` and press enter (this creates a folder named Kinect in your Home directory)
    * Download [OpenNI SDK (V1.5.7.10)](https://mega.nz/#!yJwg1DJS!uJiLY4180QGXjKp7sze8S3eDVU71NHiMrXRq0TA7QpU)
        * Do not download OpenNI v2 beta, it relies on the Microsoft Kinect SDK which we cannot use
    * Move the zip file you just downloaded into your Kinect folder and uncompress it
    * Rename the uncompressed folder to "OpenNI" (optional)
    * Open Terminal
    * Type `cd ~/Kinect/OpenNI` and press ENTER (change filepath names where necessary)
        * TIP: we will be using the `cd` command several times in this tutorial, if you'd like you can simply drag your folder from finder into your Terminal window and then press ENTER
    * Type `sudo ./install.sh` and press ENTER
5. Download and install SensorKinect
    * Open Terminal
    * Type `sudo ln -s /usr/local/bin/niReg /usr/bin/niReg` and press ENTER
        * If that fails, try `sudo ln -s /usr/bin/niReg /usr/local/bin/niReg` instead
    * Go to [https://github.com/avin2/SensorKinect](https://github.com/avin2/SensorKinect) 
        * Click the green `Clone or download` button and select `Download Zip`
    * Move the downloaded zip to your Kinect folder in your home directory and uncompress it
      * Rename the uncompressed folder to "SensorKinect" (optional)
    * Inside of the SensorKinect folder, open the Bin folder
    * Uncompress the file SensorKinect093-Bin-MacOSX-v5.1.2.1.tar.bz2
    * Open Terminal
    * Type `cd ~/Kinect/SensorKinect/SensorKinect093-Bin-MacOSX-v5.1.2.1` (change filepath names where necessary)
    * Type `sudo ./install.sh`
        * If this step worked properly it should have installed the Primesense sensor as well
6. Install NiTE
    * Download [NITE-Bin-MacOSX-v1.5.2.21.tar.zip](https://onedrive.live.com/?cid=33B0FE678911B037&id=33B0FE678911B037%21573&parId=33B0FE678911B037%21574&action=locate)
    * Move this file to your Kinect folder and uncompress it
    * Rename the uncompressed folder to "NiTE" (optional)
    * Open Terminal
    * Type `cd ~/Kinect/NiTE` and press ENTER (change filepath names where necessary)
    * Type `sudo ./install.sh` and press ENTER
7. Test
    * Plug in and power on your Kinect
    * Copy the sample XML files from NiTE/Data over to the Data folder in SensorKinect
    * Open Terminal
    * Type `cd ~/Kinect/NiTE/Samples/Bin/x64-Release` and press ENTER
    * Type `./Sample-PointViewer` and press ENTER to run the demo
        * If every step in this guide was successful you should see a tracking demo
8. Enable System Integrity Proctection (Optional)
    * Earlier we disabled System Integrity Protection, follow these steps to re-enable it
    * Restart Mac in recovery mode
    * Find Terminal in the Utilies menu
    * Type `csrutil enable` and press ENTER
    * Restart your Mac
