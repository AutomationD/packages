set BUILD_HOME=c:/tools/cygwin/mnt/case-sensitive


echo Cloning esp-open-sdk recursively
git clone https://github.com/pfalcon/esp-open-sdk.git --recursive

echo Descending to esp-open-sdk
cd esp-open-sdk

echo Patching fstab to be case-sensitive
echo %BUILD_HOME% /mnt/case-sensitive ntfs posix=1 >> c:/tools/cygwin/etc/fstab
bash -c 'mkdir -p /mnt/case-sensitive'
bash -c 'mount'


echo Patching nconf.c
bash -c "sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./crosstool-NG/kconfig/nconf.c"




echo Running make
bash -c 'make STANDALONE=y --debug'

::bash -c 'make STANDALONE=y CPPFLAGS="-I/usr/local/include/" '

::echo Installing Eclipse
::choco install eclipse-cpp -source 'https://www.myget.org/F/kireevco-chocolatey/'