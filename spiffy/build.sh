######
PROJECT_NAME='test_project'
VERSION='1.0'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)

######
# Building spiffy tool

echo "Cloning spiffy tool"
rm -rf $BUILD_DIR/spiffy
git clone https://github.com/alonewolfx2/spiffy.git
cd spiffy
git checkout sming

# echo "Patching spiffy to support Windows"
# patch $BUILD_DIR/spiffy/src/spiffs.h < $BUILD_DIR/spiffs.h.patch
# patch $BUILD_DIR/spiffy/src/spiffs_hydrogen.c < $BUILD_DIR/spiffs_hydrogen.c.patch
# patch $BUILD_DIR/spiffy/src/spiffs_nucleus.h < $BUILD_DIR/spiffs_nucleus.h.patch
# patch $BUILD_DIR/spiffy/src/main.c < $BUILD_DIR/main.c.patch

cd $BUILD_DIR/spiffy

mkdir build/

export PATH=/C/tools/mingw64/msys/1.0/bin:/C/tools/mingw64/bin:$PATH

echo "Building spiffy"
make clean && make all

# echo "Installing spiffy to $SYSTEMROOT"
# cp "$BUILD_DIR/spiffy/build/spiffy" $SYSTEMROOT/System32/
