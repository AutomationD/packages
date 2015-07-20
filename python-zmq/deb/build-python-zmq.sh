#!/bin/bash
PROJECT_NAME='python-zmq'
VERSION='14.7.0'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
ARCH="mipsel"
INSTALL=$BUILD_DIR/deb
FILENAME=${PROJECT_NAME}_${VERSION}-${BUILD_NUMBER}_${ARCH}.deb

####
rm -rf $INSTALL/
mkdir -p $INSTALL/


echo "Installing ${PROJECT_NAME} via pip"
pip install --ignore-installed --install-option="--prefix=$INSTALL --zmq=/usr/lib/libzmq.so" pyzmq==$VERSION

cd $BUILD_DIR

# Package building
fpm -s dir -t deb -a $ARCH -n $PROJECT_NAME -v $VERSION --iteration $BUILD_NUMBER -C $INSTALL \
--description "$PROJECT_NAME $VERSION" \
--conflicts python-zmq \
usr


echo "Pushing to bintray"
curl -T $BUILD_DIR/${FILENAME} -ukireevco:$1 https://api.bintray.com/content/kireevco/debian/$PROJECT_NAME/$VERSION/$FILENAME