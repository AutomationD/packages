Install git & add it to a path:

```cmd
choco install git.install --params="/NoAutoCrlf" -y --force
```

Optionally install ConEmu

```cmd
choco install conemu -y
```

Optionally install imdisk for RamDisk from [here](http://reboot.pro/files/download/284-imdisk-toolkit/) or http://reboot.pro/files/getdownload/13881-imdisk-toolkit/

Clone repo, configure environment
```cmd
git clone https://github.com/kireevco/packages.git
cd packages/esp-open-sdk/windows/cygwin
10-env_cygwin.cmd
```

Start build
```cmd
20-build_cygwin.cmd
```