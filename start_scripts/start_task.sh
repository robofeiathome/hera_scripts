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
# roslaunch tasks bring_up.launch task:=Inspection
# roslaunch tasks bring_up.launch task:=TakeOutTheGarbage_1
# roslaunch tasks bring_up.launch task:=LARC_Receptionist
# roslaunch tasks bring_up.launch task:=LARC_TakeOutTheGarbage
#roslaunch tasks bring_up.launch task:=TDP_Garbage
# roslaunch tasks bring_up.launch task:=LARC_Manipulation
# roslaunch tasks bring_up.launch task:=recep
# roslaunch tasks bring_up.launch task:=quiz
#roslaunch tasks bring_up.launch task:=PeopleRecog
# roslaunch tasks bring_up.launch task:=FollowMe
# roslaunch tasks bring_up.launch task:=save_local_test
# roslaunch tasks bring_up.launch task:=ServingDrinks
# roslaunch tasks bring_up.launch task:=SticklerForTheRules
 #roslaunch tasks bring_up.launch task:=DomesticEmergency
# roslaunch tasks bring_up.launch task:=teste_mic
# roslaunch tasks bring_up.launch task:=teste-obr
# roslaunch tasks bring_up.launch task:=teste_octomap
# roslaunch tasks bring_up.launch task:=nav_teste
# roslaunch tasks bring_up.launch task:=teste_tampa
# roslaunch tasks bring_up.launch task:=TakeOutTeste
#roslaunch tasks bring_up.launch task:=LARC_Speech
roslaunch tasks bring_up.launch task:=TDP_Receptionist

