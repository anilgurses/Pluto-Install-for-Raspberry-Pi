#!/bin/bash

echo "Setup is started"

apt-get -y install libxml2 libxml2-dev bison flex libcdk5-dev cmake
apt-get -y install libaio-dev libusb-1.0-0-dev libserialport-dev libxml2-dev libavahi-client-dev doxygen graphviz

mkdir instl
cd instl

git clone https://github.com/analogdevicesinc/libiio.git
cd libiio
cmake ./
make -j 4 all
make install
PATH=/usr/lib/:$PATH

echo "Lib-IIO is installed"
cd ..
git clone https://github.com/analogdevicesinc/libad9361-iio.git
cd libad9361-iio
cmake ./
make -j 4
make install
cd ..
echo "Libad9361-iio is installed"

apt-get -y install libglib2.0-dev libgtk2.0-dev libgtkdatabox-dev libmatio-dev libfftw3-dev libxml2 libxml2-dev bison flex libavahi-common-dev libavahi-client-dev libcurl4-openssl-dev libjansson-dev cmake libaio-dev
git clone https://github.com/analogdevicesinc/iio-oscilloscope.git
cd iio-oscilloscope
git checkout origin/master
make -j 4
make install
cd ..
echo "iio-oscilloscope is installed"

apt-get install python3-pip
pip3 install pandas numpy

apt-get -y install gnuradio-dev libxml2 libxml2-dev bison flex cmake git libaio-dev libboost-all-dev swig
git clone https://github.com/analogdevicesinc/gr-iio.git
cd gr-iio
cmake -DCMAKE_INSTALL_PREFIX=/usr .
make -j 4
make install
cd ..
echo "Gnu Radio is installed"

ldconfig

cd ..
rm -rf instl
