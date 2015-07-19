#!/bin/bash
PROJECT_NAME='debian-chroot'
VERSION='wheezy-recent'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
ARCH="mipsel"
######

FILENAME="${PROJECT_NAME}-${VERSION}-${ARCH}.tar"

echo "Preparing chroot image"
cd $BUILD_DIR/debian/


cd $BUILD_DIR
echo "Creating $FILENAME"
tar -cf $BUILD_DIR/$FILENAME ./debian/*

gzip $BUILD_DIR/$FILENAME


echo "Pushing to bintray"
curl -T $BUILD_DIR/${FILENAME}.gz -ukireevco:$1 https://api.bintray.com/content/kireevco/generic/$PROJECT_NAME/$VERSION/$FILENAME