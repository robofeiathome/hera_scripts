#!/bin/bash

# instalar ROS

# colors
Green='\033[0;32m'  # Green
NC='\033[0m'        # No Color

distribution=${1:-noetic} 
echo -e "$Green Installing Home Environment Robot Assistant (HERA) for ${distribution^^} ROS distribution. $NC"

sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y python3
sudo apt-get install -y python3-pip
sudo apt-get install -y iproute2

declare -a hera_repositories=(
    "https://github.com/Home-Environment-Robot-Assistant/hera.git"
    "https://github.com/Home-Environment-Robot-Assistant/hera_description.git"
    "https://github.com/Home-Environment-Robot-Assistant/hera_moveit_config.git"
    "https://github.com/Home-Environment-Robot-Assistant/hera_control.git"
    # "https://github.com/Home-Environment-Robot-Assistant/hera_telegram.git"
    # "https://github.com/Home-Environment-Robot-Assistant/hera_tasks.git"
)

declare -a others_repositories=(
    "https://github.com/fagnerpimentel/agent.git"
    "https://github.com/fagnerpimentel/map_server.git"
    "https://github.com/fagnerpimentel/social_move_base.git"
    "https://github.com/fagnerpimentel/social_msgs.git"
    "https://github.com/robofei-home/speech_recognition.git"
    "https://github.com/fagnerpimentel/worlds.git"
    "https://github.com/fagnerpimentel/robot_resources.git"
    "https://github.com/ros-drivers/hokuyo_node.git"
)

mkdir src
mkdir src/hera_robot
mkdir src/3rdParty

# chmod +rwx src/
# chmod +rwx src/hera_robot
# chmod +rwx src/3rdParty

cd src/hera_robot
for repo in ${hera_repositories[@]}; do
   echo $repo
   git clone $repo
done
# chmod +rwx *
cd ../..

cd src/3rdParty
for repo in ${others_repositories[@]}; do
   echo $repo
   git clone $repo
done
# chmod +rwx *
cd ../..

files=`find . -type f -name "install_dependencies.sh"`
for file in $files; do
    sudo chmod +x $file
    sudo $file $distribution
done

# catkin_make

## rodar os comandos a seguir em abas separadas: ##
# ./start_simulation.sh
# ./start_robot.sh
# ./start_interface.sh
# ./start_task.sh
