#!/bin/bash
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

cd ~/
if [ -d $(xcode-select -p) ]; then
  echo "Xcode is installed"
else
  echo "Installing Xcode"
  curl -L -o xcode-6.2-cmd-tools.pkg https://www.dropbox.com/s/1t7ux39sccxqfwx/xcode-6.2-cmd-tools.pkg\?dl\=0
  installer -pkg ~/xcode-6.2-cmd-tools.pkg -target / && rm -rf xcode-6.2-cmd-tools.pkg
fi


##### Create a case-sensitive partition
files=$(ls /Volumes/case-sensitive* 2> /dev/null | wc -l)
if [ "$files" != "0" ]; then
  echo "Unmounting /Volumes/case-sensitive*"
  umount /Volumes/case-sensitive*
fi

if [ -f ~/case-sensitive.dmg ]; then
  echo "Removing ~/case-sensitive.dmg"
  rm -rf ~/case-sensitive.dmg
fi

echo "Creating new ~/case-sensitive.dmg"
hdiutil create ~/case-sensitive.dmg -volname "case-sensitive" -size 10g -fs "Case-sensitive HFS+"

echo "Mounting ~/case-sensitive.dmg"
hdiutil mount ~/case-sensitive.dmg