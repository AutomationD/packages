
BUILD_DIR=$PWD/esp-open-sdk
echo "Cloning esp-open-sdk recursively"
git clone https://github.com/pfalcon/esp-open-sdk.git --recursive

echo "Descending to esp-open-sdk"
cd $BUILD_DIR



# sed -i.bak '1s/^/gettext=\'$'\n/' crosstool-NG/kconfig/Makefile
# sed -i.bak 's/AM_PROG_AS/AM_PROG_AS\'$'\nAM_PROG_AR/' lx106-hal/configure.ac

echo "Patching nconf.c"
sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./crosstool-NG/kconfig/nconf.c


echo "Building gperf"
wget http://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz
tar -zxf gperf-3.0.4.tar.gz
cd gperf-3.0.4
./configure --prefix=/usr && make && make install

cd ..
echo "Building ncurses"
wget http://invisible-island.net/datafiles/release/ncurses.tar.gz
tar -zxf ncurses.tar.gz

cd ncurses-*
sed -i 's/#include <curses.priv.h>/#include <curses.priv.h>\\n#include <sys\/time.h>/g' ./ncurses/win32con/gettimeofday.c
sed -i 's/void \*tz GCC_UNUSED/struct timezone \*tz/g' ./ncurses/win32con/gettimeofday.c
sed -i 's/#include <curses.priv.h>/#include <curses.priv.h>\\n#include <windows.h>\\n#define ATTACH_PARENT_PROCESS (DWORD)-1/g' ./ncurses/win32con/win_driver.c

sed -i 's/double fraction = 0.0;//g' ./test/tclock.c
sed -i 's/setlocale/double fraction = 0.0;\\nsetlocale/g' ./test/tclock.c


./configure --enable-term-driver --enable-sp-funcs --prefix=/usr --without-ada && make && make install

# wget http://invisible-island.net/datafiles/release/mingw64.zip
#unzip mingw64.zip -d /




# ??make opt/esp-open-sdk in cygwin


#echo "Patching fstab to be case-sensitive"
#echo "$ESPRESSIF_HOME/esp-open-sdk /opt/esp-open-sdk ntfs posix=1 >> c:/tools/cygwin/etc/fstab"
#mkdir -p /opt/esp-open-sdk
#mount
# echo "Patching esp-open-sdk"
patch $BUILD_DIR/crosstool-NG/kconfig/Makefile <  $BUILD_DIR/../patches/kconfig.patch # refer to https://sourceware.org/ml/crossgcc/2013-08/msg00049.html



grep -rl "ESCDELAY = 1;" ./ | xargs sed -i "s/ESCDELAY = 1;/set_escdelay(1);/g"
find . -type f -name "nconf.c" -exec sed -i"" -e "s/ESCDELAY = 1;/set_escdelay(1);/g" {} \;
# find . -name Root -exec sed -i 's/1.2.3.4\/home/foo.com\/mnt/' {} \;
find . -name 'nconf.c' -print0 | xargs -0 sed -i '' -e 's/ESCDELAY = 1;/set_escdelay(1);/g'
# find . -name "nconf.c" -print0 | xargs -0 sed -i "" -e "s/ESCDELAY = 1;/set_escdelay(1)/g"
# start "make" /high "m.cmd"

cd ..
echo "Running make"
make STANDALONE=y

# ::bash -c 'make STANDALONE=y CPPFLAGS="-I/usr/local/include/" '

# ::echo Installing Eclipse
# ::choco install eclipse-cpp -source 'https://www.myget.org/F/kireevco-chocolatey/'