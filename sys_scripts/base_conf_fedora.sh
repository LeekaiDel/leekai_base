#!/bin/bash
# Проверяем был ли запущен этот скрипт от имени администратора
[ $EUID -ne 0 ] && echo "Запустите: sudo $0" && exit 1

# Делаем ускорение DNF
grep -q "max_parallel_downloads" /etc/dnf/dnf.conf || echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
grep -q "fastestmirror" /etc/dnf/dnf.conf || echo "fastestmirror=true" >> /etc/dnf/dnf.conf
echo "DNF переконфигурирован для ускорения."

# Сразу конфигурим git
git config --global user.name "Leekai"
git config --global user.email leekai.dev@gmail.com

dnf upgrade --refresh -y

# Установите RPM Fusion (free и non-free)
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y --skip-unavailable nmap htop mc net-tools vim terminator

sudo usermod -a -G dialout $USER

# Установка github
sudo dnf install dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli

# Импортируйте ключ Microsoft GPG
rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Добавьте репозиторий VS Code
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# Обновите кэш и установите
dnf check-update -y
dnf install code -y
