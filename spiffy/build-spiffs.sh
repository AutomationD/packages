######
PROJECT_NAME='test_project'
VERSION='1.0'
BUILD_NUMBER='1'
BUILD_DIR=$(pwd)
 
x00000='eagle.app.flash.bin'
x10000='eagle.irom0text.bin'
SPIFFS_DIR="$BUILD_DIR/files"
######
 
merged_file_name="${PROJECT_NAME}_merge.bin"
output_file_name="${PROJECT_NAME}_v${VERSION}.${BUILD_NUMBER}.bin"
main_firmware_offset=0x$(echo "obase=16; $(($(stat --format="%s" $BUILD_DIR/bin/${x00000})))" | bc)
spiff_start_offset=0x$(echo "obase=16; $((($(stat --format="%s" $BUILD_DIR/bin/${x00000}) + 16384) & (0xFFFFC000))) " | bc)

echo "Main firmware offset: $main_firmware_offset"
echo "Spiff start offset: $spiff_start_offset"

 
# Getting required packages
#sudo apt-get install -y python-serial srecord bc
 
 
################################################
# Building FW
# Setting env variables to build fw
# export PATH=$PATH:$PWD/esp-open-sdk/sdk:$PWD/esp-open-sdk/xtensa-lx106-elf/bin
 
# git clone https://github.com/anakod/Sming
# cd Sming/Basic_Blink
# make all
 
 
################################################
 
 
 
################################################
# Joining two bin files (expecting 0x00000.bin and 0x10000.bin)
################################################
cd $BUILD_DIR/bin
echo "Joining two firmware bin files"
srec_cat -redundant-bytes=ignore -output ${merged_file_name} -binary $x00000 -binary -fill 0xff 0x00000 0x10000 $x10000 -binary -offset 0x10000 > srec_cat.log

 
################################################
# Writing files to spiffs zone
################################################
 
# Building spiffy tool
mkdir $SPIFFS_DIR -p

echo "Cloning spiffy tool"
git clone https://github.com/xlfe/spiffy.git $BUILD_DIR/spiffy



echo "Patching spiffy to support Windows"
wget https://gist.githubusercontent.com/kireevco/0183f3ca9df19ce7f9d7/raw/abc2b65f3e0cf6036f074fa723411e6825baa17d/spiffs.h.patch -O $BUILD_DIR/spiffs.h.patch --no-check-certificate
wget https://gist.githubusercontent.com/kireevco/0183f3ca9df19ce7f9d7/raw/f3f056c97690ca3df0c1aeef1f6f4f30c8f9de8c/spiffs_hydrogen.c.patch -O $BUILD_DIR/spiffs_hydrogen.c.patch --no-check-certificate
wget https://gist.githubusercontent.com/kireevco/0183f3ca9df19ce7f9d7/raw/794d161fbececfd6b5ce9966f94708fc3ce0dc1c/spiffs_nucleus.h.patch -O $BUILD_DIR/spiffs_nucleus.h.patch --no-check-certificate
wget https://gist.githubusercontent.com/kireevco/0183f3ca9df19ce7f9d7/raw/20ed340149922ce18902ccdf37be900d86466eaf/main.c.patch -O $BUILD_DIR/main.c.patch --no-check-certificate
patch $BUILD_DIR/spiffy/src/spiffs.h < $BUILD_DIR/spiffs.h.patch
patch $BUILD_DIR/spiffy/src/spiffs_hydrogen.c < $BUILD_DIR/spiffs_hydrogen.c.patch
patch $BUILD_DIR/spiffy/src/spiffs_nucleus.h < $BUILD_DIR/spiffs_nucleus.h.patch
patch $BUILD_DIR/spiffy/src/main.c < $BUILD_DIR/main.c.patch

cd $BUILD_DIR/spiffy


mkdir build/
echo "Building spiffy"
make clean
make all
 
cd $BUILD_DIR
echo "Building spiff bin file"
"$BUILD_DIR/spiffy/build/spiffy"
 
mv $BUILD_DIR/spiff_rom.bin $BUILD_DIR/bin/${spiff_start_offset}.bin

echo "Building final bin file"
srec_cat -output $BUILD_DIR/bin/${output_file_name} -binary $BUILD_DIR/bin/$x00000 \
  -binary -fill 0xff $main_firmware_offset $spiff_start_offset $BUILD_DIR/bin/${spiff_start_offset}.bin \
  -binary -offset $spiff_start_offset >> srec_cat.log