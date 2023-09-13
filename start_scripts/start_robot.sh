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
source devel/setup.zsh

######################################################################

# main info
enable_rviz=false
map_name=simulation/robocup_2019
resources='$(find robot_resources)'

# robot info
robot_name=robot
robot_model='hera_full'

# robot config 
init_pos_x=-0.049227
init_pos_y=1.696732
init_pos_z=0.0
init_yaw=0.0

# modules config 
enable_hear=false
enable_talk=false
enable_map=true
enable_navigation=true
enable_manipulator=false
enable_head=true
enable_objects=false
enable_people=false
enable_color_filter=false
enable_octomap=false
enable_detector=true
enable_whisper=true
enable_tracker=true

# start robot
roslaunch hera bring_up.launch \
    enable_rviz:=$enable_rviz \
    map_name:=$map_name \
    resources:="$resources" \
    robot_name:=$robot_name \
    robot_model:="$robot_model" \
    init_pos_x:=$init_pos_x \
    init_pos_y:=$init_pos_y \
    init_pos_z:=$init_pos_z \
    init_yaw:=$init_yaw \
    enable_hear:=$enable_hear \
    enable_talk:=$enable_talk \
    enable_map:=$enable_map \
    enable_people:=$enable_people \
    enable_color_filter:=$enable_color_filter \
    enable_navigation:=$enable_navigation \
    enable_manipulator:=$enable_manipulator \
    enable_objects:=$enable_objects \
    enable_head:=$enable_head \
    enable_octomap:=$enable_octomap \
    enable_detector:=$enable_detector \
    enable_whisper:=$enable_whisper \
    enable_tracker:=$enable_tracker
