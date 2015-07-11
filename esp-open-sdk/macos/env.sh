#!/bin/bash
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

cd ~/
curl -L -o xcode-6.2-cmd-tools.pkg https://www.dropbox.com/s/1t7ux39sccxqfwx/xcode-6.2-cmd-tools.pkg\?dl\=0
installer -pkg ~/xcode-6.2-cmd-tools.pkg -target /

##### Install build toolchain
umount /Volumes/case-sensitive
hdiutil create ~/case-sensitive.dmg -volname "case-sensitive" -size 10g -fs "Case-sensitive HFS+"
hdiutil mount ~/case-sensitive.dmg