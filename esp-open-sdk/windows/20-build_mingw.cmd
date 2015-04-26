echo Cloning esp-open-sdk recursively
git clone https://github.com/pfalcon/esp-open-sdk.git --recursive

echo Descending to esp-open-sdk
cd esp-open-sdk

echo Patching nconf.c
bash -c "sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./crosstool-NG/kconfig/nconf.c"


echo Building gperf
bash -c "wget http://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz"
bash -c "tar -zxf gperf-3.0.4.tar.gz"
bash -c "cd gperf-3.0.4 && ./configure --prefix=/usr && make && make install"

echo Building ncurses
bash -c "wget http://invisible-island.net/datafiles/release/ncurses.tar.gz"
bash -c "tar -zxf ncurses.tar.gz"
cd ncurses-*
bash -c "sed -i 's/#include <curses.priv.h>/#include <curses.priv.h>\\n#include <sys\/time.h>/g' ./ncurses/win32con/gettimeofday.c"
bash -c "sed -i 's/void \*tz GCC_UNUSED/struct timezone \*tz/g' ./ncurses/win32con/gettimeofday.c"
bash -c "sed -i 's/#include <curses.priv.h>/#include <curses.priv.h>\\n#include <windows.h>\\n#define ATTACH_PARENT_PROCESS (DWORD)-1/g' ./ncurses/win32con/win_driver.c"

bash -c "sed -i 's/double fraction = 0.0;//g' ./test/tclock.c"
bash -c "sed -i 's/setlocale/double fraction = 0.0;\\nsetlocale/g' ./test/tclock.c"


bash -c "./configure --enable-term-driver --enable-sp-funcs --prefix=/usr --without-ada"
bash -c "make"
bash -c "make install"
::bash -c "wget http://invisible-island.net/datafiles/release/mingw64.zip"
::bash -c "unzip mingw64.zip -d /"




::??make opt/esp-open-sdk in cygwin


::echo Patching fstab to be case-sensitive
::echo %ESPRESSIF_HOME%/esp-open-sdk /opt/esp-open-sdk ntfs posix=1 >> c:/tools/cygwin/etc/fstab
::bash -c 'mkdir -p /opt/esp-open-sdk'
::bash -c 'mount'


::bash -c 'grep -rl "ESCDELAY = 1;" ./ | xargs sed -i "s/ESCDELAY = 1;/set_escdelay(1);/g"'
::bash -c 'find . -type f -name "nconf.c" -exec sed -i"" -e "s/ESCDELAY = 1;/set_escdelay(1);/g" {} \;'
::find . -name Root -exec sed -i 's/1.2.3.4\/home/foo.com\/mnt/' {} \;
::bash -c "find . -name 'nconf.c' -print0 | xargs -0 sed -i '' -e 's/ESCDELAY = 1;/set_escdelay(1);/g'"
::bash -c 'find . -name "nconf.c" -print0 | xargs -0 sed -i "" -e "s/ESCDELAY = 1;/set_escdelay(1)/g"'
::start "make" /high "m.cmd"

cd ..
echo Running make
bash -c 'make STANDALONE=y'

::bash -c 'make STANDALONE=y CPPFLAGS="-I/usr/local/include/" '

::echo Installing Eclipse
::choco install eclipse-cpp -source 'https://www.myget.org/F/kireevco-chocolatey/'