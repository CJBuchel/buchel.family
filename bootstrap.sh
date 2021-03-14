#!/bin/sh

sudo mkdir /var/www
sudo chmod +x /var/www/*


# Install script for a server (Installs everything needed to run site on server)
sudo apt-get install git
sudo git clone https://github.com/CJBuchel/buchel.family.git /var/www/buchel.family
sudo cd /var/www/buchel.family

sudo git remote add latest https://github.com/CJBuchel/buchel.family.git
sudo git pull latest master

sudo chmod +x install_server.sh
sudo ./install_server.sh