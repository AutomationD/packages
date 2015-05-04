@echo off

set ESPRESSIF_HOME=c:/Espressif
echo Upgrading Chocolatey
choco update chocolatey
::@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

echo Add repository
choco sources add -name kireevco -source 'https://www.myget.org/F/kireevco-chocolatey/'

echo Installing wget
choco install wget -y

echo Installing MingGW-get (pulls down mingw too)
choco install mingw-get -y

echo Adding ENV variables

setx /M HOME "c:\Users"
setx /M PATH "c:\tools\mingw64\bin\;%PATH%" && set PATH=c:\tools\mingw64\bin\;%PATH%
setx /M PATH "c:\tools\mingw64\include\;%PATH%" && set PATH=c:\tools\mingw64\include\;%PATH%
setx /M PATH "c:\tools\mingw64\msys\1.0\bin\;%PATH%" && set PATH=c:\tools\mingw64\msys\1.0\bin\;%PATH%
setx /M PATH "c:\tools\mingw64\msys\1.0\include\;%PATH%" && set PATH=c:\tools\mingw64\msys\1.0\include\;%PATH%

::echo Enabling case sensitivity (???not required with mingw & msys)
::REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "obcaseinsensitive" /t REG_DWORD /d 0 /f

echo Installing required mingw components

mingw-get install mingw32-base mingw32-mgwport mingw32-pdcurses mingw32-make mingw32-autoconf mingw32-automake mingw-developer-toolkit ^
 mingw-developer-toolkit  mingw32-gdb gcc gcc-c++ libz bzip2 msys-base msys-coreutils msys-coreutils-ext msys-gcc-bin msys-wget-bin ^
 msys-m4 msys-bison-bin msys-bison msys-flex msys-flex-bin msys-gawk msys-make msys-regex msys-libregex msys-sed msys-autoconf msys-gperf msys-automake msys-mktemp msys-patch msys-libtool 

::choco install mingw-gcc -source cygwin
::??choco install mingw64-x86_64-gcc-g++ -source cygwin

echo Adding aliases
bash -c "echo \"alias find='/usr/bin/find'\" >> ~/.bashrc"
bash -c "echo \"alias find='/usr/bin/find'\" >> /etc/bash.bashrc"

bash -c "alias find='/usr/bin/find'"

::alias find="/usr/bin/find"