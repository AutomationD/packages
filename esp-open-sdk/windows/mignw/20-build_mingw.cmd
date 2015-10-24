echo Cloning esp-open-sdk recursively
git clone https://github.com/pfalcon/esp-open-sdk.git --recursive

echo Descending to esp-open-sdk
cd esp-open-sdk

echo Patching esp-open-sdk
:: bash -c "sed -i.bak '1s/^/gettext=\'$'\n/' crosstool-NG/kconfig/Makefile"
:: bash -c "sed -i.bak -e 's/[[:<:]]sed[[:>:]]/gsed/' Makefile"
:: bash -c "sed -i.bak -e 's/[[:<:]]awk[[:>:]]/\$(AWK)/' lx106-hal/src/Makefile.am"
:: bash -c "sed -i.bak 's/AM_PROG_AS/AM_PROG_AS\'$'\nAM_PROG_AR/' lx106-hal/configure.ac"

echo Patching nconf.c
:::::::::::::::::::
:::: This needs to go as a patch to Makefile of esp-open-sdk or after checkout
bash -c "sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./crosstool-NG/kconfig/nconf.c"
bash -c "sed -i 's/static int show_all_items;/static int show_all_items;\\nconst char *strcasestr(const char *s1, const char *s2);/g' ./crosstool-NG/kconfig/nconf.c"

::const char *strcasestr(const char *s1, const char *s2)
::{
:: // if either pointer is null
:: if (s1 == 0 || s2 == 0)
::  return 0;
:: // the length of the needle
:: size_t n = strlen(s2);
:: // iterate through the string
:: while(*s1)
:: // if the compare which is case insensitive is a match, return the pointer
:: if(!strncmpi(s1++,s2,n))
::  return (s1-1);
:: // no match was found
:: return 0;
::}


::: ADD strcasestr #10  http://www.geekdroppings.com/2014/03/16/cross-compiling-with-mingw-and-crosstool-ng/

echo Building gperf
bash -c "wget http://ftp.gnu.org/pub/gnu/gperf/gperf-3.0.4.tar.gz"
bash -c "tar -zxf gperf-3.0.4.tar.gz"
cd gperf-3.0.4
bash -c "./configure --prefix=/usr"
bash -c "make"
bash -c "make install"

cd ..
echo Building ncurses
:: Maybe just use a binary?
:: http://invisible-island.net/datafiles/release/mingw64.zip
::

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


:::crap
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::??make opt/esp-open-sdk in cygwin


::echo Patching fstab to be case-sensitive
::echo %ESPRESSIF_HOME%/esp-open-sdk /opt/esp-open-sdk ntfs posix=1 >> c:/tools/cygwin/etc/fstab
::bash -c 'mkdir -p /opt/esp-open-sdk'
::bash -c 'mount'


::bash -c "sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./test/tclock.c"
:::::::
::bash -c 'find . -name "nconf.c" -print0 | xargs sed -i "s/ESCDELAY = 1;/set_escdelay(1);/g"' 
::bash -c 'grep -rl " ESCDELAY = 1;" ./ | xargs sed -i "s/ESCDELAY = 1;/set_escdelay(1);/g"'
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