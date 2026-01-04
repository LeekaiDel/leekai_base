#!/bin/bash
sudo dnf upgrade --refresh -y

git config --global user.name "Leekai"
git config --global user.email leekai.dev@gmail.com

sudo dnf install -y --skip-unavailable nmap mc net-tools vim terminator
