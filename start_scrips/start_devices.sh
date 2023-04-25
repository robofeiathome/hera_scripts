#!/bin/bash

#ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
ip=127.0.0.1

robot_ip=${1:-$ip}
my_ip=${2:-$ip}
echo "robot_ip: " $robot_ip
echo "my_ip: " $my_ip

######################################################################

# export robot
#export ROS_MASTER_URI=http://${robot_ip[0]}:11311
# export extern
#export ROS_IP=${my_ip[0]}

# change rosconsole format
#export ROSCONSOLE_FORMAT='[${severity}] [${time}]: ${node}: ${message}'

# source catkin
source devel/setup.bash

######################################################################

# set usb rules
#sudo find . -name "*.rules" -exec cp {} /etc/udev/rules.d/ \;
#sudo udevadm control --reload
#sudo udevadm trigger

# usb permissions
sudo chmod 777 /dev/ttyACM*
sudo chmod 777 /dev/ttyUSB*
sudo chmod 777 /dev/opencm

# devices config 
# actuators #
enable_base=false
enable_dynamixel=false
# sensors #
enable_laser_front=false
enable_laser_back=false
enable_xtion=false
enable_camera=false
enable_kinect=false
enable_zed_wrapper=true

# start devices
roslaunch hera devices.launch \
    enable_base:=$enable_base \
    enable_laser_front:=$enable_laser_front \
    enable_laser_back:=$enable_laser_back \
    enable_xtion:=$enable_xtion \
    enable_camera:=$enable_camera \
    enable_kinect:=$enable_kinect \
    enable_dynamixel:=$enable_dynamixel \
    enable_zed_wrapper:=$enable_zed_wrapper
