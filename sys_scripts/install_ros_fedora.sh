#!/usr/bin/sh

# Установите инструменты разработки
#sudo dnf groupinstall "Development Tools"
sudo dnf install -y cmake gcc-c++ git wget

# Установите зависимости ROS 2
sudo dnf install -y python3-pip python3-rosdep
sudo dnf install -y assimp-devel bullet-devel libogg-devel libtheora-devel tinyxml2-devel openssl-devel

# Включите поддержку 32-битных библиотек (если нужно)
sudo dnf install -y glibc-devel.i686

# Установите дополнительные зависимости через pip
python3 -m pip install -U pip
python3 -m pip install colcon-common-extensions vcstool

# Создайте рабочую директорию
mkdir -p ~/ros2_jazzy/src
cd ~/ros2_jazzy

# Скачайте исходники ROS 2 Jazzy
wget https://raw.githubusercontent.com/ros2/ros2/jazzy/ros2.repos
vcs import src < ros2.repos

# Установите системные зависимости
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers"

# Основные переменные для сборки RPM в Fedora
export RPM_ARCH=$(uname -m)
export RPM_PACKAGE_NAME=ros2
export RPM_PACKAGE_VERSION=2.0
export RPM_PACKAGE_RELEASE=1.fc$(rpm -E %fedora)
export RPM_PACKAGE_VENDOR="ROS 2 Team"

# Или минимальный набор
#export RPM_PACKAGE_RELEASE=1
#export RPM_ARCH=x86_64


# Соберите ROS 2
colcon build --symlink-install

# Добавьте в .bashrc
echo "source ~/ros2_jazzy/install/local_setup.bash" >> ~/.bashrc
source ~/.bashrc
