#!/usr/bin/bash

# Скачиваем и устанавливаем Gazebo для 3D симуляции
sudo apt update
sudo apt install -y curl lsb-release gnupg

sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
sudo apt update
sudo apt -y install gz-jetty

# Скачиваем и устанавливаем PX4-Autopilot
git clone https://github.com/PX4/PX4-Autopilot.git ~/PX4-Autopilot --recursive
~/PX4-Autopilot/Tools/setup/ubuntu.sh

# Установка MAVSDK для работы с mavlink на C++
wget https://github.com/mavlink/MAVSDK/releases/download/v3.0.0/libmavsdk-dev_3.0.0_ubuntu24.04_amd64.deb
sudo dpkg -i libmavsdk-dev_3.0.0_ubuntu24.04_amd64.deb
