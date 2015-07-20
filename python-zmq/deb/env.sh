#!/bin/bash
echo "Installing packages."
apt-get install -y pkg-config ruby gem python-pip 
gem install fpm
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc
# echo "Downloading libsodium"
# git clone https://github.com/jedisct1/libsodium $BUILD/libsodium
