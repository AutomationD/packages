@echo off

set ESPRESSIF_HOME=c:/Espressif
set CYGWIN_HOME=c:/tools/cygwin
echo Installing Chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

echo Enabling case sensitivity
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "obcaseinsensitive" /t REG_DWORD /d 0 /f

echo Installing MingGW
choco install mingw
choco install mingw-get

setx /M PATH "c:\tools\mingw64\bin\;%PATH%"
setx /M PATH "c:\tools\mingw64\include\;%PATH%"
setx /M PATH "c:\tools\mingw64\msys\1.0\bin\;%PATH%"
setx /M PATH "c:\tools\mingw64\msys\1.0\include\;%PATH%"


echo Installing Git
choco install git


echo Adding git to the path
setx /M PATH "%programfiles(x86)%\Git\bin;%PATH%"

::echo Installing cyg-get chocolatey provider
::choco install cyg-get -source 'https://www.myget.org/F/kireevco-chocolatey/'

echo Installing required components
::choco install ^
:: git mingw32-base mingw32-mgwport mingw32-pdcurses mingw32-make mingw32-autoconf mingw32-automake mingw32-gdb ^
:: gdb automake make autoconf pdcurses gperf bison flex texinfo gawk ncurses libncurses-devel libexpat-dev wget libtool patch mktemp m4 mgwport gcc-core gcc-tools gcc-c++ libz bzip2 libintl-devel ^
:: msys-base msys-coreutils msys-gcc-bin msys-wget-bin msys-m4 msys-bison-bin msys-flex-bin msys-gawk msys-sed msys-autoconf msys-automake msys-mktemp msys-patch msys-libtool ^
:: -source cygwin

::z
::choco install git gperf bison flex patch make automake libtool subversion gcc-core gcc-g++ catgets wget findutils libncursesw-devel libncurses-devel gettext libexpat-devel -source cygwin
mingw-get install mingw32-base mingw32-mgwport mingw32-pdcurses mingw32-make mingw32-autoconf mingw32-automake mingw-developer-toolkit ^
 mingw-developer-toolkit  mingw32-gdb gcc gcc-c++ libz bzip2 msys-base msys-coreutils msys-coreutils-ext msys-gcc-bin msys-wget-bin ^
 msys-m4 msys-bison-bin msys-flex-bin msys-gawk msys-regex msys-libregex msys-sed msys-autoconf msys-gperf msys-automake msys-mktemp msys-patch msys-libtool 

::choco install mingw-gcc -source cygwin
::??choco install mingw64-x86_64-gcc-g++ -source cygwin

echo Adding cygwin aliases
bash -c "echo \"alias find='/usr/bin/find'\" >> ~/.bashrc"
bash -c "echo \"alias find='/usr/bin/find'\" >> /etc/bash.bashrc"

bash -c "alias find='/usr/bin/find'"

::alias find="/usr/bin/find"