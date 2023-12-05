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
map_name=larc23
resources='$(find robot_resources)'

model_name=/home/robofei/Workspace/catkin_ws/src/3rd_party/vision_system/detector_2d/models/new_and_old_objects.pt
# model_name=/home/robofei/Workspace/catkin_ws/src/3rd_party/vision_system/detector_2d/models/coco.pt
# model_name=yolov8n.pt


# robot info
robot_name=robot
robot_model='hera_full'

# robot config 
init_pos_x=-0.049227
init_pos_y=1.696732
init_pos_z=0.0
init_yaw=0.0

# modules config 
enable_hear=true
enable_talk=true
enable_map=false
enable_navigation=false
enable_manipulator=false
enable_head=false
enable_objects=false
enable_people=true
enable_color_filter=false
enable_octomap=false
enable_detector=false
enable_whisper=false
enable_tracker=false

# start robot
roslaunch hera bring_up.launch \
    enable_rviz:=$enable_rviz \
    map_name:=$map_name \
    model_name:=$model_name \
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
