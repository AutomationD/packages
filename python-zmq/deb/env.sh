#!/bin/bash
echo "Installing packages."
apt-get install -y pkg-config ruby gem python-pip 
gem install fpm
# echo "Downloading libsodium"
# git clone https://github.com/jedisct1/libsodium $BUILD/libsodium
