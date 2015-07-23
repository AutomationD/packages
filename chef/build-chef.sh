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
rm -rf ${PROJECT_NAME}_*.deb
git clone https://github.com/chef/omnibus-chef
cd omnibus-chef
git checkout $VERSION

bundle install --without development
bundle exec omnibus build chef

echo "Patching for ${ARCH}"
cd $BUILD_DIR/omnibus-chef/pkg
mkdir -p ${PROJECT_NAME}_repack
dpkg-deb -x ${PROJECT_NAME}_*.deb ${PROJECT_NAME}_repack
dpkg-deb -e ${PROJECT_NAME}_*.deb ${PROJECT_NAME}_repack/DEBIAN

# if [[ $(uname -n) == "debian-${ARCH}" ]]
# then
  sed -i "s/Architecture: mips\b/Architecture: mipsel/g" ${BUILD_DIR}/omnibus-chef/pkg/${PROJECT_NAME}_repack/DEBIAN/control  
# fi


dpkg-deb -b ${PROJECT_NAME}_repack ${PROJECT_NAME}_${VERSION}-${BUILD_NUMBER}_${ARCH}.deb

# echo "Pushing to bintray"
curl -T ${PROJECT_NAME}_${VERSION}-${BUILD_NUMBER}_${ARCH}.deb -ukireevco:$1 https://api.bintray.com/content/kireevco/deb/$PROJECT_NAME/$VERSION/$FILENAME
