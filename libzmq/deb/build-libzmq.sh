#!/bin/bash
PROJECT_NAME='libzmq'
VERSION='4.1.2'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
ARCH="mipsel"
INSTALL=$BUILD_DIR/zeromq-${VERSION}/build
FILENAME=${PROJECT_NAME}_${VERSION}-${BUILD_NUMBER}_${ARCH}.deb

####
apt-get install -y pkg-config ruby rubygems
gem install fpm
# echo "Downloading libsodium"
# git clone https://github.com/jedisct1/libsodium $BUILD/libsodium


echo "Downloading zeromq"
wget http://download.zeromq.org/zeromq-${VERSION}.tar.gz
tar -zxf zeromq-${VERSION}.tar.gz
cd zeromq-${VERSION}

rm -rf $INSTALL
mkdir -p $INSTALL
./configure --prefix=$INSTALL --with-libsodium=no


make && make install

cd $BUILD_DIR
# Package building
fpm -s dir -t deb -a $ARCH -n $PROJECT_NAME -v $VERSION --iteration $BUILD_NUMBER -C $INSTALL \
--description "$PROJECT_NAME $VERSION" \
--conflicts libzmq \
--conflicts libzmq1 \
--conflicts libzmq3 \
usr


echo "Pushing to bintray"
curl -T $BUILD_DIR/${FILENAME} -ukireevco:$1 https://api.bintray.com/content/kireevco/debian/$PROJECT_NAME/$VERSION/$FILENAME
