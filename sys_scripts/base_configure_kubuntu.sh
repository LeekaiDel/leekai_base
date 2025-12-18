#!/bin/bash
sudo apt update && sudo apt upgrade -y

sudo apt install nmap mc net-tools vim ssh build-essential 

git config --global user.name "Leekai"
git config --global user.email leekai.dev@gmail.com

sudo snap install code --classic
