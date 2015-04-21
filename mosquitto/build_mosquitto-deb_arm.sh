#!/bin/bash

BUILD_DIR=~/build
PACKAGE_SRC_DIR=~/package_src
PACKAGE_OUT_DIR=~/package_out
ARCH="armhf"

#######################################

echo "Installing prerequisites"
apt-get install make ruby1.9.1 ruby1.9.1-dev \
git-core libpcre3-dev libxslt1-dev libgd2-xpm-dev \
libgeoip-dev unzip zip build-essential gem \
uuid-dev xsltproc docbook-xsl cmake libc-ares-dev \
-y

# fpm installation
gem install fpm

mkdir -p $BUILD_DIR
mkdir -p $PACKAGE_SRC_DIR

##########################
##########################
##########################
package_version="1.3"
package_name="libwebsockets"
clone="git clone https://github.com/warmcat/libwebsockets.git"
echo "Building ${package_name}"
FPM_SRC_DIR="${PACKAGE_SRC_DIR}/${package_name}"
FPM_OUT_DIR="${PACKAGE_OUT_DIR}/${package_name}"
export DESTDIR=$FPM_SRC_DIR
mkdir -p $FPM_OUT_DIR
$FPM_OUT_FILE="${FPM_OUT_DIR}/${package_name}_${version}.deb"

cd $BUILD_DIR
rm -rf $package_name
###########################
$clone
cd $package_name
mkdir -p build
cd build
mkdir -p $DESTDIR
cmake .. -DCMAKE_INSTALL_PREFIX:PATH=$DESTDIR=/usr
# cmake .. -DOPENSSL_ROOT_DIR=/usr/local/ssl -DCMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE=/usr/local/ssl -DLWS_WITH_HTTP2=1
# cmake -DCMAKE_INSTALL_PREFIX:PATH=$DESTDIR ..

make
make install

# cd $FPM_SRC_DIR/usr/lib
# sudo mv 
# sudo ln -s ../local/lib/libwebsockets.so.5 libwebsockets.so.5
# sudo ln -s ../local/lib/libwebsockets.so.5 libwebsockets.so

echo "Creating package for ${package_name} "
cd $FPM_OUT_DIR
rm -rf $FPM_OUT_DIR/*
fpm -s dir -t deb -n ${package_name} -v ${package_version} --iteration 1 -C $FPM_SRC_DIR --description "${package_name} ${version}" usr
# -p $OUTDIR\

sudo dpkg -i $FPM_OUT_DIR/*.deb
# Exporting build flags for the next package

CPPFLAGS=''
export CPPFLAGS="$CPPFLAGS -I${BUILD_DIR}/${package_name}/lib"
export CPPFLAGS="$CPPFLAGS -I${BUILD_DIR}/${package_name}/build/lib"

##########################
##########################






##########################
##########################
package_version="1.4"
package_name="mosquitto"
clone="git clone https://git.eclipse.org/r/mosquitto/org.eclipse.mosquitto ${package_name}"
echo "Building ${package_name}"
FPM_SRC_DIR="${PACKAGE_SRC_DIR}/${package_name}"
FPM_OUT_DIR="${PACKAGE_OUT_DIR}/${package_name}"
export DESTDIR=$FPM_SRC_DIR
mkdir -p $FPM_OUT_DIR
$FPM_OUT_FILE="${FPM_OUT_DIR}/${package_name}_${version}.deb"
cd $BUILD_DIR
rm -rf $package_name
$clone
cd $package_name
git checkout origin/1.4
sed -ie 's/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/g' config.mk

make
make install

echo "Initializing directory structure & config files"
cd $FPM_SRC_DIR/etc/mosquitto
mv mosquitto.conf.example mosquitto.conf
mkir $FPM_SRC_DIR/var/log/mosquitto
mkir $FPM_SRC_DIR/var/run/mosquitto

mv $FPM_SRC_DIR/usr/local/bin $FPM_SRC_DIR/usr/bin
mv $FPM_SRC_DIR/usr/local/include $FPM_SRC_DIR/usr/include
mv $FPM_SRC_DIR/usr/local/lib $FPM_SRC_DIR/usr/lib
mv $FPM_SRC_DIR/usr/local/sbin $FPM_SRC_DIR/usr/sbin
mv $FPM_SRC_DIR/usr/local/share $FPM_SRC_DIR/usr/share
rm -rf $FPM_SRC_DIR/usr/local/



echo "Creating package for ${package_name} "
cd $FPM_OUT_DIR
rm -rf $FPM_OUT_DIR/*
fpm -s dir -t deb -n ${package_name} -v ${package_version} --iteration 1 -C $FPM_SRC_DIR --description "${package_name} ${version}" \
-d daemon \
-d libwebsockets \
usr etc
##########################
##########################