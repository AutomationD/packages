ESP_HOME=$PWD
BUILD_DIR=$PWD/esp-open-sdk
# PATH=c:\tools\cygwin\bin

echo Cloning esp-open-sdk recursively
git clone https://github.com/pfalcon/esp-open-sdk.git --recursive

echo Descending to esp-open-sdk
cd esp-open-sdk

echo Patching fstab to be case-sensitive
echo $ESP_HOME/esp-open-sdk /opt/esp-open-sdk ntfs posix=1 >> c:/tools/cygwin/etc/fstab
mkdir -p /opt/esp-open-sdk
mount


echo Patching nconf.c
sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./crosstool-NG/kconfig/nconf.c


patch $BUILD_DIR/crosstool-NG/kconfig/Makefile < $BUILD_DIR/../patches/kconfig.patch
echo Running make
make STANDALONE=y --debug

# make STANDALONE=y CPPFLAGS="-I/usr/local/include/"
