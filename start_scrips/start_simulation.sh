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
map_name=fei_k5
enable_gui=true

# start simulation
roslaunch social_worlds start_world.launch \
    world_name:=$map_name \
    enable_gui:=$enable_gui
