echo off

set ESPRESSIF_HOME=c:/Espressif
set CYGWIN_HOME=c:/tools/cygwin
::echo Installing Chocolatey
::@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
choco upgrade chocolatey
echo Configuring choco sources
choco sources add -name kireevco -source 'https://www.myget.org/F/kireevco-chocolatey/' -y


echo Enabling case sensitivity
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "obcaseinsensitive" /t REG_DWORD /d 0 /f

echo Installing Cygwin and Packages
::@powershell choco install cygwin -y --overrideArgs --installArgs '-q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin'
::@powershell choco install cygwin -y --overrideArgs --installArgs '-q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin --packages netcat,procps,git,gperf,bison,flex,patch,make,automake,gcc-tools-epoch2-automake,autoconf,autoconf2.5,libtool,subversion,gcc-core,gcc-g++,catgets,wget,findutils,libncursesw-devel,libncurses-devel,gettext,libexpat-devel,libintl-devel,libintl8,cygwin-devel'


::gcc-cygwin
choco install cygwin -y --overrideArgs --installArgs "-q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin --packages netcat,procps,git,gperf,bison,flex,patch,make,automake,autoconf,autoconf2.5,libtool,subversion,wget,findutils,libncursesw-devel,libncurses-devel,gettext,libexpat-devel,libintl-devel,libintl8,catgets,gcc-tools-epoch2-automake,libgcc1,gcc-core,gcc-g++"

::gcc-mingw:
::choco install cygwin -y --overrideArgs --installArgs "-q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin --packages netcat,procps,git,gperf,bison,flex,patch,make,automake,autoconf,autoconf2.5,libtool,subversion,wget,findutils,libncursesw-devel,libncurses-devel,gettext,libexpat-devel,libintl-devel,libintl8,catgets,gcc-tools-epoch2-automake,mingw-gcc-g++,mingw-gcc-core,mingw-gcc-src,libgcc1"

::c:\tools\cygwin\cygwinsetup.exe -q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin --packages mingw64-i686-gcc-g++,mingw64-i686-binutils-debuginfo,mingw64-i686-binutils,mingw64-i686-bzip2,mingw64-i686-gcc-core,mingw64-i686-gcc-g++,mingw64-i686-headers

::
::
::mingw-gcc-g++,gcc-core,gcc-g++'

echo saving current path
echo %PATH% > %CD%\path.save
::echo Set Path - making sure our path is short enough, otherwise cygwin will be slow
::set PATH="%PATH%;c:\tools\cygwin\bin;c:\tools\cygwin\sbin;c:\tools\cygwin\lib"

::setx /M PATH "c:\tools\cygwin\bin\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\ProgramData\chocolatey\bin;C:\Windows\System32\WindowsPowerShell\v1.0\;"



::echo Installing cyg-get chocolatey provider
::@powershell choco install cyg-get -y

::echo Installing required components
::choco install ^
:: git mingw32-base mingw32-mgwport mingw32-pdcurses mingw32-make mingw32-autoconf mingw32-automake mingw32-gdb ^
:: gdb automake make autoconf pdcurses gperf bison flex texinfo gawk ncurses libncurses-devel libexpat-dev wget libtool patch mktemp m4 mgwport gcc-core gcc-tools gcc-c++ libz bzip2 libintl-devel ^
:: msys-base msys-coreutils msys-gcc-bin msys-wget-bin msys-m4 msys-bison-bin msys-flex-bin msys-gawk msys-sed msys-autoconf msys-automake msys-mktemp msys-patch msys-libtool ^
:: -source cygwin

::z
::choco install git gperf bison flex patch make gcc-tools-epoch2-automake automake libtool subversion gcc-core gcc-g++ catgets wget findutils libncursesw-devel libncurses-devel gettext libexpat-devel -source cygwin::
::@powershell choco install -y git gperf bison flex patch make automake gcc-tools-epoch2-automake autoconf autoconf2.5 libtool subversion gcc-core gcc-g++ catgets wget findutils libncursesw-devel libncurses-devel gettext libexpat-devel -source cygwin
::c:\tools\cygwin\cygwinsetup.exe -q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin --packages netcat,procps git,gperf,bison,flex,patch,make,automake,gcc-tools-epoch2-automake,autoconf,autoconf2.5,libtool,subversion,gcc-core,gcc-g++,catgets,wget,findutils,libncursesw-devel,libncurses-devel,gettext,libexpat-devel



:::c:\tools\cygwin\cygwinsetup.exe -q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin --packages netcat,procps,git,gperf,bison,flex,patch,make,automake,autoconf,autoconf2.5,libtool,subversion,wget,findutils,libncursesw-devel,libncurses-devel,gettext,libexpat-devel,libintl-devel,libintl8,catgets,gcc-tools-epoch2-automake,^
::mingw-gcc-g++,mingw-gcc-core,mingw-gcc-src,libgcc1

::choco install libmpc libmpc-devel -source cygwin
::choco install mingw-gcc -source Cygwin
::??choco install mingw64-x86_64-gcc-g++ -source cygwin

::echo Adding cygwin aliases
::bash -c "echo \"alias find='/usr/bin/find'\" >> ~/.bashrc"
::bash -c "echo \"alias find='/usr/bin/find'\" >> /etc/bash.bashrc"

::bash -c "alias find='/usr/bin/find'"

::echo link mingw gcc to cygwin 
::bash -c 'cd /usr/bin && mv gcc.exe gcc-cygwin.exe'
::bash -c 'cd /usr/bin && ln -s i686-pc-mingw32-gcc.exe gcc.exe'

::bash -c 'cd /usr/bin && mv g++.exe g++-cygwin.exe'
::bash -c 'cd /usr/bin && ln -s i686-pc-mingw32-g++.exe g++.exe'

::alias find="/usr/bin/find"

echo Make sure to reboot your box  - we configured case sensitivity
PAUSE