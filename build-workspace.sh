#!/bin/bash

BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIBlue='\033[1;94m'       # Blue
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
Off='\033[0m'             # Text Reset

echo -e "${BIBlue}This script will build the catkin workspace for hera_robot.${Off}"
# Don't let user run this script as root
if [ "$EUID" -eq 0 ]; then
  echo -e "${BIRed}Please run this script as a normal user, not sudo.${Off}"
  exit
fi


# Check if ROS Noetic is installed
if ! dpkg -s ros-noetic-desktop-full > /dev/null 2>&1; then
  echo -e "${BIRed}ROS Noetic is not installed. Please install it before running this script!!${Off}"
  exit
fi

# Check if bash or zsh is being used
if [ -n "$BASH_VERSION" ]; then
  SHELL="bash"
elif [ -n "$ZSH_VERSION" ]; then
  SHELL="zsh"
else
  echo -e "${BIRed}This script only supports bash and zsh.${Off}"
  exit
fi

# Source ROS
source /opt/ros/noetic/setup."$SHELL"

# Set the user's home directory
HOME_DIR=/home/"$SUDO_USER"
# Set user's workspace directory
WORKSPACE_DIR=$HOME_DIR/catkin_ws

# Prompt user to enter GitHub personal access token
echo ""
echo -e "${BIBlue}Please enter your GitHub personal access token:${Off}"
# shellcheck disable=SC2162
read -s TOKEN

# Prompt user to enter GitHub username
echo ""
echo -e "${BIBlue}Please enter your GitHub username:${Off}"
# shellcheck disable=SC2162
read USERNAME

# Create the catkin workspace
echo ""
echo -e "${BICyan}Creating catkin workspace...${Off}"
mkdir -p $HOME_DIR/catkin_ws/src && cd $HOME_DIR/catkin_ws || exit 1
catkin_make

# Source the workspace
source $WORKSPACE_DIR/devel/setup."$SHELL"

# Clone the repositories from hera_robot
cd $WORKSPACE_DIR/src || exit 1
mkdir -p hera_robot && cd hera_robot || exit 1

# List of repositories to clone
REPOS=(
  "robofeiathome/hera"
  "robofeiathome/hera_control"
  "robofeiathome/hera_description"
  "robofeiathome/hera_lowlevel"
  "robofeiathome/hera_nav"
  "robofeiathome/hera_simulation"
  "robofeiathome/hera_tasks"
  "robofeiathome/hera_telegram"
  "robofeiathome/hera_speech"
  "robofeiathome/hera_moveit_config"
  "robofeiathome/hera_scripts"
)

# Clone the repositories
echo -e "${BIWhite}Cloning hera_robot repositories...${Off}"
for REPO in "${REPOS[@]}"; do
  git clone "https://$USERNAME:$TOKEN@github.com/$REPO.git"
done

# Clone 3rd party repositories
echo -e "${BIWhite}Cloning 3rd party repositories...${Off}"
cd $WORKSPACE_DIR/src || exit 1
mkdir -p 3rd_party && cd 3rd_party || exit 1

# List of repositories to clone
REPOS=(
  "robofeiathome/hera_agent"
  "robofeiathome/robot_resources"
  "ros-drivers/hokuyo_node"
  "robofeiathome/map_server"
  "fagnerpimentel/social_move_base"
  "fagnerpimentel/social_msgs"
  "robofei-home/speech_recognition"
  "robofeiathome/detector_2d"
  "robofeiathome/hera_face"
  "robofeiathome/hera_objects"
  "robofeiathome/posture_analysis"
  "robofeiathome/track_flow"
)

# Clone the repositories
echo -e "${BIWhite}Cloning 3rd party repositories...${Off}"
for REPO in "${REPOS[@]}"; do
  git clone "https://$USERNAME:$TOKEN@github.com/$REPO.git"
done

# Get the dependencies from hera/dependencies.txt
echo -e "${BICyan}Getting dependencies...${Off}"
DEPENDENCIES=()
while IFS= read -r LINE; do
  DEPENDENCIES+=("$LINE")
done < $WORKSPACE_DIR/src/hera_robot/hera_scripts/dependencies.txt

# Install dependencies
echo -e "${BIBlue}Installing dependencies...${Off}"
for DEPENDENCY in "${DEPENDENCIES[@]}"; do
  sudo apt-get install -y "$DEPENDENCY"
done

# Get the python dependencies from hera/requirements.txt
echo -e "${BICyan}Getting python dependencies...${Off}"
PYTHON_DEPENDENCIES=()
while IFS= read -r LINE; do
  PYTHON_DEPENDENCIES+=("$LINE")
done < $WORKSPACE_DIR/src/hera_robot/hera_scripts/requirements.txt

# Install python dependencies
echo -e "${BIBlue}Installing python dependencies...${Off}"
for PYTHON_DEPENDENCY in "${PYTHON_DEPENDENCIES[@]}"; do
  pip3 install "$PYTHON_DEPENDENCY"
done

echo -e "${BIGreen}Done!${Off}"