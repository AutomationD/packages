#!/usr/bin/env bash
#... crosstoolng
PROJECT_NAME='opencv'
VERSION=3.2.0
PYTHON_VERSION=3.4
NUMPY_VERSION=1.8.0
BUILD_DIR=$(pwd)
PLATFORM="linux"
ARCH="armhf"
INSTALL="${BUILD_DIR}/dist"
ITERATION=1
FILENAME="${PROJECT_NAME}_${VERSION}-${ITERATION}_${ARCH}.deb"
####

sudo apt install -y build-essential cmake pkg-config libjpeg-dev zlib1g-dev libtiff5-dev libjasper-dev libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libgtk2.0-dev gfortran libgtk2.0-dev
sudo apt install -y python2.7-dev python3-dev python3-pip python-pip git
sudo pip install virtualenv virtualenvwrapper
sudo apt install -y ruby ruby-dev
sudo gem install fpm
#####

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

#####
mkvirtualenv cv -p python3
workon cv
pip install numpy==1.8.2


mkdir -p ~/build && cd ~/build


git clone -b ${VERSION} https://github.com/opencv/opencv_contrib.git
git clone -b ${VERSION} https://github.com/opencv/opencv.git


cd opencv
mkdir -p build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=./dist/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..

make -j 4
make install


mv $INSTALL/usr/local/lib/python${PYTHON_VERSION}/site-packages $INSTALL/usr/local/lib/python${PYTHON_VERSION}/dist-packages
FILES=$(cd $INSTALL && find . -type f | sed "s|^\./||")

fpm -s dir -t deb -n opencv -v ${VERSION} -C $INSTALL --iteration 1 --package $FILENAME \
  --description "opencv ${VERSION}" \
  --depends python3-numpy \
  --depends libgtk2.0 \
  --depends libavcodec-extra-56 \
  --depends libavformat56 \
  --depends libswscale3 \
  --conflicts opencv \
  --conflicts libcv2.4 \
  --conflicts libopencv-contrib \
  --deb-no-default-config-files \
$FILES

echo "Pushing to bintray"
curl -T $BUILD_DIR/$FILENAME -ukireevco:${BINTRAY_SECRET} https://api.bintray.com/content/kireevco/deb/$PROJECT_NAME/$VERSION/$FILENAME

