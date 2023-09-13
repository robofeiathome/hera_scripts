#!/bin/bash

# source catkin
source devel/setup.bash

# start vizbox
cd src/vizbox/ 
python2 server.py image:=/kinect/rgb/image_color 
