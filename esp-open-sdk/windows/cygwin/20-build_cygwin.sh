ESP_HOME=$PWD
BUILD_DIR=$PWD/esp-open-sdk
# PATH=c:\tools\cygwin\bin

echo Cloning esp-open-sdk recursively
git clone https://github.com/pfalcon/esp-open-sdk.git --recursive


# echo Patching nconf.c
# sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./crosstool-NG/kconfig/nconf.c

echo "Patching stuff"
patch esp-open-sdk/crosstool-NG/kconfig/nconf.c < patches/kconfig-nconf.c.patch
patch esp-open-sdk/crosstool-NG/kconfig/Makefile < patches/kconfig-Makefile.patch

echo Descending to esp-open-sdk
cd esp-open-sdk

echo Patching fstab to be case-sensitive
echo $ESP_HOME/esp-open-sdk /opt/esp-open-sdk ntfs posix=1 >> c:/tools/cygwin/etc/fstab
mkdir -p /opt/esp-open-sdk
mount



###### TODO Apply patches from 'patches' dir...

# export CC=/usr/bin/i686-w64-mingw32-gcc.exe
# export CXX=/usr/bin/i686-w64-mingw32-g++.exe
# export LDFLAGS="-L/usr/lib" CFLAGS="-I/usr/include" CXXFLAGS="-I/usr/include" CPPFLAGS="-I/usr/include"

# export C_INCLUDE_PATH=/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/include:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/include-fixed:/usr/include:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../lib/../include/w32api:$C_INCLUDE_PATH
# export LIBRARY_PATH=/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../x86_64-pc-cygwin/lib/../lib/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../lib/:/lib/../lib/:/usr/lib/../lib/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../x86_64-pc-cygwin/lib/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../:/lib/:/usr/lib/:$LIBRARY_PATH

#make --host=i686-w64-mingw32
## CYGWIN
# /usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../x86_64-pc-cygwin/lib/../lib/../../include/w32api
# /usr/lib/gcc/i686-w64-mingw32/4.9.2/include
#  /usr/lib/gcc/i686-w64-mingw32/4.9.2/include-fixed
#  /usr/i686-w64-mingw32/sys-root/mingw/include
# LIBRARY_PATH=/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../x86_64-pc-cygwin/lib/../lib/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../lib/:/lib/../lib/:/usr/lib/../lib/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../x86_64-pc-cygwin/lib/:/usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../:/lib/:/usr/lib/

# ## MINGW
#  /usr/lib/gcc/x86_64-pc-cygwin/5.2.0/include
#  /usr/lib/gcc/x86_64-pc-cygwin/5.2.0/include-fixed
#  /usr/include
#  /usr/lib/gcc/x86_64-pc-cygwin/5.2.0/../../../../lib/../include/w32api
#  LIBRARY_PATH=/usr/lib/gcc/i686-w64-mingw32/4.9.2/:/usr/lib/gcc/i686-w64-mingw32/4.9.2/../../../../i686-w64-mingw32/lib/../lib/:/usr/i686-w64-mingw32/sys-root/mingw/lib/../lib/:/usr/lib/gcc/i686-w64-mingw32/4.9.2/../../../../i686-w64-mingw32/lib/:/usr/i686-w64-mingw32/sys-root/mingw/lib/

### NEW:


# patch https://raw.githubusercontent.com/jcmvbkbc/crosstool-NG/b38a1d4cb9f0179a1da5c210e476aa2c9229bb94/local-patches/gcc/5.1.0/0001-WIP-don-t-bring-extra-u-int_least32_t-into-std.patch

# echo Building gperf
# wget http://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz
# tar -zxf gperf-3.0.4.tar.gz
# cd gperf-3.0.4
# ./configure --prefix=/usr
# make
# make install

wget http://invisible-island.net/datafiles/release/ncurses.tar.gz
tar -zxf ncurses.tar.gz

cd ncurses-*
sed -i 's/#include <curses.priv.h>/#include <curses.priv.h>\\n#include <sys\/time.h>/g' ./ncurses/win32con/gettimeofday.c
sed -i 's/void \*tz GCC_UNUSED/struct timezone \*tz/g' ./ncurses/win32con/gettimeofday.c
sed -i 's/#include <curses.priv.h>/#include <curses.priv.h>\\n#include <windows.h>\\n#define ATTACH_PARENT_PROCESS (DWORD)-1/g' ./ncurses/win32con/win_driver.c

sed -i 's/double fraction = 0.0;//g' ./test/tclock.c
sed -i 's/setlocale/double fraction = 0.0;\\nsetlocale/g' ./test/tclock.c


./configure --enable-term-driver --enable-sp-funcs --prefix=/usr --without-ada
## ./configure --enable-term-driver --enable-sp-funcs --without-ada --prefix=/usr/i686-w64-mingw32/sys-root/mingw --host=i686-w64-mingw32

make
make install


echo Running make
make STANDALONE=y --debug

# make STANDALONE=y CPPFLAGS="-I/usr/local/include/"
