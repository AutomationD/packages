#!/bin/bash
######
PROJECT_NAME='esp-open-sdk'
VERSION='1.1.2'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
PLATFORM="linux"
ARCH="x86_64"
######

FILENAME="${PROJECT_NAME}-${VERSION}-${PLATFORM}-${ARCH}.tar.gz"

echo "Cloning $PROJECT_NAME"
rm -rf $BUILD_DIR/$PROJECT_NAME
git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
cd $BUILD_DIR/$PROJECT_NAME

echo "Building $PROJECT_NAME"
make STANDALONE=y

cd $BUILD_DIR/$PROJECT_NAME
tar -zcf $BUILD_DIR/$FILENAME ./esp_iot_sdk_v*/ ./esptool* ./sdk ./xtensa-lx106-elf

echo "Pushing to bintray"
curl -T $FILENAME -ukireevco:$1 https://api.bintray.com/content/kireevco/generic/${PROJECT_NAME}/${VERSION}/${FILENAME} -k

cd $BUILD_DIR