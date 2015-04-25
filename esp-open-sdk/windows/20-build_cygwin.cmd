set ESPRESSIF_HOME=c:/Espressif

echo Cloning esp-open-sdk recursively
"c:\Program Files (x86)\Git\cmd\git.exe" clone https://github.com/pfalcon/esp-open-sdk.git --recursive

echo Descending to esp-open-sdk
cd esp-open-sdk

echo Patching fstab to be case-sensitive
echo %ESPRESSIF_HOME%/esp-open-sdk /opt/esp-open-sdk ntfs posix=1 >> c:/tools/cygwin/etc/fstab
bash -c 'mkdir -p /opt/esp-open-sdk'
bash -c 'mount'


echo Patching nconf.c
bash -c "sed -i 's/ESCDELAY = 1;/set_escdelay(1);/g' ./crosstool-NG/kconfig/nconf.c"




echo Running make
bash -c 'make STANDALONE=y --debug'

::bash -c 'make STANDALONE=y CPPFLAGS="-I/usr/local/include/" '

::echo Installing Eclipse
::choco install eclipse-cpp -source 'https://www.myget.org/F/kireevco-chocolatey/'