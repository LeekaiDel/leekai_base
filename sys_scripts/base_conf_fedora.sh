#!/bin/bash
sudo dnf upgrade --refresh -y

git config --global user.name "Leekai"
git config --global user.email leekai.dev@gmail.com

# Установите RPM Fusion (free и non-free)
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y --skip-unavailable nmap mc net-tools vim terminator
