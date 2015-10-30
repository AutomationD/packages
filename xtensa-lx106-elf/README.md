Install git & add it to a path:

```cmd
choco install git.install --params="/NoAutoCrlf" -y
```

Optionally install ConEmu

```cmd
choco install conemu -y
```

Optionally install imdisk for RamDisk from [here](http://reboot.pro/files/download/284-imdisk-toolkit/) or [here](http://files1.majorgeeks.com/de670c6775d17d4f699e427ab9260fa3/drives/ImDiskTk.exe)
```
wget http://files1.majorgeeks.com/de670c6775d17d4f699e427ab9260fa3/drives/ImDiskTk.exe
ImDiskTk.exe /fullsilent
```

Clone repo, configure environment
```cmd
git clone https://github.com/kireevco/packages.git
cd packages/xtensa-lx106-elf
10-env_mingw.cmd
```

Start build
```cmd
bash.exe -c "./build.sh"
```