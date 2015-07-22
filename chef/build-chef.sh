#!/bin/bash
PROJECT_NAME='chef'
BUILD_DIR=$(pwd)
#########
# export CROSS_COMPILE=mipsel-linux-gnu-
# export ARCH="mipsel"

rm -rf omnibus-chef
git clone https://github.com/chef/omnibus-chef
cd omnibus-chef
bundle install --without development


bundle exec omnibus build chef

# echo "Pushing to bintray"
# curl -T $BUILD_DIR/${FILENAME} -ukireevco:$1 https://api.bintray.com/content/kireevco/debian/$PROJECT_NAME/$VERSION/$FILENAME
