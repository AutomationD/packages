Install git & add it to a path:

```
choco install git --params="/GitAndUnixToolsOnPath /NoAutoCrlf" -y
```

Optionally install ConEmu

```
choco install conemu -y
```


Clone repo, configure environment
```
git clone https://github.com/kireevco/packages.git
cd packages/esp-open-sdk/windows/cygwin
10-env_cygwin.cmd
```

Start build
```
20-build_cygwin.cmd
```