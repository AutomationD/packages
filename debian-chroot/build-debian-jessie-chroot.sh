#!/bin/bash
PROJECT_NAME='debian-chroot'
VERSION='jessie'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
ARCH="mipsel"
######

FILENAME="${PROJECT_NAME}-${VERSION}-${ARCH}.tar.gz"

echo "Cleaning up old files"
rm -rf $BUILD_DIR/debian/*

mkdir -p $BUILD_DIR/debian/

echo "Generate chroot"
debootstrap --foreign --arch $ARCH $VERSION $BUILD_DIR/debian/ http://http.debian.net/debian/

echo "Creating $FILENAME"
tar -zcf $BUILD_DIR/$FILENAME $BUILD_DIR/debian/*


echo "Pushing to bintray"
curl -T $BUILD_DIR/$FILENAME -ukireevco:$1 https://api.bintray.com/content/kireevco/generic/$PROJECT_NAME/$VERSION/$FILENAME