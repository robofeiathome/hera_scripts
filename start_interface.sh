#!/bin/bash

# ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
ip=127.0.0.1

robot_ip=${1:-$ip}
my_ip=${2:-$ip}
echo "robot_ip: " $robot_ip
echo "my_ip: " $my_ip

######################################################################

# export robot
export ROS_MASTER_URI=http://${robot_ip[0]}:11311
# export extern
export ROS_IP=${my_ip[0]}

# change rosconsole format
export ROSCONSOLE_FORMAT='[${severity}] [${time}]: ${node}: ${message}'

# source catkin
source devel/setup.bash

######################################################################

# <!-- main info -->
enable_rviz=true
enable_teleop=true
enable_bot=false

# start interface
roslaunch hera interface.launch \
    enable_rviz:=$enable_rviz \
    enable_teleop:=$enable_teleop \
    enable_bot:=$enable_bot 
