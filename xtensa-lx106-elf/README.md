
## Windows

Install git:
```cmd
choco install git.install --params="/NoAutoCrlf" -y
```

Install ConEmu (Optional)
```cmd
choco install conemu -y
```

Install imdisk(Optional)
```
wget http://files1.majorgeeks.com/de670c6775d17d4f699e427ab9260fa3/drives/ImDiskTk.exe
ImDiskTk.exe /fullsilent
r:
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

## MacOS
Clone repo, configure environment
```shell
git clone https://github.com/kireevco/packages.git
cd packages/xtensa-lx106-elf
./10-env_macos.sh
```

Start build
```shell
./build.sh
```


## Linux
Clone repo, configure environment
```shell
git clone https://github.com/kireevco/packages.git
cd packages/xtensa-lx106-elf
./10-env_linux.sh
```

Start build
```shell
./build.sh
```