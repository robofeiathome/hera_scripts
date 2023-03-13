#!/bin/bash

# Check if script is running with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run this script with sudo"
  exit
fi

# Check if ROS Noetic is installed
if ! dpkg -s ros-noetic-desktop-full > /dev/null 2>&1; then
  echo "ROS Noetic is not installed. Please install it before running this script."
  exit
fi

# Check if bash or zsh is being used
if [ -n "$BASH_VERSION" ]; then
  SHELL="bash"
elif [ -n "$ZSH_VERSION" ]; then
  SHELL="zsh"
else
  echo "This script only supports bash and zsh."
  exit
fi

# Source ROS
source /opt/ros/noetic/setup."$SHELL"

# Prompt user to enter GitHub personal access token
echo "Please enter your GitHub personal access token:"
# shellcheck disable=SC2162
read -s TOKEN


# Create the catkin workspace
echo "Creating catkin workspace..."
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws || exit 1

catkin_make

# Source the workspace
source devel/setup."$SHELL"

# Clone the repositories from hera_robot
cd ~/catkin_ws/src || exit 1
mkdir -p hera_robot
cd hera_robot || exit 1

# List of repositories to clone
REPOS=(
  "robofeiathome/hera"
  "robofeiathome/hera_control"
  "robofeiathome/hera_description"
  "robofeiathome/hera_tasks"
  "robofeiathome/hera_telegram"
  "robofeiathome/hera_moveit_config"
)

# Clone the repositories
echo "Cloning hera_robot repositories..."
for REPO in "${REPOS[@]}"; do
  git clone "https://$TOKEN:x-oauth-basic@github.com/$REPO.git"
done

# Clone 3rd party repositories
cd ~/catkin_ws/src || exit 1
mkdir -p 3rd_party
cd 3rd_party || exit 1

# List of repositories to clone
REPOS=(
  "robofeiathome/hera_agent"
  "robofeiathome/robot_resources"
  "ros-drivers/hokuyo_node"
  "fagnerpimentel/map_server"
  "fagnerpimentel/social_move_base"
  "fagnerpimentel/social_msgs"
  "robofei-home/speech_recognition"
  "robofei-home/vision_system"
)

# Clone the repositories
echo "Cloning 3rd party repositories..."
for REPO in "${REPOS[@]}"; do
  git clone "https://$TOKEN:x-oauth-basic@github.com/$REPO.git"
done

# Get the dependencies from hera/dependencies.txt
echo "Getting dependencies..."
DEPENDENCIES=()
while IFS= read -r LINE; do
  DEPENDENCIES+=("$LINE")
done < ~/catkin_ws/src/hera_robot/hera/dependencies.txt

# Install dependencies
echo "Installing dependencies..."
for DEPENDENCY in "${DEPENDENCIES[@]}"; do
  apt-get install -y "$DEPENDENCY"
done

# Get the python dependencies from hera/requirements.txt
echo "Getting python dependencies..."
PYTHON_DEPENDENCIES=()
while IFS= read -r LINE; do
  PYTHON_DEPENDENCIES+=("$LINE")
done < ~/catkin_ws/src/hera_robot/hera/requirements.txt

echo "Done!"
