#!/bin/bash
PROJECT_NAME='python-zmq'
PYLIB_NAME='pyzmq'
VERSION='14.7.0'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
ARCH="mipsel"
INSTALL="$BUILD_DIR/install"
BUILD_TEMP="$BUILD_DIR/build_temp"
FILENAME=${PROJECT_NAME}_${VERSION}-${BUILD_NUMBER}_${ARCH}.deb
###########


echo "Cleanup"
rm -rf $INSTALL/
mkdir -p $INSTALL/
rm -rf $BUILD_TEMP
mkdir -p $BUILD_TEMP
rm -rf $BUILD_DIR/*.deb

cd $BUILD_TEMP

echo "Creating directory structure"
mkdir -p $INSTALL/usr/share/pyshared/
mkdir -p $INSTALL/usr/lib/python2.7/dist-packages/
mkdir -p $INSTALL/usr/lib/python2.6/dist-packages/

echo "Installing ${PROJECT_NAME} via pip"
pip install --ignore-installed --install-option="--prefix=$INSTALL/usr" --install-option="--zmq=/usr" pyzmq==$VERSION

echo "Copying library to proper install paths"
cp -dR $INSTALL/usr/lib/python2.7/site-packages/zmq $INSTALL/usr/share/pyshared/
cp -dR $INSTALL/usr/lib/python2.7/site-packages/zmq $INSTALL/usr/lib/python2.7/dist-packages/
cp -dR $INSTALL/usr/lib/python2.7/site-packages/zmq $INSTALL/usr/lib/python2.6/dist-packages/


cd $BUILD_DIR
echo "Building Package via fpm"
fpm -s dir -t deb -a $ARCH -n $PROJECT_NAME -v $VERSION --iteration $BUILD_NUMBER -C $INSTALL \
--description "$PROJECT_NAME $VERSION" \
--conflicts python-zmq \
usr


echo "Pushing to bintray"
curl -T $BUILD_DIR/${FILENAME} -ukireevco:$1 https://api.bintray.com/content/kireevco/deb/$PROJECT_NAME/$VERSION/$FILENAME