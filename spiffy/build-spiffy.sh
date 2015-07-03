#!/bin/bash
######
PROJECT_NAME='spiffy'
VERSION='1.0.4'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
PLATFORM="linux"
ARCH="x86_64"
######

FILENAME="${PROJECT_NAME}-${VERSION}-${PLATFORM}-${ARCH}.tar.gz"
# Building spiffy tool

echo "Cloning spiffy tool"
rm -rf $BUILD_DIR/spiffy
git clone https://github.com/alonewolfx2/spiffy.git
cd spiffy

cd $BUILD_DIR/spiffy

mkdir build/

echo "Building spiffy"
make clean && make all

cd $BUILD_DIR/spiffy/build/
tar -zcf $FILENAME ./spiffy

echo "Pushing to bintray"
curl -T $FILENAME -ukireevco:$1 https://api.bintray.com/content/kireevco/generic/${PROJECT_NAME}/${VERSION}/${FILENAME} -k

cd $BUILD_DIR