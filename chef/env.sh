#!/bin/bash

apt-get install -y bundler ruby ruby-dev git screen mc curl rubygems-integration
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
source ~/.bashrc