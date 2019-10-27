# Pluto-Install-for-Raspberry-Pi
Step by step instructions to use Pluto with your Raspberry Pi

This is my own personal getting started guide.  Even though I work for Analog Devices, this is not sanctioned by them!  These are just what I found to work well to run my Pluto on a Raspberry Pi 3B+ Stretch Install.  YMMV!!  
For the ultimate source of Pluto truth, please use https://wiki.analog.com/university/tools/pluto

But here is what I found to get Pluto working with my Raspberry Pi 3B+ (running Stretch)

1.  Install the Stretch operating system on your Raspberry Pi 3B+ (there's lots of guides out there to do this!)

2.  Here's some basic settings I like to configure (these are personal preference)
    - Enable SPI and VNC
    - Enable VNC (I use VNC viewer instead of a HDMI monitor/keyboard/mouse.  I think its much easier and less klunky.)
    - Change your password!!!!
    - Set Resolution to 1920x1080
    
3.  Open a command window (any notes that start with "~$" mean I'm in a command window) and:

    ~$ sudo apt-get update
    
    ~$ sudo apt-get upgrade
    
4.  Install IIOscope and the Pluto USB drivers:

    a.	I'm following the getting started instructions here:  https://wiki.analog.com/sdrseminars
    
        i.	https://wiki.analog.com/resources/tools-software/linux-software/libiio#building_on_the_linuxzynq_target
        
            1.	~$  sudo apt-get install libxml2 libxml2-dev bison flex libcdk5-dev cmake
            
            2.	~$  sudo apt-get install libaio-dev libusb-1.0-0-dev libserialport-dev libxml2-dev libavahi-client-dev doxygen graphviz
            
            3.	~$  git clone https://github.com/analogdevicesinc/libiio.git
            
            4.	~$  cd libiio
            
            5.	~$  cmake ./
            
            6.	~$  make all
            
            7.	~$  sudo make install
            
            8.	~$  PATH=/usr/lib/:$PATH
            
            9.	~$  iio_info
            
                  a.	This will return IIOLIB library version if it installed correctly
                  
        ii.	https://wiki.analog.com/resources/eval/user-guides/ad-fmcomms5-ebz/multi-chip-sync#linux
        
            1.	cd back to pi@raspberrypi:~$:  
            
            2.	~$  git clone https://github.com/analogdevicesinc/libad9361-iio.git
            
            3.	~$  cd libad9361-iio
            
            4.	~$  cmake ./
            
            5.	~$  make
            
            6.	~$  sudo make install
            
      iii.	https://wiki.analog.com/resources/tools-software/linux-software/iio_oscilloscope#linux
      
            1.	cd back to pi@raspberrypi:~$:  
            
            2.	~$  sudo apt-get -y install libglib2.0-dev libgtk2.0-dev libgtkdatabox-dev libmatio-dev libfftw3-dev libxml2 libxml2-dev bison flex libavahi-common-dev libavahi-client-dev libcurl4-openssl-dev libjansson-dev cmake libaio-dev
            
            3.	~$  git clone https://github.com/analogdevicesinc/iio-oscilloscope.git
            
            4.	~$  cd iio-oscilloscope
            
            5.	~$  git checkout origin/master
            
            6.	~$  make -j 4
            
            7.	~$  sudo make install
            
            8.	~$  osc
            
                a.  Typing “osc” should launch IIOscope
                
     b.	At this point, Pluto should work when plugged into USB port and “osc” is launched

5.  Python Libray Install (make sure to use Python 3, Python 2 is not officially supported by Pluto--though it may work)

    a.  Install my favorite python libraries (so that we can write fun python scripts for Pluto):
    
        i.	~$  sudo apt-get install python3-pip
        
       ii.	~$  sudo apt-get install python3-tk
       
      iii.	~$  sudo apt-get install python3-pandas
      
       iv.	~$  pip3 install numpy
       
        v.	~$  pip3 install pandas
        
       vi.	~$  pip3 install matplotlib
       
            1.	All the pip3 installs took a long time, but eventually they each installed
            
    b. Test out Pluto Python operation
    
        i.	Download pluto.py from https://github.com/analogdevicesinc/plutosdr_scripts
        
            1.  This is a good example to get and plot data
            
       ii.	cd to where pluto.py is
       
      iii.	~$  python3 -i pluto.py
      
            1.	the -i will make python3 stay open so that you can look at variables in the command line
            
            2.	or double click on pluto.py to open in Thonny and run from there
            
6.  Install GNU Radio on the Raspberry Pi (this is another very fun program that works great with Pluto)

      1.	Install GNU Radio
      
          a.	https://wiki.analog.com/resources/tools-software/linux-software/gnuradio
          
              i.	~$  sudo apt-get -y install gnuradio-dev libxml2 libxml2-dev bison flex cmake git libaio-dev libboost-all-dev swig
              
          b.	~$  git clone https://github.com/analogdevicesinc/gr-iio.git
          
          c.	~$  cd gr-iio
          
          d.	~$  cmake -DCMAKE_INSTALL_PREFIX=/usr .
          
          e.	~$  make 
          
          f.	~$  sudo make install
          
          g.	~$  cd ..
          
          h.	~$  sudo ldconfig
          
      2.	Launch GNU Radio Companion, hit the search icon, and type Pluto.  Everything should launch and find the Pluto plugin block.  
          a.	Put down the “PlutoSDR Source” block
          
          b.	Connect it to a “QT GUI Sink” block
          
          c.	Save and hit play
          
          d.	You should see graph or something open and run data from Pluto
          
          e.	If you get an error, make sure you used the command “cmake -DCMAKE_INSTALL_PREFIX=/usr .” in the gr-iio instructions above!

 
