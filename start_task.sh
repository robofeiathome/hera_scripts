#!/bin/bash

# ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
ip=127.0.0.1

robot_ip=${1:-$ip}
my_ip=${2:-$ip}
echo "robot_ip: " $robot_ip
echo "my_ip: " $robot_ip

# export robot
export ROS_MASTER_URI=http://${robot_ip[0]}:11311
# export extern
export ROS_IP=${robot_ip[0]}

# change rosconsole format
export ROSCONSOLE_FORMAT='[${severity}] [${time}]: ${node}: ${message}'

# source catkin
source devel/setup.bash

######################################################################

# start task
# roslaunch tasks bring_up.launch task:=Demo
#roslaunch tasks bring_up.launch task:=Inspection

# roslaunch tasks bring_up.launch task:=test_speech


# roslaunch tasks bring_up.launch task:=quiz
# roslaunch tasks bring_up.launch task:=PeopleRecognition
roslaunch tasks bring_up.launch task:=ManipulationAndObjectRecognition
# roslaunch tasks bring_up.launch task:=Receptionist
# roslaunch tasks bring_up.launch task:=ReceptionistOldSpeech
# roslaunch tasks bring_up.launch task:=Inspection
# roslaunch tasks bring_up.launch task:=TakeOutTheGarbage
