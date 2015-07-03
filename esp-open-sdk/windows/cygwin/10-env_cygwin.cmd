@echo off

set ESPRESSIF_HOME=c:/Espressif
set CYGWIN_HOME=c:/tools/cygwin
echo Installing Chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

echo Enabling case sensitivity
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "obcaseinsensitive" /t REG_DWORD /d 0 /f

echo Installing Cygwin
choco install cygwin -y --overrideArgs --installArgs "-q -R C:\tools\cygwin -l C:\tools\cygwin\packages -s http://mirrors.kernel.org/sourceware/cygwin"

echo saving current path
echo %PATH% > %CD%\path.save
echo Set Path - making sure it is short enought
::set PATH="%PATH%;c:\tools\cygwin\bin;c:\tools\cygwin\sbin;c:\tools\cygwin\lib"

setx /M PATH "c:\tools\cygwin\bin\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\ProgramData\chocolatey\bin;C:\Windows\System32\WindowsPowerShell\v1.0\;"

echo Installing cyg-get chocolatey provider
choco install cyg-get -y

echo Installing required components
::choco install ^
:: git mingw32-base mingw32-mgwport mingw32-pdcurses mingw32-make mingw32-autoconf mingw32-automake mingw32-gdb ^
:: gdb automake make autoconf pdcurses gperf bison flex texinfo gawk ncurses libncurses-devel libexpat-dev wget libtool patch mktemp m4 mgwport gcc-core gcc-tools gcc-c++ libz bzip2 libintl-devel ^
:: msys-base msys-coreutils msys-gcc-bin msys-wget-bin msys-m4 msys-bison-bin msys-flex-bin msys-gawk msys-sed msys-autoconf msys-automake msys-mktemp msys-patch msys-libtool ^
:: -source cygwin

::z
::choco install git gperf bison flex patch make gcc-tools-epoch2-automake automake libtool subversion gcc-core gcc-g++ catgets wget findutils libncursesw-devel libncurses-devel gettext libexpat-devel -source cygwin
cyg-get gperf bison flex patch make automake gcc-tools-epoch2-automake autoconf autoconf2.5 libtool subversion gcc-core gcc-g++ catgets wget findutils libncursesw-devel libncurses-devel gettext libexpat-devel

::choco install libmpc libmpc-devel -source cygwin
::choco install mingw-gcc -source Cygwin
::??choco install mingw64-x86_64-gcc-g++ -source cygwin

echo Adding cygwin aliases
bash -c "echo \"alias find='/usr/bin/find'\" >> ~/.bashrc"
bash -c "echo \"alias find='/usr/bin/find'\" >> /etc/bash.bashrc"

bash -c "alias find='/usr/bin/find'"

::alias find="/usr/bin/find"