#!/bin/bash
PROJECT_NAME='debian-chroot'
VERSION='wheezy'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
ARCH="mipsel"
######

FILENAME="${PROJECT_NAME}-${VERSION}-${ARCH}.tar.gz"

echo "Preparing chroot image"
cd $BUILD_DIR/debian/


cd $BUILD_DIR
echo "Creating $FILENAME"
tar -zcf $BUILD_DIR/$FILENAME ./debian/*


echo "Pushing to bintray"
curl -T $BUILD_DIR/$FILENAME -ukireevco:$1 https://api.bintray.com/content/kireevco/generic/$PROJECT_NAME/$VERSION/$FILENAME