#!/bin/sh

# Install script for a server (Installs everything needed to run site on server)
git remote add latest https://github.com/CJBuchel/buchel.family.git
git pull latest master

sudo chmod +x install_server.sh
sudo ./install_server.sh