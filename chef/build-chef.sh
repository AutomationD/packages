#!/bin/bash
PROJECT_NAME='chef'
BUILD_DIR=$(pwd)
VERSION="12.3.0.rc.0"
BUILD_NUMBER='1'
ARCH="mipsel"
FILENAME="${PROJECT_NAME}_${VERSION}-${BUILD_NUMBER}_${ARCH}.deb"
#########
# export CROSS_COMPILE=mipsel-linux-gnu-
# export ARCH="mipsel"

rm -rf omnibus-chef
rm -rf ${PROJECT_NAME}_*-${BUILD_NUMBER}_${ARCH}.deb
git clone https://github.com/chef/omnibus-chef
cd omnibus-chef
git checkout $VERSION

bundle install --without development


bundle exec omnibus build chef

# echo "Pushing to bintray"
curl -T $(ls ${PROJECT_NAME}_*-${BUILD_NUMBER}_${ARCH}.deb) -ukireevco:$1 https://api.bintray.com/content/kireevco/deb/$PROJECT_NAME/$VERSION/$FILENAME
